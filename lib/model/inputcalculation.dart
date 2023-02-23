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

bool isDigit(String token) {
  return double.tryParse(token) != null;
}
convertPostFix(List<String> tokens) {
  List<String> answer = [];
  List<String> optrStack = [];
  List<String> ops = [
    "+",
    "-",
    "*",
    "/",
    "%",
    "^"
  ];
  Map<String, int> precedence = {
    "+": 1,
    "-": 1,
    "*": 2,
    "/": 2,
    "%": 2,
    "^": 3
  };
  for(var i=0; i<tokens.length; i++) {
    if(isDigit(tokens[i])) {
      answer.add(tokens[i]);
    } else if(ops.contains(tokens[i])) {
      while (optrStack.length > 0 && optrStack[optrStack.length-1] != "(" && precedence[optrStack[optrStack.length -1]]! >= precedence[tokens[i]]!) {
        if(optrStack.length > 0) {
          answer.add(optrStack.last);
          optrStack.removeLast();
        }
      }
      optrStack.add(tokens[i]);
    } else if(tokens[i] == "(") {
      optrStack.add(tokens[i]);
    } else if(tokens[i] == ")") {
      while (optrStack.length > 0 && optrStack[optrStack.length-1] != "(") {
        if(optrStack.length > 0) {
          answer.add(optrStack.last);
          optrStack.removeLast();
        }
      }
      if(optrStack[optrStack.length -1] == "(") {
        if(optrStack.length > 0) {
          optrStack.removeLast();
        }
      }
    }
  }
  while (optrStack.length > 0) {
    if(optrStack.length > 0) {
      answer.add(optrStack.last);
      optrStack.removeLast();
    }
  }
  return answer;
}

calculateExpressiom(List<String> tokens) {
  List<String> stack = [];
  List<String> ops = [
    "+",
    "-",
    "*",
    "/",
    "%",
    "^"
  ];
  try{
    for(var i=0; i<tokens.length; i++) {
      if(!ops.contains(tokens[i])) {
        stack.add(tokens[i]);
      } else {
        print(stack);
        var op1 = double.parse(stack.last);
        stack.removeLast();
        var op2 = double.parse(stack.last);
        stack.removeLast();
        if (tokens[i] == "+") {
          stack.add((op2 + op1).toString());
        }
        if (tokens[i] == "-") {
          stack.add((op2 - op1).toString());
        }
        if (tokens[i] == "*") {
          stack.add((op2 * op1).toString());
        }
        if (tokens[i] == "/") {
          stack.add((op2 / op1).toString());
        }
        if (tokens[i] == "%") {
          stack.add((op2 % op1).toString());
        }
        if (tokens[i] == "^") {
          stack.add((pow(op2,op1)).toString());
        }
      }
    }
  }catch(e){
    return null;
  }


  return stack;
}

sanitizedString(String expression) {
  List<String> ops = [
    "+",
    "-",
    "*",
    "/",
    "%",
    "^",
    "(",
    ")"
  ];
  expression=expression.replaceAll(" ", "");
  if(expression[0] == "-" || expression[0] == "+") {
    expression = "0" + expression;
  }
  expression= expression.replaceAll("(-", "(0-");
  for(var i=0; i<ops.length; i++) {
    expression=expression.replaceAll(ops[i], " "+ops[i]+' ');
  }
  return expression.split(" ");
}

calculate(String expression) {
  if(expression == null) {
    return 0;
  }
  var sanitized = sanitizedString(expression);
  var converted = convertPostFix(sanitized);
  var result = calculateExpressiom(converted);
  if(result == null){
    return null;
  }
  return result[0];
}


