import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/model/auth_model.dart';
import 'package:flutter_dicoding_story/model/login_model.dart';
import 'package:flutter_dicoding_story/model/register_model.dart';
import 'package:flutter_dicoding_story/model/response_login_model.dart';
import 'package:flutter_dicoding_story/model/response_model.dart';
import 'package:flutter_dicoding_story/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthRegister) {
        try {
          emit(AuthLoading());

          final res = await AuthService().register(event.data);
          print('AuthRegister : $res');
          if (res == false) {
            emit(const AuthFailed('Email is already taken'));
          } else {
            emit(AuthSuccess());
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogin) {
        try {
          emit(AuthLoading());

          final res = await AuthService().login(event.data);

          emit(AuthSuccessLogin(res));
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
