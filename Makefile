INC_DIR	= ./Valkyrie/include
SRC_DIR = ./Valkyrie/src
OBJ_DIR	= ./Valkyrie/object

SRC_FILES = $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES = $(SRC_FILES:.cpp=.o)
OBJ_PATH  = $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(OBJ_FILES))

LIBS= 
CC=clang++
CFLAGS=-g -O0 `llvm-config --cxxflags --ldflags --system-libs --libs core mcjit native bitwriter`

all: init mushroomcloud valkyrie

init:
	mkdir -p ./bin
	mkdir -p MushroomCloud/bin

mushroomcloud:
	javac -d MushroomCloud/bin/ -cp MushroomCloud/src:"MushroomCloud/lib/*" -sourcepath MushroomCloud/src MushroomCloud/src/edu/buffalo/cse562/Main.java
	jar cvfm bin/MushroomCloud.jar MushroomCloud/Manifest.txt -C MushroomCloud/bin/ .
	cp -a MushroomCloud/lib/. ./bin/

valkyrie:
	$(CC) $(SRC_DIR)/*.cpp $(CFLAGS) -o bin/llvmruntime -I$(INC_DIR)

clean:
	rm -r MushroomCloud/bin
	rm -r ./bin
