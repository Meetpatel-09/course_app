import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ButtonWidget extends StatelessWidget {
  final List<Result> mcqQuestions;
  final PageController controller;
  const ButtonWidget({Key? key, required this.mcqQuestions, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
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
                if (controller.page?.toInt() == 0) {

                } else {
                  controller.previousPage(
                      duration: const Duration(milliseconds: 250),
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
                MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                if (controller.page?.toInt() == mcqQuestions.length - 1) {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ResultScreen(score, userAnswer)));
                } else {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 250),
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
