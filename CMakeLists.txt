cmake_minimum_required(VERSION 3.16)
project(cpp-app LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 核心逻辑抽成库，供主程序和测试复用
add_library(app_lib src/app.cpp)
target_include_directories(app_lib PUBLIC src)

# 主程序
add_executable(app src/main.cpp)
target_link_libraries(app PRIVATE app_lib)

# 测试
enable_testing()
add_executable(test_app test/test_app.cpp)
target_link_libraries(test_app PRIVATE app_lib)
add_test(NAME test_app COMMAND test_app)