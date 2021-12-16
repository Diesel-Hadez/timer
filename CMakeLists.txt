cmake_minimum_required(VERSION 3.0)

find_package(Qt5 REQUIRED COMPONENTS Gui Qml Quick Widgets)
set(CMAKE_AUTOMOC ON)

project(timer LANGUAGES CXX)

qt5_add_resources(timer_SRCS resources.qrc)
add_executable(timer main.cpp ${timer_SRCS})

target_link_libraries(timer Qt5::Qml Qt5::Gui Qt5::Quick Qt5::Widgets)
