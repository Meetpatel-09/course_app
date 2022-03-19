import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:course_app_ui/theme/theme.dart';

class MidSectionMCQPage extends StatefulWidget {
  const MidSectionMCQPage({Key? key}) : super(key: key);

  @override
  State<MidSectionMCQPage> createState() => _MidSectionMCQPageState();
}

class _MidSectionMCQPageState extends State<MidSectionMCQPage> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                "Computer Basics".text.xl3.semiBold.make(),
                Row(
                  children: [
                    "Exam Timer ".text.xl.semiBold.make(),
                    "01:23".text.xl.semiBold.make()
                  ],
                ),
              ],
            ).px(10),
            const SizedBox(height: 30.0,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 1; i < 11 ; i++)
                        // TextButton(
                        //   style: ButtonStyle(
                        //     padding:  MaterialStateProperty.all<EdgeInsets>(
                        //         const EdgeInsets.all(20.0)),
                        //     backgroundColor: MaterialStateProperty.all(context.primaryColor.withOpacity(0.2)),
                        //     maximumSize: MaterialStateProperty.all(const Size(110, 50)),
                        //     minimumSize: MaterialStateProperty.all(const Size(110, 50)),
                        //     // shape: MaterialStateProperty.all(
                        //     //   RoundedRectangleBorder(
                        //     //     borderRadius: BorderRadius.circular(8),
                        //     //   ),
                        //     // ),
                        //   ),
                        //   onPressed: () {},
                        //   child: "Q no.- $i".text.xl.make(),
                        // ).p2(),
                        Container(
                            margin: const EdgeInsets.only(right: 5.0, left: 0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: context.primaryColor, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              color:i == 1 ? context.primaryColor : context.canvasColor,
                            ),
                            child: Center(
                              child: "Q no.- $i".text.xl.color(i == 1 ? MyTheme.white : context.cardColor,).make(),
                            )
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0,),
            Container(
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
                  "Top Hat Test is a relatively new product where professors can administer tests online through Top Hat?".text.xl2.semiBold.make(),
                  const SizedBox(height: 15.0,),
                  options(),
                  const SizedBox(height: 10.0,),
                ],
              ).pSymmetric(v: 30.0, h: 40.0),
            ),
            buttons(),
          ],
        ),
      ),
    );
  }

  Widget headings() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: "Question 1".text.xl.semiBold.make()
        ),
        Row(
          children: [
            "Question Timer ".text.xl.semiBold.make(),
            "00:45".text.xl.semiBold.make()
          ],
        ),
      ],
    );
  }

  Widget options() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          decoration: BoxDecoration(
              color: context.backgroundColor,
              border: Border.all(
                  color:
                  // userAnswer[pageIndex + 1] ==
                  //     (i + 1).toString()
                  //     ? context.primaryColor
                  //     :
                  context.cardColor.withOpacity(0.5),
                  width: 2.0
              )
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.cardColor.withOpacity(0.1),
                  border: Border(
                    right: BorderSide(
                      color: context.cardColor.withOpacity(0.5),
                      width: 2.0,
                    ),
                  )
                ),
                child: "A".text.xl2.semiBold.make().p(15.0),
              ),
              const SizedBox(width: 10.0,),
              SizedBox(
                width: MediaQuery.of(context).size.width - 350,
                  child: "key part of a student's with an X".richText.xl.semiBold.make()
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0,),
        Container(
          // padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          decoration: BoxDecoration(
              color: context.primaryColor.withOpacity(0.4),
              border: Border.all(
                  color:
                  // userAnswer[pageIndex + 1] ==
                  //     (i + 1).toString()
                  //     ? context.primaryColor
                  //     :
                  context.primaryColor,
                  width: 2.0
              )
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.primaryColor.withOpacity(0.5),
                  border: Border(
                    right: BorderSide(
                      color: context.primaryColor,
                      width: 2.0,
                    ),
                  )
                ),
                child: "B".text.xl2.semiBold.make().p(15.0),
              ),
              const SizedBox(width: 10.0,),
              SizedBox(
                width: MediaQuery.of(context).size.width - 350,
                  child: "With an X".richText.xl.semiBold.make()
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0,),
        Container(
          // padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          decoration: BoxDecoration(
              color: context.backgroundColor,
              border: Border.all(
                  color:
                  // userAnswer[pageIndex + 1] ==
                  //     (i + 1).toString()
                  //     ? context.primaryColor
                  //     :
                  context.cardColor.withOpacity(0.5),
                  width: 2.0
              )
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.cardColor.withOpacity(0.1),
                  border: Border(
                    right: BorderSide(
                      color: context.cardColor.withOpacity(0.5),
                      width: 2.0,
                    ),
                  )
                ),
                child: "C".text.xl2.semiBold.make().p(15.0),
              ),
              const SizedBox(width: 10.0,),
              SizedBox(
                width: MediaQuery.of(context).size.width - 350,
                  child: "Key part of".richText.xl.semiBold.make()
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0,),
        Container(
          // padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          decoration: BoxDecoration(
              color: context.backgroundColor,
              border: Border.all(
                  color:
                  // userAnswer[pageIndex + 1] ==
                  //     (i + 1).toString()
                  //     ? context.primaryColor
                  //     :
                  context.cardColor.withOpacity(0.5),
                  width: 2.0
              )
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.cardColor.withOpacity(0.1),
                  border: Border(
                    right: BorderSide(
                      color: context.cardColor.withOpacity(0.5),
                      width: 2.0,
                    ),
                  )
                ),
                child: "D".text.xl2.semiBold.make().p(15.0),
              ),
              const SizedBox(width: 10.0,),
              SizedBox(
                width: MediaQuery.of(context).size.width - 350,
                  child: "Student's with an X".richText.xl.semiBold.make()
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: ButtonStyle(
            padding:  MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(20.0)),
            backgroundColor: MaterialStateProperty.all(context.primaryColor.withOpacity(0.2)),
            maximumSize: MaterialStateProperty.all(const Size(120, 50)),
            minimumSize: MaterialStateProperty.all(const Size(120, 50)),
            // shape: MaterialStateProperty.all(
            //   RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            // ),
          ),
          onPressed: () {},
          child: "Previous".text.xl.make(),
        ),
        TextButton(
          style: ButtonStyle(
            padding:  MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(20.0)),
            backgroundColor: MaterialStateProperty.all(context.primaryColor.withOpacity(0.2)),
            maximumSize: MaterialStateProperty.all(const Size(120, 50)),
            minimumSize: MaterialStateProperty.all(const Size(120, 50)),
            // shape: MaterialStateProperty.all(
            //   RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            // ),
          ),
          onPressed: () {},
          child: "Next".text.xl.make(),
        ),
      ],
    ).pSymmetric(v: 20.0);
  }
  
}
// class _MidSectionMCQPageState extends State<MidSectionMCQPage> {
//   int optionIndex = -1; // for selecting mcq option
//   List<String> mcqOptionCodes = ["A", "B", "C", "D"];
//   Map<int, String> userAnswer = {};
//   int pageIndex = 0;
//   // user answers
//   Map<int, String> userAnswerToSend = {};
//   Map<int, Duration> userMCQQuestionTimer = {};
//   late int mcqId;
//   List<int> mcqIDs = [];
//
//   static Duration countdownDurationExam = const Duration();
//   Duration durationExam = const Duration();
//   // Timer? timerExam;
//
//   @override
//   void initState() {
//     super.initState();
//     // for (int i = 0; i < widget.mcqQuestions.length; i++) {
//     //   mcqIDs.add(widget.mcqQuestions[i].mcqid);
//     // }
//     // if (widget.wantExamTimer) {
//     //   startTimer();
//     // } else {
//     //   startTimer();
//     // }
//   }
//
//   void reset() {
//     // if (widget.wantExamTimer) {
//     //   countdownDurationExam = Duration(minutes: int.parse(widget.examTimer));
//     //   setState(() => durationExam = countdownDurationExam);
//     // } else {
//     //   setState(() => durationExam = const Duration(hours: 2));
//     // }
//   }
//
//   void addTime() {
//     const addSeconds = -1;
//     setState(() {
//       final seconds = durationExam.inSeconds + addSeconds;
//
//       if(seconds < 0) {
//         // timerExam?.cancel();
//         // sendData(true);
//         Future.delayed(Duration.zero, () {
//           showTimeOutDialog("Exam Time Out!! Answers submitted", false, false);
//         });
//       } else {
//         durationExam = Duration(seconds: seconds);
//       }
//     });
//   }
//
//   void startTimer({bool resets = true}) {
//     if(resets) {
//       reset();
//     }
//     // timerExam = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
//   }
//
//   void stopTimer({bool resets = true}) {
//     if (resets) {
//       reset();
//     }
//     // setState(() => timerExam?.cancel());
//   }
//
//   @override
//   void dispose() {
//     // timerExam?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     // 9 --> 09     11 --> 11
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(durationExam.inMinutes.remainder(60));
//     final seconds = twoDigits(durationExam.inSeconds.remainder(60));
//
//     return Container(
//       // appBar: AppBar(
//       //   title: "Exam".text.make(),
//       //   actions: [
//       //     TextButton(
//       //       onPressed: () {
//       //         // sendData(false);
//       //         showTimeOutDialog("Answers Saved Successfully", false, true);
//       //       },
//       //       child: "Save".text.white.extraBold.size(19).letterSpacing(1).make().pOnly(right: 16, bottom: 0),
//       //       style: ElevatedButton.styleFrom(
//       //         padding: const EdgeInsets.all(0),
//       //       ),
//       //     ),
//       //     TextButton(
//       //       onPressed: () {
//       //         // sendData(true);
//       //         showTimeOutDialog("Do you want to finish Exam", true, false);
//       //       },
//       //       child: "Finish".text.white.extraBold.size(19).letterSpacing(1).make().pOnly(right: 16, bottom: 0),
//       //       style: ElevatedButton.styleFrom(
//       //         padding: const EdgeInsets.all(0),
//       //       ),
//       //     )
//       //   ],
//       // ),
//       color: context.canvasColor,
//       // child: SizedBox(
//       //   height: MediaQuery.of(context).size.height - 45,
//       //   child: PageView.builder(
//       //     physics: const NeverScrollableScrollPhysics(),
//       //     // onPageChanged: widget.onChangedPage,
//       //     // controller: widget.controller,
//       //     // itemCount: widget.mcqQuestions.length,
//       //     itemBuilder: (context, index) {
//       //       pageIndex = index;
//       //       return Column(
//       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //         crossAxisAlignment: CrossAxisAlignment.center,
//       //         children: [
//       //           SizedBox(
//       //             height: MediaQuery.of(context).size.height / 1.47,
//       //             child: SingleChildScrollView(
//       //               child: Column(
//       //                 children: [
//       //                   // QuestionWidget(
//       //                   //   question: widget.mcqQuestions[pageIndex].que,
//       //                   //   questionNumber: pageIndex + 1,
//       //                   //   wantExamTimer: widget.wantExamTimer,
//       //                   //   examTimerMinutes: minutes,
//       //                   //   examTimerSeconds: seconds,
//       //                   //   examTime: widget.examTimer,
//       //                   //   wantQuestionTimer: widget.wantQuestionTimer,
//       //                   //   questionTime: widget.questionTime,
//       //                   //   userMCQQuestionTimer: userMCQQuestionTimer,
//       //                   //   mcqid: widget.mcqQuestions[pageIndex].mcqid,
//       //                   // ),
//       //                   const SizedBox(height: 15,),
//       //                   Column(
//       //                     children: [
//       //                       // for (int i = 0; i < 4; i++)
//       //                         // GestureDetector(
//       //                         //   onTap: () {
//       //                         //     if(widget.wantQuestionTimer) { // check if there is per question timer
//       //                         //       int? s = userMCQQuestionTimer[widget.mcqQuestions[pageIndex].mcqid]?.inSeconds;
//       //                         //       if (s! != 0) { // to check if question time is over or not
//       //                         //         userAnswer[pageIndex + 1] = (i + 1).toString();
//       //                         //         userAnswerToSend[widget.mcqQuestions[pageIndex].mcqid] = widget.mcqQuestions[pageIndex].options[i];
//       //                         //         setState(() {});
//       //                         //       } else {
//       //                         //         Fluttertoast.showToast(msg: "Question Time Out!!", fontSize: 18);
//       //                         //       }
//       //                         //     } else {
//       //                         //       userAnswer[pageIndex + 1] = (i + 1).toString();
//       //                         //       userAnswerToSend[widget.mcqQuestions[pageIndex].mcqid] = widget.mcqQuestions[pageIndex].options[i];
//       //                         //       setState(() {});
//       //                         //     }
//       //                         //   },
//       //                         //   child: Padding(
//       //                         //     padding: const EdgeInsets.symmetric(
//       //                         //         horizontal: 18),
//       //                         //     child: Container(
//       //                         //         margin: const EdgeInsets.symmetric(
//       //                         //             vertical: 6),
//       //                         //         padding: const EdgeInsets.all(12),
//       //                         //         decoration: BoxDecoration(
//       //                         //             color: context.backgroundColor,
//       //                         //             borderRadius: BorderRadius.circular(14),
//       //                         //             border: Border.all(
//       //                         //                 color:
//       //                         //                 userAnswer[pageIndex + 1] ==
//       //                         //                     (i + 1).toString()
//       //                         //                     ? context.primaryColor
//       //                         //                     : context.cardColor.withOpacity(0.5),
//       //                         //                 width: 2
//       //                         //             )
//       //                         //         ),
//       //                         //         child: Padding(
//       //                         //           padding: const EdgeInsets.symmetric(
//       //                         //               horizontal: 10),
//       //                         //           child: buildAnswer(i, pageIndex),
//       //                         //         )
//       //                         //     ),
//       //                         //   ),
//       //                         // ),
//       //                     ],
//       //                   ),
//       //                 ],
//       //               ),
//       //             ),
//       //           ),
//       //           Column(
//       //             children: [
//       //               // ButtonWidget(
//       //               //   mcqIDs: mcqIDs,
//       //               //   mcqQuestions: widget.mcqQuestions,
//       //               //   questionIndex: pageIndex,
//       //               //   controller: widget.controller,
//       //               //   userAnswer: userAnswer,
//       //               //   token: widget.token,
//       //               //   userMcqId: widget.userMCQID,
//       //               //   userAnswerToSend: userAnswerToSend,
//       //               //   userMCQQuestionTimer: userMCQQuestionTimer,
//       //               //   questionTime: int.parse(widget.questionTime),
//       //               //   subjectIndex: widget.subjectIndex,
//       //               //   subjectList: widget.subjectList,
//       //               //   subjectID: widget.subjectID,
//       //               // ),
//       //               const SizedBox(height: 5,),
//       //               // PaginationButtons(
//       //               //   mcqIDs: mcqIDs,
//       //               //   mcqQuestions: widget.mcqQuestions,
//       //               //   questionIndex: pageIndex,
//       //               //   controller: widget.controller,
//       //               //   userAnswer: userAnswer,
//       //               //   token: widget.token,
//       //               //   userMcqId: widget.userMCQID,
//       //               //   userAnswerToSend: userAnswerToSend,
//       //               //   userMCQQuestionTimer: userMCQQuestionTimer,
//       //               //   questionTime: int.parse(widget.questionTime),
//       //               // ),
//       //               const SizedBox(height: 5,),
//       //             ],
//       //           ),
//       //         ],
//       //       );
//       //     },
//       //   ),
//       // ),
//     );
//   }
//
//   showTimeOutDialog(String message, bool isFinished, bool isSave) {
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             height: 150,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 color: context.backgroundColor
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   message.text.xl.make(),
//                   const SizedBox(height: 15,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       isFinished ? TextButton(
//                           onPressed: () {
//                             // // Navigator.pop(context);
//                             // APIServices.getMCQBank(widget.subjectID, widget.token).then((mcqBanks) {
//                             //   if (mcqBanks.status == 200) {
//                             //     Navigator.pushNamedAndRemoveUntil(
//                             //         context,
//                             //         MyRoutes.chooseMCQBankRoute,
//                             //             (route) => false,
//                             //         arguments: {
//                             //           'subjectList': widget.subjectList,
//                             //           'subjectIndex': widget.subjectIndex,
//                             //           'mcqBanks': mcqBanks,
//                             //           'subjectID': widget.subjectID
//                             //         }
//                             //     );
//                             //   } else {
//                             //     showDialog(
//                             //         context: context,
//                             //         builder: (context) => AlertDialog(
//                             //           title: const Text("Unknown Error"),
//                             //           content: const Text("This is an error message!!!"),
//                             //           actions: [
//                             //             TextButton(
//                             //                 onPressed: () {
//                             //                   Navigator.pop(context);
//                             //                   Navigator.pushNamed(context, MyRoutes.loginRoute);
//                             //                 },
//                             //                 child: const Text("OK")),
//                             //           ],
//                             //         )
//                             //     );
//                             //   }
//                             // });
//                           },
//                           child: "Yes".text.end.make()
//                       ) :  TextButton(
//                           onPressed: () {
//                             // // Navigator.pop(context);
//                             // if (!isSave) {
//                             //   APIServices.getMCQBank(widget.subjectID, widget.token).then((mcqBanks) {
//                             //     if (mcqBanks.status == 200) {
//                             //       Navigator.pushNamedAndRemoveUntil(
//                             //           context,
//                             //           MyRoutes.chooseMCQBankRoute,
//                             //               (route) => false,
//                             //           arguments: {
//                             //             'subjectList': widget.subjectList,
//                             //             'subjectIndex': widget.subjectIndex,
//                             //             'mcqBanks': mcqBanks,
//                             //             'subjectID': widget.subjectID
//                             //           }
//                             //       );
//                             //     } else {
//                             //       showDialog(
//                             //           context: context,
//                             //           builder: (context) => AlertDialog(
//                             //             title: const Text("Unknown Error"),
//                             //             content: const Text("This is an error message!!!"),
//                             //             actions: [
//                             //               TextButton(
//                             //                   onPressed: () {
//                             //                     Navigator.pop(context);
//                             //                     Navigator.pushNamed(context, MyRoutes.loginRoute);
//                             //                   },
//                             //                   child: const Text("OK")),
//                             //             ],
//                             //           )
//                             //       );
//                             //     }
//                             //   });
//                             // } else {
//                             //   Navigator.pop(context);
//                             // }
//                           },
//                           child: "Ok".text.end.make()
//                       ),
//                       isFinished ?  TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: "No".text.end.make()
//                       ) : const SizedBox(),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget buildAnswer(int i, int index) {
//     return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               mcqOptionCodes[i].text.xl.color(
//                 userAnswer[index + 1] == (i + 1).toString()
//                     ? context.primaryColor
//                     : context.cardColor,
//               ).make(),
//               const SizedBox(width: 10,),
//               SizedBox(width: MediaQuery.of(context).size.width - 150,
//                   // child: widget.mcqQuestions[index].options[i].text.xl.color(
//                   //   userAnswer[index + 1] == (i + 1).toString()
//                   //       ? context.primaryColor
//                   //       : context.cardColor,
//                   // ).make()
//               ),
//             ],
//           ),
//           userAnswer[index + 1] == (i + 1).toString() ?
//           Icon(Icons.circle, color: context.primaryColor,)
//               :
//           Icon(Icons.circle_outlined, color: context.cardColor.withOpacity(0.5),)
//         ]
//     );
//   }
//
//   // sendData(bool isComplete) {
//   //   // variable to set empty in MCQ IDs - MCQ option for those MCQs which are not answered by the user
//   //   String na= "";
//   //
//   //   Map<int ,String> finalAnswers = {};
//   //   Map<int ,Duration> finalQuestionTime = {};
//   //
//   //   for (var element in mcqIDs) {
//   //     // initially setting all the answers as empty
//   //     finalAnswers[element] = na;
//   //   }
//   //
//   //   for (var element in mcqIDs) {
//   //     finalQuestionTime[element] = Duration(seconds: int.parse(widget.questionTime));
//   //   }
//   //
//   //   // merging the empty answers with selected answers
//   //   final thirdMap = {
//   //     ...finalAnswers,
//   //     ...userAnswerToSend,
//   //   };
//   //
//   //   final thirdMap2 = {
//   //     ...finalQuestionTime,
//   //     ...userMCQQuestionTimer,
//   //   };
//   //
//   //   // storing the MCQ ids in a variable 'q'
//   //   List<int> q = thirdMap.keys.toList();
//   //   // storing the MCQ answers in a variable 'a'
//   //   List<String> a = thirdMap.values.toList();
//   //
//   //   List queRemainingTime = [];
//   //   List queTotalTakenTime = [];
//   //
//   //   // checking if there was a question timer
//   //   if(widget.wantQuestionTimer) {
//   //
//   //     for(int i = 0; i < thirdMap2.length; i++) {
//   //       // storing the MCQ ID form the list of MCQ IDs one by one in each iteration for.....
//   //       int n = widget.mcqQuestions[i].mcqid;
//   //       // .... using them to set per question time as per MCQ IDs
//   //       int? s = thirdMap2[n]?.inSeconds;
//   //       int? r = s!;
//   //       int? t = (int.parse(widget.questionTime) * 60) - r;
//   //
//   //       queRemainingTime.add(r);
//   //       queTotalTakenTime.add(t);
//   //     }
//   //   }
//   //
//   //   SendUserMCQAnswers model = SendUserMCQAnswers(
//   //     token: widget.token,
//   //     userMcqId: int.parse(widget.userMCQID),
//   //     mbid: widget.mbid,
//   //     ans: a,
//   //     mcqid: q,
//   //     queRemainingTime: queRemainingTime,
//   //     queTotalTakenTime: queTotalTakenTime,
//   //   );
//   //
//   //   if (isComplete) {
//   //     APIServices.sendMCQUserAnswer(model, widget.token, true);
//   //   } else {
//   //     APIServices.sendMCQUserAnswer(model, widget.token, false);
//   //   }
//   // }
// }

