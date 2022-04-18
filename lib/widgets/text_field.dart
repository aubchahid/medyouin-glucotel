// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextField extends StatefulWidget {
  String hintText;
  bool isPassword;
  TextInputType type;
  TextEditingController controller;
  IconData icon;
  bool enable;
  InputTextField(
      {required this.hintText,
      required this.type,
      this.isPassword = false,
      required this.controller,
      required this.icon,
      this.enable = true,
      Key? key})
      : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        height: 65.h,
        child: TextField(
          enabled: widget.enable,
          obscureText: widget.isPassword,
          keyboardType: widget.type,
          controller: widget.controller,
          textAlignVertical: TextAlignVertical.center,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(
            fontFamily: "CairoSemiBold",
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontFamily: "CairoRegular",
              fontSize: 14.sp,
              color: Theme.of(context).primaryColorDark,
            ),
            filled: true,
            fillColor: const Color.fromRGBO(235, 235, 235, 1),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
