import 'package:bloc_login/bloc/login_bloc.dart';
import 'package:bloc_login/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: BlocProvider(
        create: (context) => SignupBloc(),
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _onSignupButtonPressed() {
      BlocProvider.of<SignupBloc>(context).add(
        CreateButtonPressed(
          userName: _usernameController.text,
          email: _emailController.text,
          mobileNumber: _mobileNumberController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupDone) {
          print("Signup don ${state.isSignupSuccessful}");
          if (state.isSignupSuccessful) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter username";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'username'),
                        controller: _usernameController,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'email'),
                        controller: _emailController,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter mobile number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'mobile number'),
                        controller: _mobileNumberController,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'password'),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: state is! SignupInProgress
                            ? () {
                                if (_formKey.currentState.validate()) {
                                  BlocProvider.of<SignupBloc>(context).add(
                                    CreateButtonPressed(
                                      userName: _usernameController.text,
                                      email: _emailController.text,
                                      mobileNumber:
                                          _mobileNumberController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: Text('Create'),
                      ),
                      // Container(
                      //   child: state is SignupInProgress
                      //       ? CircularProgressIndicator()
                      //       : null,
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                child: state is SignupInProgress
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white.withOpacity(0.5),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
