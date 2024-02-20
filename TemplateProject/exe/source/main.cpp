#include <examplelib.h>
#include <logger.h>
#include <string>

int main(int argc, char* argv[])
{
    Logger logger { "Main" };
    logger.log("Hello world!");

    auto example = ExampleLib {};
    auto withSecret = example.addSecretNumber(5);

    logger.log("5 + SECRET = " + std::to_string(withSecret));
    return 0;
}
