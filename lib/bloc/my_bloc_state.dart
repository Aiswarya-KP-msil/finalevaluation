import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:shuntingyard/model/inputcalculation.dart';

class MyFormState extends Equatable {
  final Input input;
  final FormzStatus status;
  final String result;
  const MyFormState({
    this.input = const Input.pure(),
    this.status = FormzStatus.pure,
    this.result = ""
  });


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