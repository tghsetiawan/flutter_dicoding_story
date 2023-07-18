import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_story/bloc/bloc/auth_bloc.dart';
import 'package:flutter_dicoding_story/model/login_model.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:flutter_dicoding_story/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(
            height: 100,
          ),
          Text(
            'Email',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            autocorrect: false,
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            style: blackTextStyle.copyWith(fontSize: 18),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Password',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            autocorrect: false,
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            style: blackTextStyle.copyWith(fontSize: 18),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              // print('klik login');
              // context.go('/');
              context.read<AuthBloc>().add(
                    AuthLogin(
                      LoginModel(
                          email: emailController.text,
                          password: passwordController.text),
                    ),
                  );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                print('signin page state $state');
                if (state is AuthSuccess) {
                  context.goNamed(Routes.home);
                }
                if (state is AuthFailed) {
                  Fluttertoast.showToast(msg: state.e);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Text(
                    'Loading . . .',
                    style: whiteTextStyle.copyWith(fontSize: 18),
                  );
                }
                return Text(
                  'Login',
                  style: whiteTextStyle.copyWith(fontSize: 18),
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed(Routes.singUp);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: Text(
              'Back',
              style: whiteTextStyle.copyWith(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
