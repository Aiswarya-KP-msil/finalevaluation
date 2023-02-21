import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_bloc_state.dart';
import '../bloc/my_block_form.dart';

class OutputWidget extends StatelessWidget {
  const OutputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBlocForm, MyFormState>(
      builder: (context, state) {
        return Text(state.result.toString());
      },
    );
  }
}