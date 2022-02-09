import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewResultButton extends StatelessWidget {
  final List<Result>? myExamResultList;
  const ViewResultButton({Key? key, this.myExamResultList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(myExamResultList!.length);
    return Center(
      child: TextButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
                context,
                MyRoutes.myExamMCQPageRoute,
                arguments: {
                  'myExamResultList': myExamResultList
                }
            );
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: "View Result".text.xl.fontWeight(FontWeight.w600).make(),
              )
          )
      ),
    );
  }
}
