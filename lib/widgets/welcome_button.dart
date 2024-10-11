import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    super.key,
    this.buttonText,
    required this.onTap,
    this.color,
    this.textColor,
    this.borderColor,
    required this.textStyle,
  });

  final String? buttonText;
  final void Function(BuildContext)? onTap; // Change to a function
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call the onTap function, passing the current context
        if (onTap != null) {
          onTap!(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(70),
          border: Border.all(
              color: borderColor ?? textColor ?? Colors.black, width: 2),
        ),
        child: Center(
          child: Text(
            buttonText ?? '',
            textAlign: TextAlign.center,
            style: textStyle.copyWith(color: textColor ?? Colors.black),
          ),
        ),
      ),
    );
  }
}
