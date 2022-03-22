import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MidSectionMyExam extends StatefulWidget {
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final List<Result>? myExamResultList; // to store user results dats
  final MyExamResultModel myExamResult;
  const MidSectionMyExam({Key? key, required this.controller, required this.onChangedPage, this.myExamResultList, required this.myExamResult}) : super(key: key);

  @override
  State<MidSectionMyExam> createState() => _MidSectionMyExamState();
}

class _MidSectionMyExamState extends State<MidSectionMyExam> {
  int optionIndex = -1; // for selecting mcq option
  List<String> mcqOptionCodes = ["A", "B", "C", "D"];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: 1400.0,
          minHeight: MediaQuery.of(context).size.height - 100
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Computer Basics".text.xl3.semiBold.make().px(10.0),
            summary(),
            const SizedBox(height: 20.0,),
            SizedBox(
                height: MediaQuery.of(context).size.height - 285,
                child: mcq())
            // buttons(),
          ],
        ),
      ),
    );
  }

  Widget mcq() => ListView.builder(
    scrollDirection: Axis.vertical,
    physics: const BouncingScrollPhysics(),
    controller: widget.controller,
    itemCount: widget.myExamResultList!.length,
    itemBuilder: (context, index) {
      pageIndex = index;
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: context.backgroundColor,
            // borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  // spreadRadius: 7,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 0.75)
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headings(),
            const SizedBox(height: 20.0,),
            widget.myExamResultList![pageIndex].que.text.xl2.semiBold.make(),
            const SizedBox(height: 15.0,),
            options(index),
            const SizedBox(height: 10.0,),
          ],
        ).pSymmetric(v: 30.0, h: 40.0),
      ).py(10.0);
    }
  );

  Widget summary() => Container(
    height: 110.0,
    // width: 500.0,
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
    child: Row(
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
        ),
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
  );

  Widget headings() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: "Question 1".text.xl.semiBold.make()
        ),
        // Row(
        //   children: [
        //     "Question Timer ".text.xl.semiBold.make(),
        //     "00:45".text.xl.semiBold.make()
        //   ],
        // ),
      ],
    );
  }

  Widget options(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < 4; i++)
          Container(
            decoration: BoxDecoration(
              color:  widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
                  ? Colors.green.withOpacity(0.3)
                  : widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect ? Colors.red.withOpacity(0.3) : context.backgroundColor,
                border: Border.all(
                    color:
                    widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
                        ? Colors.green
                        : widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect ? Colors.red : context.cardColor.withOpacity(0.5),
                    width: 2.0
                )
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
                          ? Colors.green.withOpacity(0.5)
                          : widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect ? Colors.red.withOpacity(0.5) : context.cardColor.withOpacity(0.1),
                      border: Border(
                        right: BorderSide(
                          color: widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
                              ? Colors.green.withOpacity(0.5)
                              : widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect ? Colors.red.withOpacity(0.5) : context.cardColor.withOpacity(0.5),
                          width: 2.0,
                        ),
                      )
                  ),
                  child:  mcqOptionCodes[i].text.xl2.semiBold.make().p(15.0),
                ),
                const SizedBox(width: 10.0,),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 350,
                    child: widget.myExamResultList![index].options[i].richText.xl.semiBold.make()
                ),
              ],
            ),
          ).pOnly(bottom: 10.0),
      ],
    );
  }
}
