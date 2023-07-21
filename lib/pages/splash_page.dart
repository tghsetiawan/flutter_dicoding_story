import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:lottie/lottie.dart';

import '../bloc/Auth/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessLogin) {
            router.goNamed(Routes.home);
          }
          if (state is AuthFailed) {
            router.goNamed(Routes.singUp);
          }
        },
        child: Center(
          child: Lottie.asset('assets/splash.json',
              width: 300, height: 300, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
