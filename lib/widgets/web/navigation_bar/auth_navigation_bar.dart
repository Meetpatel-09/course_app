import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthNavigationBar extends StatelessWidget {
  final bool fromLogIn;
  const AuthNavigationBar({Key? key, required this.fromLogIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.homeRoute);
                },
                child: Image.asset("assets/images/logo.png", width: 40)
            ),
            const SizedBox(width: 10,),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.homeRoute);
                },
                child: Config().appName.text.xl3 .semiBold.color(context.primaryColor).make()
            )
          ],
        ),
        Row(
          children: [
            fromLogIn ?
            "Not having an account?".text.semiBold.color(context.cardColor.withOpacity(0.5)).make()
            :
            "Already have an account?".text.semiBold.color(context.cardColor.withOpacity(0.5)).make(),
            const SizedBox(width: 15,),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: context.cardColor.withOpacity(0.5),
                        width: 1
                    )
                ),
                child: TextButton(
                  onPressed: () {
                    fromLogIn ?
                      Navigator.pushNamed(context, MyRoutes.registerRoute)
                        :
                      Navigator.pushNamed(context, MyRoutes.loginRoute);
                  },
                  child:
                  fromLogIn ?
                  "Sign Up".text.semiBold.color(context.cardColor.withOpacity(0.5)).make()
                  :
                  "Sign In".text.semiBold.color(context.cardColor.withOpacity(0.5)).make(),
                  style: TextButton.styleFrom(
                    // padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                )
            )
          ],
        ),
      ],
    ).pSymmetric(h: 100, v: 20);
  }
}
