import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_login/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationSuccess();
      } else {
        yield AuthennticationFailure();
      }
    }

    if(event is AuthenticationLoggedIn){
      yield AuthenticationInProgress();
      await userRepository.persistToken(event.token);
      yield AuthenticationSuccess();
    }

    if(event is AuthenticationLoggedOut){
      yield AuthenticationInProgress();
      await userRepository.deleteToken();
      yield AuthennticationFailure();
    }
  }
}
