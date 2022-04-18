// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/model/Blog.dart';
import 'package:glucotel/widgets/BlogCardType2.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  List<Blog> blogs = [];
  late Future<List<Blog>> futurBlog;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    futurBlog = Api().getBlogs();
    if (mounted) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await Api().getBlogs().then((value) {
          setState(() {
            blogs = value;
            _isLoading = true;
          });
        });
      });
    }
  }

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
                Boxicons.bxs_chevron_left,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
          elevation: 0,
        ),
        body: !_isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).backgroundColor),
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w, vertical: 15.h),
                    child: Text(
                      "Apprenez a mieux connaître votre corps.\nConsultez nos articles rédigés par des experts spécialisés en santé et nutrition.",
                      style: TextStyle(
                        fontFamily: "CairoSemiBold",
                        fontSize: 14.sp,
                        color: Theme.of(context).primaryColorDark,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Blog>>(
                      future: futurBlog,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<Blog>? _blogs = snapshot.data;
                          return ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: _blogs!.map<BlogCardType2Widget>((_blog) {
                              return BlogCardType2Widget(
                                blog: _blog,
                              );
                            }).toList(),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
