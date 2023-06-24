import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyBoardType,
    this.obscureText = false,
    this.isMultiLine = false,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyBoardType;
  final bool obscureText;
  final bool isMultiLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      height: !isMultiLine ? 40 : null,
      child: TextField(
        minLines: 1,
        maxLines: isMultiLine ? 10 : 1,
        maxLength: isMultiLine ? 1000 : null,
        obscureText: obscureText,
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: MyColors.white,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: MyColors.white,
        ),
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: isMultiLine ? 15 : 8,
            horizontal: 12,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 1,
              color: MyColors.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 1,
              color: MyColors.purple,
            ),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: MyColors.ligthGrey,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
