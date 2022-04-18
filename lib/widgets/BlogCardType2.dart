// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/model/Blog.dart';
import 'package:glucotel/views/blogsScreens/details_blog_screen.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BlogCardType2Widget extends StatefulWidget {
  final Blog blog;

  // ignore: use_key_in_widget_constructors
  const BlogCardType2Widget({
    required this.blog,
  });

  @override
  _BlogCardType2WidgetState createState() => _BlogCardType2WidgetState();
}

class _BlogCardType2WidgetState extends State<BlogCardType2Widget> {
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: DetailsBlogScreen(widget.blog),
          pageTransitionAnimation: PageTransitionAnimation.slideRight,
          withNavBar: false,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Container(
          width: 300.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 1.4.w),
          ),
          child: Row(children: [
            SizedBox(
              height: 100.h,
              width: 100.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://glucosql.medyouin.com/api-v2/pictures/" +
                      widget.blog.image,
                  height: 100.h,
                  width: 110.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                SizedBox(
                  width: 190.w,
                  height: 60.h,
                  child: Text(
                    widget.blog.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'CairoSemiBold',
                      color: const Color.fromRGBO(30, 30, 30, 1),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Glucotel - ' +
                      DateFormat('dd MMMM yyyy', 'FR_fr')
                          .format(DateTime.parse(widget.blog.createdAt)),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'CairoSemiBold',
                    color: const Color.fromRGBO(30, 30, 30, 0.6),
                  ),
                ),
                const Spacer(),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
