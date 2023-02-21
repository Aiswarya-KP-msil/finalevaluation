import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:shuntingyard/model/Search.dart';

class MyFormState extends Equatable {
  const MyFormState({
    this.input = const Input.pure(),
    this.status = FormzStatus.pure,
    this.result = ""
  });

  final Input input;
  final FormzStatus status;
  final String result;

  MyFormState copyWith({
    Input? input,
    FormzStatus? status,
    String? result
  }) {
    return MyFormState(
      input: input ?? this.input,
      status: status ?? this.status,
      result: result ?? this.result
    );
  }

  @override
  List<Object> get props => [input, status, result];
}