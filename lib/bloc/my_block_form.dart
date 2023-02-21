import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:shuntingyard/bloc/my_bloc_event.dart';
import 'package:shuntingyard/bloc/my_bloc_state.dart';
import 'package:shuntingyard/model/Search.dart';

class MyBlocForm extends Bloc<MyFormEvent, MyFormState> {
  MyBlocForm() : super(const MyFormState()) {
    on<InputChanged>(_onInputTextChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }


  void _onInputTextChanged(InputChanged event, Emitter<MyFormState> emit) {
    final inputText = Input.dirty(event.input);
    emit(
      state.copyWith(
        input: inputText.valid ? inputText : Input.pure(event.input),
        status: Formz.validate([inputText]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event,
      Emitter<MyFormState> emit,
      ) async {
    final inputText = Input.dirty(state.input.value);
    emit(
      state.copyWith(
        input: inputText,
        status: Formz.validate([inputText]),
      ),
    );
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      double? result = evaluateExpression(inputText.value);
      emit(state.copyWith(result: result.toString()));
    }
  }
}