import 'dart:collection';
import 'dart:math';

import 'package:formz/formz.dart';
import 'package:stack/stack.dart';

enum SearchValidationError { invalid }

class Input extends FormzInput<String, SearchValidationError> {
  const Input.pure([super.value = '']) : super.pure();
  const Input.dirty([super.value = '']) : super.dirty();

  static final _inputRegex = RegExp(
    r'^([-+/*]\d+(\.\d+)?)*',
  );

  @override
  SearchValidationError? validator(String? value) {
    return _inputRegex.hasMatch(value ?? '')
        ? null
        : SearchValidationError.invalid;
  }
}

double? evaluateExpression(String expression) {
  Queue<String> output = Queue<String>();
  Stack<String> operators = Stack<String>();
  print(expression);

  Map<String, int> precedence = {
    "+": 1,
    "-": 1,
    "*": 2,
    "/": 2,
    "^": 3,
    "(": 0
  };

  int i = 0;
  while (i < expression.length) {
    String token = expression[i];

    if (isDigit(token)) {
      String number = token;
      while (i + 1 < expression.length && isDigit(expression[i + 1])) {
        i++;
        number += expression[i];
      }
      output.add(number);
    } else if (isOperator(token)) {
      while (operators.isNotEmpty &&
          precedence[token]! <= precedence[operators.top()]!) {
        output.add(operators.pop());
      }
      operators.push(token);
    } else if (token == "(") {
      operators.push(token);
    } else if (token == ")") {
      while (operators.top() != "(") {
        output.add(operators.pop());
        if (operators.isEmpty) {
          print("Error: Mismatched parentheses");
          return null;
        }
      }
      operators.pop();
    } else if (token == " ") {
      // Ignore spaces
    } else {
      print("Error: Invalid character");
      return null;
    }

    i++;
  }
  print(output.toString());
  print(operators);
  while (operators.isNotEmpty) {
    String operator = operators.pop();
    if (operator == "(") {
      print("Error: Mismatched parentheses");
      return null;
    }
    output.add(operator);
  }
  print(output.toString());
  Stack<double> values = Stack<double>();

  for (String token in output) {
    if (isDigit(token[0])) {
      values.push(double.parse(token));
    } else if (isOperator(token)) {
      if (values.length < 2) {
        print("Error: Invalid expression");
        return null;
      }
      double operand2 = values.pop();
      double operand1 = values.pop();
      num? result = applyOperator(token, operand1, operand2);
      values.push(result!.toDouble());
    }
  }

  if (values.length != 1) {
    print("Error: Invalid expression");
    return null;
  }

  return values.pop();
}

bool isDigit(String token) {
  return double.tryParse(token) != null;
}

bool isOperator(String token) {
  return "+-*/^".contains(token);
}

num? applyOperator(String operator, double operand1, double operand2) {
  switch (operator) {
    case "+":
      return operand1 + operand2;
    case "-":
      return operand1 - operand2;
    case "*":
      return operand1 * operand2;
    case "/":
      return operand1 / operand2;
    case "^":
      return pow(operand1, operand2);
    default:
      return null;
  }
}


