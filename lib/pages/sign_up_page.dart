import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_story/bloc/bloc/auth_bloc.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:flutter_dicoding_story/theme.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Username',
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
            controller: usernameController,
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
              context.read<AuthBloc>().add(
                    AuthRegister(usernameController.text, emailController.text,
                        passwordController.text),
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
                if (state is AuthSuccess) {
                  context.goNamed(Routes.home);
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
                  'Create New Account',
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
              context.goNamed(Routes.singIn);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: Text(
              'Sign In',
              style: whiteTextStyle.copyWith(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
