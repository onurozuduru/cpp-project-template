#include <examplelib.h>

int abc(int a) { return a + 3; }

ExampleLib::ExampleLib()
    : secretNumber { 3 }
{
}

int ExampleLib::addSecretNumber(int number) { return number + secretNumber; }
