import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/my_bloc_event.dart';
import '../bloc/my_bloc_state.dart';
import '../bloc/my_block_form.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBlocForm, MyFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () => context.read<MyBlocForm>().add(FormSubmitted())
              : null,
          child: const Text('Submit'),
        );
      },
    );
  }
}