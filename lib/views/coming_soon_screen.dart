import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpComming extends StatefulWidget {
  const UpComming({Key? key}) : super(key: key);

  @override
  State<UpComming> createState() => _UpCommingState();
}

class _UpCommingState extends State<UpComming> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/coming.png',
            width: 300.w,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            'Ce module est en cours de développement ...',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'CairoSemiBold',
                fontSize: 16.sp,
                color: Theme.of(context).primaryColorDark),
          ),
        ],
      ),
    );
  }
}
