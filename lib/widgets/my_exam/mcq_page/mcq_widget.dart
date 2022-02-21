import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/widgets/my_exam/mcq_page/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQWidget extends StatefulWidget {
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final List<Result>? myExamResultList; // to store user results dats
  final MyExamResultModel myExamResult;
  const MCQWidget({Key? key, required this.controller, required this.onChangedPage, this.myExamResultList, required this.myExamResult}) : super(key: key);

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  int optionIndex = -1; // for selecting mcq option
  List<String> mcqOptionCodes = ["A", "B", "C", "D"];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Exam".text.make(),
      ),
      backgroundColor: context.canvasColor,
        body: Column(
          children: [
            summary(),
            SizedBox(
              height: MediaQuery.of(context).size.height - 285,
                child: mcq())
          ],
        )
    );
  }

  Widget summary() => Container(
    height: 170,
    padding: const EdgeInsets.all(25.0),
    margin: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
    decoration: BoxDecoration(
      color: context.backgroundColor,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 15,
            offset: const Offset(0.0, 0.50)
        ),
      ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, color: context.primaryColor,),
                    const SizedBox(width: 10,),
                    Text(
                      "${widget.myExamResult.summery?.totalQuestions.toString()}",
                      style: TextStyle(
                        color: context.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 33,),
                    "Total Questions".text.make(),
                  ],
                )
              ],
            ),
            SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, color: context.primaryColor,),
                      const SizedBox(width: 10,),
                      Text(
                        "${widget.myExamResult.summery?.totalAttempted.toString()}",
                        style: TextStyle(
                            color: context.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 33,),
                      "Total Attempted".text.make(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.green,),
                    const SizedBox(width: 10,),
                    Text(
                      "${widget.myExamResult.summery?.totalCorrect.toString()}",
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 33,),
                    "Total Correct".text.make(),
                  ],
                )
              ],
            ),
            SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.circle, color: Colors.red,),
                      const SizedBox(width: 10,),
                      Text(
                        "${widget.myExamResult.summery?.totalWrong.toString()}",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 33,),
                      "Total Wrong".text.make().pOnly(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );

  Widget mcq() => ListView.builder(
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
  );

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
          // if answer is correct
          widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
              ?
          const Icon(Icons.circle, color: Colors.green,)
              :
          // if option was selected and wrong
          widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect
              ?
          const Icon(Icons.circle, color: Colors.red,)
              :
          Icon(Icons.circle_outlined, color: context.cardColor.withOpacity(0.5),)
        ]
    );
  }
}
