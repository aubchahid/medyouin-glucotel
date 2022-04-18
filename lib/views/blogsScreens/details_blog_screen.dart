import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:glucotel/model/Blog.dart';
import 'package:intl/intl.dart';

class DetailsBlogScreen extends StatelessWidget {
  final Blog blog;
  const DetailsBlogScreen(this.blog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Boxicons.bxs_chevron_left,
              size: 35.h,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 80.h,
          title: Center(
            child: Image.asset(
              "assets/images/logo_white.png",
              width: 140.w,
            ),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20.0.w),
              child: Icon(
                Boxicons.bxs_chevron_right,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                "https://glucosql.medyouin.com/api-v2/pictures/" + blog.image,
                height: 210.h,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  blog.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "CairoBold",
                    fontSize: 18.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Glucotel - ' +
                      DateFormat('dd MMMM yyyy', 'FR_fr')
                          .format(DateTime.parse(blog.createdAt)),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'CairoSemiBold',
                    color: const Color.fromRGBO(30, 30, 30, 0.6),
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                thickness: 1.2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: HtmlWidget(
                  blog.contenu,
                  customStylesBuilder: (element) {
                    if (element.localName == 'h3') {
                      return {'color': '#0855BF'};
                    }

                    return null;
                  },
                  textStyle: TextStyle(
                      fontSize: 14.sp, fontFamily: 'CairoRegular', height: 1.4),
                ),
              ),
              15.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
