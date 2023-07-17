import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is AuthRegister) {
        try {
          emit(AuthLoading());

          final register = await AuthService().storeCredentialToLocal(
              event.username, event.email, event.password);

          emit(AuthSuccess(event.email));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final email = await AuthService().getCredentialFromLocal();

          emit(AuthSuccess(email));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
