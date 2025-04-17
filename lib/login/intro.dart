import 'package:flutter/material.dart';
import 'package:tut/login/loginscreen.dart';
import 'package:tut/shared/default_button.dart';
import 'package:tut/shared/job_style.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "CareerCompass",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset("assets/images/jobs.png"),
                  const SizedBox(height: 20),
                  const Text(
                    "Your career journey begins here",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Find your dream job with ease.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 20),
                  DefaultButton(text: "Let's Start", onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Loginscreen(),
                        ),
                      );
                  }, buttonColor: JobStyle.purple, textColor: JobStyle.white)
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
