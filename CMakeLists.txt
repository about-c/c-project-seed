cmake_minimum_required(VERSION 3.1)

# sets the project name
project (hello)

include_directories(include)

file(GLOB SOURCES "src/*.c")

add_executable(hello ${SOURCES})
