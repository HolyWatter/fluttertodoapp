import 'package:flutter/material.dart';
import 'package:todoapp/common/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final bool isPassword;
  final String hintText;
  final ValueChanged<String> ? onChanged;

  const CustomTextField({super.key, required this.isPassword, required this.hintText, this.onChanged});
  

  @override
  Widget build(BuildContext context) {

      const baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color : INPUT_BORDER_COLOR,
          width: 1,
        )
      );
    return TextFormField(
            onChanged: onChanged,
            obscureText: isPassword,
            cursorColor: PRIMARY_COLOR,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: BDOY_TEXT_COLOR,
                fontSize: 14
              ),
              border: baseBorder,
              enabledBorder: baseBorder,
              focusedBorder: baseBorder.copyWith(
                borderSide: baseBorder.borderSide.copyWith(
                  color: PRIMARY_COLOR
                )
              )
            ),
          );
  }
}