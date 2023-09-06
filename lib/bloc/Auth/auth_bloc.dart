// import 'dart:convert';
// import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dicoding_story/model/login_model.dart';
import 'package:flutter_dicoding_story/model/register_model.dart';
import 'package:flutter_dicoding_story/model/response_login_model.dart';
import 'package:flutter_dicoding_story/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthRegister) {
        try {
          emit(AuthLoading());

          final register = await AuthService().register(event.data);

          if (register == false) {
            emit(const AuthFailed('Email is already taken'));
          } else {
            final LoginModel loginModel = LoginModel(
                email: event.data.email, password: event.data.password);

            final login = await AuthService().login(loginModel);

            emit(AuthSuccessLogin(login));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogin) {
        try {
          emit(AuthLoading());

          final login = await AuthService().login(event.data);

          emit(AuthSuccessLogin(login));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());

          await AuthService().logout();

          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final LoginModel loginModel =
              await AuthService().getCredentialFromLocal();

          final res = await AuthService().login(loginModel);

          emit(AuthSuccessLogin(res));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
