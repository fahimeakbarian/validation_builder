import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/student_module/presentation/bloc/student_bloc.dart';

class StudentFormPage extends StatelessWidget {
  const StudentFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StudentFormBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Student Form")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<StudentFormBloc, StudentFormState>(
            builder: (context, state) {
              final bloc = context.read<StudentFormBloc>();

              return Column(
                children: [
                  TextFormField(
                    controller: bloc.firstnameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (v) => bloc.add(FirstnameChanged(v)),
                    decoration: InputDecoration(
                      labelText: "Firstname",
                      errorText: state.firstnameError,
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: bloc.lastnameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (v) => bloc.add(LastnameChanged(v)),
                    decoration: InputDecoration(
                      labelText: "Lastname",
                      errorText: state.lastnameError,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: bloc.emailController,
                    onChanged: (v) => bloc.add(EmailChanged(v)),
                    decoration: InputDecoration(
                      labelText: "Email",
                      errorText: state.emailError,
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      bloc.add(SubmitForm());
                    },

                    child: const Text("Submit"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
