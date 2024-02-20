#include <string>

struct Logger {
    std::string context {};
    void log(const std::string& message);
};
