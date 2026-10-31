#include <iostream>
#include "app.h"

static int failures = 0;

static void check(bool cond, const char* msg) {
    if (!cond) {
        std::cerr << "FAIL: " << msg << "\n";
        ++failures;
    }
}

int main() {
    check(add(1, 2) == 3, "add(1,2) == 3");
    check(add(-1, 1) == 0, "add(-1,1) == 0");

    if (failures == 0) {
        std::cout << "All tests passed\n";
        return 0;
    }
    return 1;
}