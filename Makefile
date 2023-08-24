SHELL=/bin/bash
.SUFFIXES:
default:

.PHONY: create-labs

STUDENT_EDITABLE_FILES=seven_seg_solution.hpp config.make
PRIVATE_FILES=Assignment.key.ipynb admin .git solution bad-solution

COMPILER=$(CXX) 
MICROBENCH_OPTIMIZE= -DHAVE_LINUX_PERF_EVENT_H -I$(PWD) -g $(C_OPTS)
LIBS= -lm -pthread -lboost_program_options -L/usr/lib/ -lboost_system -ldl
BUILD=build/

OPTIMIZE+=-march=x86-64
COMPILER=g++-9
include config.make

.PHONY: autograde
autograde: seven_seg.exe 
	./seven_seg.exe -M 3600 -o bench.csv -s 33554432 -f seven_seg_solution_c
	./seven_seg.exe -M 3600 -o correctness.csv -v -s 256 32768 262144 -f seven_seg_solution_c

.PRECIOUS: $(BUILD)%.cpp
.PRECIOUS: $(BUILD)%.s
.PRECIOUS: $(BUILD)%.hpp

$(BUILD)perfstats.o: perfstats.c perfstats.h
	mkdir -p $(BUILD) 
	cp  $< $(BUILD)$<
	$(COMPILER) -DHAVE_LINUX_PERF_EVENT_H -O3 -I$(PWD) $(LIBS) -o $(BUILD)perfstats.o -c $(BUILD)perfstats.c


$(BUILD)%.s: $(BUILD)%.cpp
	mkdir -p $(BUILD) 
#	cp  $< $(BUILD)$<
	$(COMPILER) $(MICROBENCH_OPTIMIZE) $(LIBS) -S $(BUILD)$*.cpp

$(BUILD)%.so: $(BUILD)%.cpp
	mkdir -p $(BUILD) 
	cp *.hpp $(BUILD)
	cp *.h   $(BUILD)
	$(COMPILER)  -DHAVE_LINUX_PERF_EVENT_H $(MICROBENCH_OPTIMIZE) $(LIBS) -rdynamic -fPIC -shared -o $(BUILD)$*.so $(BUILD)$*.cpp
#	$(COMPILER) $(MICROBENCH_OPTIMIZE) $(LIBS) -c -fPIC -o $(BUILD)$*.o $(BUILD)$*.cpp

$(BUILD)%.cpp: %.cpp
	cp $< $(BUILD)
	cp *.hpp $(BUILD)

        
$(BUILD)seven_seg.o : OPTIMIZE=$(MATEXP_OPTIMIZE)
$(BUILD)seven_seg.s : OPTIMIZE=$(MATEXP_OPTIMIZE)
$(BUILD)seven_seg_main.o : OPTIMIZE=$(MATEXP_OPTIMIZE)

seven_seg.exe:  $(BUILD)seven_seg_main.o  $(BUILD)seven_seg.o $(BUILD)perfstats.o
	$(COMPILER) $(MATEXP_OPTIMIZE) $(BUILD)seven_seg_main.o  $(BUILD)perfstats.o $(BUILD)seven_seg.o -o seven_seg.exe

$(BUILD)run_tests.o : OPTIMIZE=-O3

$(BUILD)%.o: %.cpp
	mkdir -p $(BUILD)
	cp *.hpp $(BUILD) 
	cp  $< $(BUILD)$<
	$(COMPILER)  -DHAVE_LINUX_PERF_EVENT_H $(MATEXP_OPTIMIZE) $(MICROBENCH_OPTIMIZE) $(LIBS) -o $(BUILD)$*.o -c $(BUILD)$*.cpp


fiddle.exe:  $(BUILD)fiddle.o $(FIDDLE_OBJS) $(BUILD)perfstats.o
	$(COMPILER) $(MICROBENCH_OPTIMIZE)  -DHAVE_LINUX_PERF_EVENT_H $(BUILD)fiddle.o $(BUILD)perfstats.o $(FIDDLE_OBJS) $(LIBS) -o fiddle.exe

array_sort.exe:  $(BUILD)array_sort.o $(BUILD)calculate_sum.o $(BUILD)perfstats.o
	$(COMPILER) -O0  -DHAVE_LINUX_PERF_EVENT_H $(BUILD)array_sort.o $(BUILD)perfstats.o $(BUILD)calculate_sum.o $(LIBS) -o array_sort.exe


#-include $(DJR_JOB_ROOT)/$(LAB_SUBMISSION_DIR)/config.make
clean: 
	rm -f *.exe $(BUILD)*
