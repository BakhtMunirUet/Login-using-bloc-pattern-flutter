import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_login/UserRepository.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  }) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      try {
        final isAuthenticate = await userRepository.authenticate(
          username: event.userName,
          password: event.password,
        );
        if (isAuthenticate) {
          authenticationBloc.add(AuthenticationLoggedIn(token: "token"));
        }
        else {
          yield UserNotExist(message: "Sorry, User not exists, first create account");
        }
        //authenticationBloc.add(AuthenticationLoggedIn(token: token));
        //yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
