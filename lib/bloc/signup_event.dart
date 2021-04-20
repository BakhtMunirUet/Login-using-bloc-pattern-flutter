part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class CreateButtonPressed extends SignupEvent {
  final String userName;
  final String email;
  final String mobileNumber;
  final String password;

  CreateButtonPressed({
    @required this.userName,
    @required this.email,
    @required this.mobileNumber,
    @required this.password,
  });

  @override
  List<Object> get props => [userName, email, mobileNumber, password];
}
