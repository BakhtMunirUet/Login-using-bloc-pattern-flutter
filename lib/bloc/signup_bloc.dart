import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_login/UserRepository.dart';
import 'package:bloc_login/bloc/login_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is CreateButtonPressed) {
      yield SignupInProgress();
      final isCreate = await UserRepository.createUser(
        username: event.userName,
        email: event.email,
        mobileNumber: event.mobileNumber,
        password: event.password,
      );
      if (isCreate) {
        yield SignupDone(isSignupSuccessful: true);
      } else {
        yield SignupDone(isSignupSuccessful: false);
      }
    }
  }
}
