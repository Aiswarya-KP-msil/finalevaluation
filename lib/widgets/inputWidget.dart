import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_bloc_event.dart';
import '../bloc/my_bloc_state.dart';
import '../bloc/my_block_form.dart';

class InuputFieldWidget extends StatelessWidget {
  const InuputFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBlocForm, MyFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.input.value,
          decoration: InputDecoration(
            labelText: 'Input',
          ),
          onChanged: (value) {
            context.read<MyBlocForm>().add(InputChanged(input: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}