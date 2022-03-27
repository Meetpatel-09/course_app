import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class MyProfilePageWeb extends StatefulWidget {
  const MyProfilePageWeb({Key? key}) : super(key: key);

  @override
  State<MyProfilePageWeb> createState() => _MyProfilePageWebState();
}

class _MyProfilePageWebState extends State<MyProfilePageWeb> {
  final SharedServices _sharedServices = SharedServices();
  bool _isLoading = true;
  String name = "";
  String email = "";
  String mobileNo = "";
  String address = "";
  String token = "";
  dynamic image = "";

  @override
  void initState() {
    super.initState();
    _sharedServices.getData("token").then((value) {
      if (value != null) {
        AuthService.getUserProfile(value).then((response) {
          if (response.status == 200) {
            name = response.result![0].fullName;
            email = response.result![0].email;
            mobileNo = response.result![0].mobileNo;
            address = response.result![0].address;
            image = response.result![0].profile;

            if (!mounted) return;
            setState(() {
              token = value;
              _isLoading = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              color: context.canvasColor,
              child: _isLoading ? const Center(child: CircularProgressIndicator(),) :
              SingleChildScrollView(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: context.primaryColor,
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15))
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 15.0,),
                            VxCircle(
                              radius: 155.0,
                              customDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  border: Border.all(color: context.backgroundColor, width: 4)
                              ),
                              child:  ClipOval(
                                child: Material(
                                  color: Colors.transparent,
                                  // child: Image.asset("assets/images/profile.png")
                                  child: Image.network(Config().mediaAPI + image, fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            greetingMessage().text.xl.semiBold.color(context.backgroundColor).make(),
                            name.text.xl3.semiBold.uppercase.color(context.backgroundColor).make(),
                            const SizedBox(height: 30,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 255.0, bottom: 20),
                        child: Center(
                          child: Container(
                            width: 600,
                            margin: const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                color: context.backgroundColor,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Account Info".text.xl3.semiBold.make().pLTRB(15.0, 10.0, 0.0, 4.0),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: context.canvasColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          VxCircle(
                                            radius: 50,
                                            backgroundColor: context.backgroundColor,
                                            child: const Icon(Icons.mail),
                                          ),
                                          const SizedBox(width: 10,),
                                          Container(
                                            width: 450.0,
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                            decoration: BoxDecoration(
                                              color: context.backgroundColor,
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                "Email".text.lg.bold.make().pOnly(left: 8.0),
                                                email.text.lg.color(context.cardColor.withOpacity(0.7)).make().pOnly(left: 8.0),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          VxCircle(
                                            radius: 50,
                                            backgroundColor: context.backgroundColor,
                                            child: const Icon(Icons.phone),
                                          ),
                                          const SizedBox(width: 10,),
                                          Container(
                                            width: 450.0,
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                            decoration: BoxDecoration(
                                              color: context.backgroundColor,
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                "Phone".text.lg.bold.make().pOnly(left: 8.0),
                                                mobileNo.text.lg.color(context.cardColor.withOpacity(0.7)).make().pOnly(left: 8.0),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                          children: [
                                            VxCircle(
                                              radius: 50,
                                              backgroundColor: context.backgroundColor,
                                              child: const Icon(Icons.location_on),
                                            ),
                                            const SizedBox(width: 10,),
                                            Container(
                                              width: 450.0,
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                              decoration: BoxDecoration(
                                                color: context.backgroundColor,
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  "Address".text.lg.bold.make().pOnly(left: 8.0),
                                                  address.text.lg.color(context.cardColor.withOpacity(0.7)).make().pOnly(left: 8.0),
                                                ],
                                              ),
                                            )
                                          ]
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context,
                                            MyRoutes.editProfileRoute,
                                            arguments: {
                                              'name': name,
                                              'mobileNo': mobileNo,
                                              'address': address,
                                              'image': image,
                                              'token': token,
                                            }
                                        );
                                      },
                                      child: "Edit Profile".text.semiBold.xl.color(context.backgroundColor).make(),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(135, 45),
                                        primary: context.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ).pOnly(left: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        // method to sign out the user and redirect to Sign In Page
                                        signOut();
                                      },
                                      child: "Sign Out".text.semiBold.xl.color(context.backgroundColor).make(),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(135, 45),
                                        primary: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ).pOnly(right: 20),
                                  ],
                                ).pOnly(bottom: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            const BottomNavigation(),
          ],
        ),
      ),
    );
  }

  String greetingMessage() {

    // getting the current time hours
    var timeNow = DateTime.now().hour;

    if (timeNow < 12) {  // from mid-night 12:00 A.M. to to 11:59 A.M.
      return 'Good Morning';
    } else if ((timeNow >= 12) && (timeNow <= 16)) { // from 12:00 P.M. to to 03:59 P.M.
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) { // from 4:00 P.M. to to 07:59 P.M.
      return 'Good Evening';
    } else { // from 08:00 P.M. to to 11:59 P.M.
      return 'Good Night';
    }
  }

  void signOut() {
    // checking the token to verify if the user is signed
    _sharedServices.getData("token").then((value) async {
      if (value != null) {
        // if yes removing the token
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        // checking if the user have singed in/up using google
        _sharedServices.getData("isGoogle").then((google) async {
          if (google != null) {
            // if yes then, calling the logout method form GoogleSignInAPI dart file previously created
            await GoogleSignInAPI.logout();
            // redirecting the use to sign in page
            Navigator.pushNamedAndRemoveUntil(
              context,
              MyRoutes.loginRoute,
                  (route) => false,
            );
          } else {
            // redirecting the use to sign in page
            Navigator.pushNamedAndRemoveUntil(
              context,
              MyRoutes.loginRoute,
                  (route) => false,
            );
          }
        });
      }
    });
  }
}
