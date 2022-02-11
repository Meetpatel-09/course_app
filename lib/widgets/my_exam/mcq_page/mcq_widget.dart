import 'dart:async';

import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/widgets/my_exam/mcq_page/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQWidget extends StatefulWidget {
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final List<Result>? myExamResultList;
  const MCQWidget({Key? key, required this.controller, required this.onChangedPage, this.myExamResultList}) : super(key: key);

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  int optionIndex = -1;
  List<String> mcqOptionCodes = ["A", "B", "C", "D"];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Exam".text.make(),
      ),
      backgroundColor: context.canvasColor,
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            controller: widget.controller,
            itemCount: widget.myExamResultList!.length,
            itemBuilder: (context, index) {
              pageIndex = index;
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      QuestionWidget(
                        question: widget.myExamResultList![pageIndex].que,
                        questionNumber: pageIndex + 1,
                      ),
                      const SizedBox(height: 15,),
                      Column(
                        children: [
                          for (int i = 0; i < 4; i++)
                            GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18),
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                                    decoration: BoxDecoration(
                                        color: context.backgroundColor,
                                        borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: buildAnswer(i, pageIndex),
                                    )
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        // ),
    );
  }
  Widget buildAnswer(int i, int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              mcqOptionCodes[i].text.xl.color(
                widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
                    ? Colors.green
                    : widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect ? Colors.red : context.cardColor,
              ).make(),
              const SizedBox(width: 10,),
              SizedBox(width: MediaQuery.of(context).size.width - 170,
                  child: widget.myExamResultList![index].options[i].text.xl.color(
                    widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
                        ? Colors.green
                        : widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect ? Colors.red : context.cardColor,
                  ).make()
              ),
            ],
          ),
          widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
              ?
          const Icon(Icons.circle, color: Colors.green,)
              :
          widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect
              ?
          const Icon(Icons.circle, color: Colors.red,)
              :
          Icon(Icons.circle_outlined, color: context.cardColor.withOpacity(0.5),)
        ]
    );
  }
}
