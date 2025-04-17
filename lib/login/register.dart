import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/login/bloc/login_bloc.dart';
import 'package:tut/login/loginscreen.dart';
import 'package:tut/login/reset.dart';
import 'package:tut/shared/default_button.dart';
import 'package:tut/shared/home_controller.dart';
import 'package:tut/shared/job_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final LoginBloc loginBloc = LoginBloc();
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is RegisterLoadedState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeController()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account Successfully created!'),
              ),
            );
          } else if (state is RegisterLoadingState) {
            const CircularProgressIndicator();
          } else if (state is RegisterFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account Exists, Please Login!'),
              ),
            );
          }
          // TODO: implement listener
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
                          "Create an Account ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        const Text(
                          "Please fill in the details to register",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        const Text("Name",
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextField(
                          controller: _nameController,
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
                        if (state is RegisterLoadingState)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else
                          DefaultButton(
                              text: "Register",
                              onPressed: () {
                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty && _nameController.text.isNotEmpty) {
                                  loginBloc.add(RegisterUserEvent(
                                      email: _emailController.text,
                                      password: _passwordController.text, name: _nameController.text));
                                } else if (_emailController.text.isEmpty &&
                                    _passwordController.text.isEmpty && _nameController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please fill in the above details'),
                                    ),
                                  );
                                }
                              },
                              buttonColor: JobStyle.purple,
                              textColor: JobStyle.white),
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
                                        builder: (context) => const Loginscreen()),
                                  );
                                },
                                child: const Text(
                                  "Sign in",
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
