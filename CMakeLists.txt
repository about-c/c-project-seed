cmake_minimum_required(VERSION 2.8.9)

project (hello)

include_directories(include)

file(GLOB SOURCES "src/*.c")

add_executable(hello ${SOURCES})
