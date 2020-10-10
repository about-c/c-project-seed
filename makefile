# ------------------------------------------------------------------------
# Using this form of makefile is sufficient for most small scale projects
#
# Commands:
# 	$ make 			// default build
# 	$ make clean 	// delete object files only
# 	$ make cleanall	// delete object files and executable program
# 	$ make help
#
# ------------------------------------------------------------------------

# Default build file(s) and dependencies
PROJECT_NAME = hello
HEADER_FILES = hello.h
OBJECT_FILES = main.o hello.o



# Default directories for include, object and source
BUILD_DIR	 = ./build
LIBRARY_DIR	 = ./lib
INCLUDE_DIR	 = ./include
SOURCE_DIR	 = ./src



# Defines the compiler to use in the build process. Ex. gcc, clang
CC=gcc

# Defines flags to pass to the compiler
CFLAGS = -I $(INCLUDE_DIR) -Wall -Wextra -pedantic

# List all dependencies .c source files need
DEPS = $(patsubst %, $(INCLUDE_DIR)/%, $(HEADER_FILES))

# List all object files as part to the build
OBJ = $(patsubst %, $(BUILD_DIR)/%, $(OBJECT_FILES))

# Defines the command to use remove (Unix) files
CLEAN = rm -rf

# Optional library flags
LIBS = -lm



# ------------------------------------------------------------------------
# Targets Starts Here
# ------------------------------------------------------------------------



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
$(PROJECT_NAME): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)



# Remove .o files only
#
# Uses phony target to avoid a conflict with a file of the same name,
# and to improve performance.
.PHONY: cl
cl:
	$(CLEAN) $(BUILD_DIR)/*.o



# Remove .o and executable files
#
# Uses phony target to avoid a conflict with a file of the same name,
# and to improve performance.
.PHONY: cleanall
cleanall:
	$(CLEAN) $(BUILD_DIR)/*.o $(PROJECT_NAME)



# Display help information
#
help:
	@echo "USAGE: make [option]"
	@echo "\t- clean \t delete object files only"
	@echo "\t- cleanall \t delete object files and executable program"


# end
