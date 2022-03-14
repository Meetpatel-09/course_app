import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  List<Result> _coursesList = []; // to store all the data from from home API
  final SharedServices _sharedServices = SharedServices();
  bool _isLoggedIn = false;
  String isGoogle = "no";
  String token = "";

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
    // checking the token to verify if the user is signed
    _sharedServices.getData("token").then((value) {
      if (value != null) {
        setState(() {
          token = value;
          _isLoggedIn = true;
        });
      }
    });
    // checking if the user have singed in/up using google
    _sharedServices.getData("isGoogle").then((value) {
      if (value != null) {
        setState(() {
          isGoogle = "yes";
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
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context,
                              MyRoutes.homeRoute,
                          );
                        },
                        child: "Home".text.xl.semiBold.color(context.backgroundColor).make()
                    ),
                    for (int i = 0; i < _coursesList.length; i++)
                      TextButton(
                          onPressed: () {
                            if (_isLoggedIn) {
                              Navigator.pushNamed(
                                  context,
                                  MyRoutes.subjectListRoute,
                                  arguments: {
                                    "coursesList": _coursesList,
                                    "index": i,
                                    "subjectList": _coursesList[i].subject,
                                    "token": token
                                  }
                              );
                            } else {
                              Navigator.pushNamed(
                                  context,
                                  MyRoutes.loginRoute,
                              );
                            }
                          },
                          child: _coursesList[i].category.toString().text.xl.semiBold.color(context.backgroundColor).make()
                      ),
                  ],
                ),
                _isLoggedIn ?
                TextButton(
                    onPressed: () async {
                      // removing the token
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('token');
                      if (isGoogle == "yes") {
                        // if yes then, calling the logout method form GoogleSignInAPI dart file previously created
                        await GoogleSignInAPI.logout();
                      }
                      // redirecting the use to sign in page
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MyRoutes.loginRoute,
                            (route) => false,
                      );
                    },
                    child: "Log Out".text.xl.color(context.backgroundColor).make()
                )
                :
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
