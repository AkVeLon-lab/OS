/CXX = g++
CXXFLAGS = -O2 -Wall -std=c++17
INCLUDES = -Iinclude

all: bin/fibo

bin/fibo: obj/main.o obj/fibonacci.o
	@mkdir -p bin
	$(CXX) $(CXXFLAGS) -o bin/fibo obj/main.o obj/fibonacci.o

obj/main.o: src/main.cpp include/fibonacci.h
	@mkdir -p obj
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c src/main.cpp -o obj/main.o

obj/fibonacci.o: src/fibonacci.cpp include/fibonacci.h
	@mkdir -p obj
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c src/fibonacci.cpp -o obj/fibonacci.o

clean:
	rm -rf obj bin
.PHONY: all clean