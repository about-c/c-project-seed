# ------------------------------------------------------------------------
# Using this form of makefile is sufficient for most small scale projects
#
# Commands:
# 	$ make 			// default build
# 	$ make clean 	// clean up
#
# ------------------------------------------------------------------------


# Defines the compiler to use in the build process
CC=clang

# Defines flags to pass to the compiler
CFLAGS=-I .

# Defines dependency files which .c source files need
DEPS=hello.h

# Defines -o flag and the name of the executable file
OUTFILE=-o hello

# Defines the command to use for the clean up rule
CLEAN=rm -rf 	# Unix, Linux
# CLEAN=del /f 	# Windows


# Generate object files
#
# The rule applies to all files ending in *.o in which *.o files depends
# on *.c source and files included in DEPS macro.
#
# The -c flag says to generate the object file, the -o $@ says to put the
# output of the compilation in the file named on the left side of the :,
# the $< is the first item in the dependencies list, and the CFLAGS macro
# is defined as above.
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)


# link object files to executable
main: main.o hello.o
	$(CC) $(OUTFILE) main.o hello.o


# Does clean up, removing .o and executable files
clean:
	$(CLEAN) *.o hello
