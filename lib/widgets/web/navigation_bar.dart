import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
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
    return Container(
      color: context.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/logo.png", width: 45, height: 45,),
          SizedBox(
            width: MediaQuery.of(context).size.width - 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < _coursesList.length; i++)
                      TextButton(
                          onPressed: () {},
                          child: _coursesList[i].category.toString().text.xl2.semiBold.color(context.backgroundColor).make()
                      ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.loginRoute);
                        },
                        child: "Log In".text.xl.color(context.backgroundColor).make()
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.registerRoute);
                        },
                        child: "Register".text.xl.color(context.backgroundColor).make()
                    )
                  ],
                ).pOnly(right: 50)
              ],
            ),
          )
        ],
      )
    );
  }
}
