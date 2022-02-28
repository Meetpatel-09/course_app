import 'package:course_app_ui/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomNavigationBar extends StatefulWidget {
  final List<Result> coursesList; // to store all the data from from home API
  const CustomNavigationBar({Key? key, required this.coursesList}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ClipPath(
        clipper: WaveClipperTwo(flip: true),
        child: Container(
          height: 120,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft ,
                  // end: Alignment.topRight,
                  // colors: [Colors.purple, Colors.blue]
                  // stops: [0.1, 0.5, 0.8, 0.9],
                  // colors: [Colors.red, Colors.yellow, Colors.blue, Colors.purple]
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.purple, Colors.blue]
              )
          ),
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  for (int i = 0; i < widget.coursesList.length; i++)
                    TextButton(
                        onPressed: () {},
                        child: widget.coursesList[i].category.toString().text.xl2.semiBold.color(context.backgroundColor).make()
                    ),
                ],
              ),
              Image.asset("assets/images/logo.png", width: 45, height: 45,).pOnly(left: 50),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: "Log In".text.lg.color(context.backgroundColor).make()
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: context.backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            blurRadius: 15,
                            offset: const Offset(0.0, 0.50)
                        ),
                      ],
                    ),
                    child: TextButton(
                        onPressed: () {},
                        child: "Sign Up".text.semiBold.lg.color(context.cardColor).make()
                    ),
                  )
                ],
              )
            ],
          ).pSymmetric(h: 100, v: 20),
        ),
      ),
    );
  }
}
