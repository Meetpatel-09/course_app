import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  List<Result> _coursesList = []; // to store all the data from from home API

  @override
  void initState() {
    super.initState();
    APIServices.getCourses().then((courses) {
      if (courses.toString().isNotEmpty) {
        setState(() {
          _coursesList = courses.result!; // storing all the data from home API
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: context.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(color: context.backgroundColor, child: Image.asset("assets/images/logo.png")),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    MyRoutes.homeRoute
                );
              },
              child: "Home".text.semiBold.white.size(20.0).make()
            ).pOnly(left: 16, top: 20),
            for (int i = 0; i < _coursesList.length; i++)
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        MyRoutes.subjectListRoute,
                        arguments: {
                          "coursesList": _coursesList,
                          "index": i,
                          "subjectList": _coursesList[i].subject,
                        }
                    );
                  },
                  child: _coursesList[i].category.toString().text.semiBold.white.size(20.0).make()
              ).pOnly(left: 16, top: 10),
            // Padding(
            //   padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            //   child: Divider(
            //     color: Colors.blueGrey.shade400,
            //     thickness: 2,
            //   ),
            // ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: "Copyright © 2022 | Course App".text.white.size(16).make()
              ).pSymmetric(v: 16.0),
            )
          ],
        ),
      ),
    );
  }
}