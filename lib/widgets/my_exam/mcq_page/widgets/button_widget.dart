import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ButtonWidget extends StatelessWidget {
  final List<Result>? myExamResultList;
  final PageController controller;
  const ButtonWidget({Key? key, this.myExamResultList, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 6.0, 18.0, 0.0),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(context.primaryColor.withOpacity(0.2)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                if (controller.page?.toInt() == 0) {

                } else {
                  controller.previousPage(
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.easeInExpo);
                }
              },
              child: const SizedBox(
                  width: 100,
                  child: Icon(Icons.arrow_back)
              )
          ),
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(context.primaryColor.withOpacity(0.2)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                if (controller.page?.toInt() == myExamResultList!.length - 1) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        // title: const Text("Unknown Error"),
                        content: const Text("Want to Exit?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  MyRoutes.homeRoute,
                                  (route) => false,
                              );
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                        ],
                      )
                  );
                } else {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.easeInExpo);
                }
              },
              child: const SizedBox(
                  width: 100,
                  child: Icon(Icons.arrow_forward)
              )
          )
        ],
      ),
    );
  }
}
