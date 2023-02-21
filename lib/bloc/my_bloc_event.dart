import 'package:equatable/equatable.dart';

abstract class MyFormEvent extends Equatable {
  const MyFormEvent();

  @override
  List<Object> get props => [];
}

class InputChanged extends MyFormEvent {
  const InputChanged({required this.input});

  final String input;

  @override
  List<Object> get props => [input];
}

class FormSubmitted extends MyFormEvent {}