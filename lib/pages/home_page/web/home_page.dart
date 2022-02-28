import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/widgets/home/search_bar.dart';
import 'package:course_app_ui/widgets/home/web/mid_section.dart';
import 'package:course_app_ui/widgets/home/web/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //       child: Scaffold(
  //         body: Column(
  //           children: [
  //             CustomNavigationBar(coursesList: _coursesList),
  //             const MidSection(),
  //           ],
  //         ),
  //       )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // remove back button in appbar.
        title: Image.asset("assets/images/logo.png", width: 45, height: 45,).pOnly(left: 50),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < _coursesList.length; i++)
                      TextButton(
                          onPressed: () {},
                          child: _coursesList[i].category.toString().text.xl.semiBold.color(context.backgroundColor).make()
                      ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: "Log In".text.lg.color(context.backgroundColor).make()
                    ),
                    TextButton(
                        onPressed: () {},
                        child: "Register".text.lg.color(context.backgroundColor).make()
                    )
                  ],
                ).pOnly(right: 50)
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: context.backgroundColor,
              constraints: const BoxConstraints(
                maxWidth: 1500
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 250,
                    width: 500,
                    child: Center(
                      child: SearchBar(),
                    ),
                  ),
                  Divider(
                    // thickness: 5, // thickness of the line
                    indent: 20, // empty space to the leading edge of divider.
                    endIndent: 20, // empty space to the trailing edge of the divider.
                    color: Colors.black.withOpacity(0.3), // The color to use when painting the line.
                    height: 1, // The divider's height extent.
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Image.asset("assets/images/download_from_google_play.png", fit: BoxFit.contain, width: 200,),
                            const SizedBox(height: 30,),
                            Row(
                              children: [
                                Image.asset("assets/images/ss1.png", fit: BoxFit.cover, width: 200,),
                                const SizedBox(width: 20,),
                                Image.asset("assets/images/ss4.png", fit: BoxFit.contain, width: 200,),
                                const SizedBox(width: 20,),
                                Image.asset("assets/images/ss5.png", fit: BoxFit.contain, width: 200,),
                                const SizedBox(width: 20,),
                                Image.asset("assets/images/ss3.png", fit: BoxFit.contain, width: 200,),
                                const SizedBox(width: 20,),
                              ],
                            )
                          ],
                        ),
                      ),
                      Center(child: Image.asset("assets/images/google_ads.png", fit: BoxFit.contain, width: 500,))
                    ],
                  ).p16(),
                ],
              ),
            ).centered(),
            Container(
              color: context.primaryColor,
              height: 60,
              child: Center(
                child: "Copyright © 2022 All Rights Reserved.".text.color(context.backgroundColor).make(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
