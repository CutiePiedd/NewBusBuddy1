import 'package:flutter/material.dart';

class CustomCircularCheckbox extends StatelessWidget {
  final bool isChecked;
  final Function(bool?)? onChanged;

  const CustomCircularCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged!(!isChecked); // Toggle the checkbox state
      },
      child: Container(
        width: 18.0,
        height: 18.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey, // Gray border
            width: 1.0,
          ),
          color: isChecked
              ? Colors.grey
              : Colors.transparent, // Gray fill if checked
        ),
        child: isChecked
            ? const Icon(
                Icons.check,
                color: Colors.white, // White check icon
                size: 14.0, // Adjust size to fit the circle
              )
            : null, // No icon when unchecked
      ),
    );
  }
}
