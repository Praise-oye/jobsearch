import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/login/bloc/login_bloc.dart';
import 'package:tut/login/register.dart';
import 'package:tut/login/reset.dart';
import 'package:tut/shared/default_button.dart';
import 'package:tut/shared/home_controller.dart';
import 'package:tut/shared/job_style.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginBloc loginBloc = LoginBloc();
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginLoadedState) {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeController()),
            );
          } else if (state is LoginFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email not Found'),
              ),
            );
          } else if (state is RegisterLoadedState) {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeController()),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        const Text(
                          "Welcome back! ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        const Text(
                          "Please sign in to continue",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        const Text("Email",
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextField(
                          controller: _emailController,
                          cursorColor: JobStyle.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16))),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        const Text("Password",
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: _isObscured,
                          cursorColor: JobStyle.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16))),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: JobStyle.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        if (state is LoginLoadingState)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else
                          DefaultButton(
                            text: "Login",
                            onPressed: () {
                              if (_emailController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty) {
                                loginBloc.add(LoginScreenEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              } else if (_emailController.text.isEmpty &&
                                  _passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please fill in the above details'),
                                  ),
                                );
                              }
                            },
                            buttonColor: JobStyle.purple,
                            textColor: JobStyle.white,
                          ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Reset(),
                              ),
                            );
                          },
                          child: const Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: JobStyle.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: JobStyle.white,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()),
                                  );
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: JobStyle.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
