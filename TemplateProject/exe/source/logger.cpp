#include <iostream>
#include <logger.h>

void Logger::log(const std::string& message)
{
    std::cout << context << ": " << message << std::endl;
}
