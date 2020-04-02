# ------------------------------------------------------------------------
# Using this form of makefile is sufficient for most small scale projects
#
# Commands:
# 	$ make 			// default build
# 	$ make clean 	// clean up
#
# ------------------------------------------------------------------------

# Project name and target executable program
PROJECT=foo

# Defines path to include, object and source directories
INCLUDE_DIR=./include
BUILD_DIR=./build
SOURCE_DIR=./src

# Directory for local libraries
# LIB_DIR=./lib
# LIBS=-lm

# Defines the compiler to use in the build process. Ex. gcc, clang
CC=gcc

# Defines flags to pass to the compiler
CFLAGS = -I $(INCLUDE_DIR)

# constant: list all dependencies .c source files need
_DEPS = hello.h
DEPS = $(patsubst %, $(INCLUDE_DIR)/%, $(_DEPS))

# constant: list all object files as part to the build
_OBJ = main.o hello.o
OBJ = $(patsubst %, $(BUILD_DIR)/%, $(_OBJ))


# Defines the command to use for the clean up rule
CLEAN=rm -rf 	# Unix, Linux
# CLEAN=del /f 	# Windows


# Generate object files
#
# The rule applies to all files ending in *.o in which *.o files depends
# on *.c source and files included in DEPS macro. This allows recompile
# even if header files are modified.
#
# The -c flag says to generate the object file, the -o $@ says to put the
# output of the compilation in the file named on the left side of the :,
# the $< is the first item in the dependencies list, and the CFLAGS macro
# is defined as above.
$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)


# Link object files to executable
#
# Use the special macros $@ and $^, which are the left and right sides of
# the :, respectively. $@ is the name of the executable file and $^ lists
# the object files to link.
$(PROJECT): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)


# Clean up BUILD_DIR directories
#
# Uses phony target to avoid a conflict with a file of the same name,
# and to improve performance.
.PHONY: clean
clean:
	$(CLEAN) $(BUILD_DIR)/*.o $(PROJECT)
