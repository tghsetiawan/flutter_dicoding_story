part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final String e;
  const AuthFailed(this.e);

  @override
  List<Object> get props => [e];
}

class AuthSuccess extends AuthState {}

class AuthSuccessLogin extends AuthState {
  final ResponseLoginModel data;
  const AuthSuccessLogin(this.data);

  @override
  List<Object> get props => [data];
}
