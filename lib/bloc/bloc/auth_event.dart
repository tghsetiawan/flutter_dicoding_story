part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRegister extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const AuthRegister(this.username, this.email, this.password);
  @override
  // TODO: implement props
  List<Object> get props => [username, email, password];
}

class AuthGetCurrentUser extends AuthEvent {}
