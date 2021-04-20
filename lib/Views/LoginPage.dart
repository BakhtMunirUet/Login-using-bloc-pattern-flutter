import 'package:bloc_login/UserRepository.dart';
import 'package:bloc_login/Views/Signup.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          userName: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return Column(
      children: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is UserNotExist) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
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
                            return "Enter password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'password'),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      RaisedButton(
                        onPressed: state is! LoginInProgress
                            ? () {
                                if (_formKey.currentState.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LoginButtonPressed(
                                      userName: _usernameController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: Text('Login'),
                      ),
                      Container(
                        child: state is LoginInProgress
                            ? CircularProgressIndicator()
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        FlatButton(
          child: Text("Sign Up"),
          color: Colors.green,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
        )
      ],
    );

    // return BlocListener<LoginBloc, LoginState>(
    //   listener: (context, state) {
    //     if (state is LoginFailure) {
    //       Scaffold.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text('${state.error}'),
    //           backgroundColor: Colors.red,
    //         ),
    //       );
    //     }
    //   },
    //   child: BlocBuilder<LoginBloc, LoginState>(
    //     builder: (context, state) {
    //       return Form(
    //         child: Column(
    //           children: [
    //             TextFormField(
    //               decoration: InputDecoration(labelText: 'username'),
    //               controller: _usernameController,
    //             ),
    //             TextFormField(
    //               decoration: InputDecoration(labelText: 'password'),
    //               controller: _passwordController,
    //               obscureText: true,
    //             ),
    //             RaisedButton(
    //               onPressed:
    //                   state is! LoginInProgress ? _onLoginButtonPressed : null,
    //               child: Text('Login'),
    //             ),
    //             Container(
    //               child: state is LoginInProgress
    //                   ? CircularProgressIndicator()
    //                   : null,
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
