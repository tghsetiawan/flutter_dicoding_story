import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_story/bloc/bloc/auth_bloc.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            Fluttertoast.showToast(msg: state.e);
          }

          if (state is AuthInitial) {
            context.goNamed(Routes.singIn);
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/sign-in', (route) => false);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ini Halaman Home Page'),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(Routes.settings);
                  },
                  child: Text('Settings Page'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(Routes.products);
                  },
                  child: Text('Products Page'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // context.goNamed(Routes.singUp);
                    context.read<AuthBloc>().add(AuthLogout());
                  },
                  child: Text('Log Out'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
