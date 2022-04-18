// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'package:boxicons/boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IMCWidget extends StatefulWidget {
  final Color color;
  final String text;
  final bool isSelected;

  IMCWidget(
      {Key? key,
      required this.color,
      required this.text,
      this.isSelected = false})
      : super(key: key);

  @override
  _IMCWidgetState createState() => _IMCWidgetState();
}

class _IMCWidgetState extends State<IMCWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      height: 40.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.color.withOpacity(0.6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Container(
            height: 20.h,
            width: 20.h,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(360),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            widget.text,
            style: TextStyle(
              fontFamily: "CairoBold",
              fontSize: 14.sp,
              color: const Color.fromRGBO(30, 30, 30, 1),
            ),
          ),
          const Spacer(),
          widget.isSelected
              ? Icon(
                  Boxicons.bx_chevron_down,
                  size: 14.sp,
                )
              : Icon(
                  Boxicons.bx_chevron_left,
                  size: 14.sp,
                ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
