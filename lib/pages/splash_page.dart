import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_story/bloc/bloc/auth_bloc.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessLogin) {
            router.goNamed(Routes.home);
          }
          if (state is AuthFailed) {
            router.goNamed(Routes.singUp);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: Lottie.asset(
                'assets/splash.json',
                width: 300,
                height: 300,
                fit: BoxFit.fill,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}


//  if (state is AuthSuccessLogin) {
//             router.goNamed(Routes.home);
//           }
//           if (state is AuthFailed) {
//             Fluttertoast.showToast(msg: state.e.toString());
//           }