import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/login/bloc/login_bloc.dart';
import 'package:tut/login/loginscreen.dart';
import 'package:tut/shared/default_button.dart';
import 'package:tut/shared/job_style.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final TextEditingController _emailController = TextEditingController();
  final LoginBloc loginBloc = LoginBloc();

  @override
  void dispose() {
    _emailController.dispose();
    loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is ResetLoadedState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Loginscreen()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Check your email for a link to reset your password'),
              ),
            );
          } else if (state is ResetFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
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
                          "Forgot Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
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
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        if (state is ResetLoadingState)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else
                          DefaultButton(
                            text: "Reset",
                            onPressed: () {
                              if (_emailController.text.isNotEmpty) {
                                loginBloc.add(ResetPasswordEvent(
                                  email: _emailController.text,
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter your email'),
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
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: JobStyle.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Loginscreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  color: JobStyle.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
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