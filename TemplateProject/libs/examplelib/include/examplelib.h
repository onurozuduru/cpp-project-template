class ExampleLib {
public:
    ExampleLib();
    ExampleLib(ExampleLib&&) = default;
    ExampleLib(const ExampleLib&) = default;
    ExampleLib& operator=(ExampleLib&&) = default;
    ExampleLib& operator=(const ExampleLib&) = default;
    ~ExampleLib() = default;

    int addSecretNumber(int number);

private:
    int secretNumber;
};
