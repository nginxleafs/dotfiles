class Calculator:
    def __init__(self, num1, num2):
        self.num1 = num1
        self.num2 = num2

    def add(self):
        return self.num1 + self.num2

    def sub(self):
        return self.num1 - self.num2

    def mul(self):
        return self.num1 * self.num2

    def div(self):
        return self.num1 / self.num2


def main():
    print("enter the first number")
    num1 = int(input())
    print("enter the second number")
    num2 = int(input())
    calculator = Calculator(num1, num2)
    print("enter the operation you want to perform")
    print("1 - addition")
    print("2 - subtraction")
    print("3 - multiplication")
    print("4 - division")
    operation = input()
    if operation == "1":
        print(calculator.add())
    elif operation == "2":
        print(calculator.sub())
    elif operation == "3":
        print(calculator.mul())
    elif operation == "4":
        print(calculator.div())
    else:
        print("invalid operation")


if __name__ == "__main__":
    main()
