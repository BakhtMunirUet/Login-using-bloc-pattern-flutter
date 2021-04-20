part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String userName;
  final String password;

  const LoginButtonPressed({
    @required this.userName,
    @required this.password,
  });

  @override
  List<Object> get props => [userName, password];

  @override
  String toString() =>
      'LoginButtonPressed{ username: $userName, password: $password}';
}


