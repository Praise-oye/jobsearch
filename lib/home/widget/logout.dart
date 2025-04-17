import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/login/bloc/login_bloc.dart';
import 'package:tut/login/loginscreen.dart';


class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is LogOutLoadedState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Loginscreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            loginBloc.add(LogOutEvent());
          },
        );
      },
    );
  }
}
