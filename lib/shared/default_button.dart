import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final String text;
  final Function() onPressed;
  final Color buttonColor;
  final Color textColor;
  
  const DefaultButton({super.key, required this.text, required this.onPressed, required this.buttonColor, required this.textColor});

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return 
       SizedBox(
        width: double.infinity,
         child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), 
            ),
            elevation: 5, 
          ),
          child: Text(
            widget.text,
            style: TextStyle(color: widget.textColor, fontWeight: FontWeight.bold), 
          ),
         
             ),
       );
  }
}
