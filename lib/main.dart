import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shuntingyard/bloc/my_bloc_event.dart';
import 'package:shuntingyard/bloc/my_bloc_state.dart';
import 'package:shuntingyard/bloc/my_block_form.dart';
import 'package:shuntingyard/model/inputcalculation.dart';
import 'package:shuntingyard/widgets/inputWidget.dart';
import 'package:shuntingyard/widgets/outputWidget.dart';
import 'package:shuntingyard/widgets/submitbutton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: BlocProvider(create: (_) => MyBlocForm(),
        child: const MyFormInput(),),
      ),
    );
  }
}

class MyFormInput extends StatefulWidget {
  const MyFormInput({Key? key}) : super(key: key);

  @override
  State<MyFormInput> createState() => _MyFormInputState();
}

class _MyFormInputState extends State<MyFormInput> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MyBlocForm, MyFormState>(listener: (context, state){
      if (state.status.isSubmissionSuccess) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
      if (state.status.isSubmissionInProgress) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Submitting...')),
          );
      }
    },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Spacer(),
                InuputFieldWidget(),
                Spacer(),
                SubmitButton(),
                Spacer(),
                OutputWidget(),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
