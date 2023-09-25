import 'package:flutter/material.dart';
import 'package:presence_bloc_firebase/common/constants.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  const CustomTextField({
    super.key,
    required this.text,
    required this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        left: 14,
        right: 14,
        top: 4,
      ),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: AppColor.secondaryExtraSoft,
        ),
      ),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'poppins',
        ),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscureText!,
        
        decoration: InputDecoration(
          label: Text(
            text,
            style: TextStyle(
              color: AppColor.secondarySoft,
              fontSize: 14,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            color: AppColor.secondarySoft,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
