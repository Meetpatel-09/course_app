import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExamChooses extends StatefulWidget {
  const ExamChooses({Key? key, this.subjectList, this.index}) : super(key: key);
  final List<Subject>? subjectList;
  final int? index;

  @override
  _ExamChoosesState createState() => _ExamChoosesState();
}

class _ExamChoosesState extends State<ExamChooses> {
  List<bool> isSelectedE = [true, false];
  List<bool> isSelectedQ = [false, true];
  int eIndex = 0;
  int qIndex = 1;
  final _examETC = TextEditingController(text: "60");
  final _questionETC = TextEditingController(text: "2");
  final _numQuestionETC = TextEditingController(text: "20");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            "Welcome to MCQ Page. By appearing for the exam, students will be able to understand various question patterns. We also provide you with the statistics based on your MCQ results. You may choose timer for every MCQ.".richText.justify.make(),
            const SizedBox(height: 18.0,),
            Container(color: context.cardColor.withOpacity(0.3), height: 2,),
            const SizedBox(height: 18.0,),
            "Want to set timer?".text.lg.bold.letterSpacing(1).make(),
            const SizedBox(height: 8.0,),
            wantExamTimerButtons(),
            const SizedBox(height: 20.0,),
            examTimerMinutes(),
            wantQuesTimerTextField(),
            "Choose number of Questions of for ${widget.subjectList![widget.index!].totalMcqInSubject}".text.lg.justify.bold.letterSpacing(1).make(),
            const SizedBox(height: 18,),
            numQuesTextField(),
            const SizedBox(height: 18.0,),
            startExam(),
            const SizedBox(height: 18.0,),
          ],
      ),
    );
  }

  Widget wantExamTimerButtons() => ToggleButtons(
    isSelected: isSelectedE,
    renderBorder: true,
    borderColor: context.cardColor,
    selectedBorderColor: context.cardColor,
    borderRadius: BorderRadius.circular(15.0),
    borderWidth: 2,
    selectedColor: MyTheme.black,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        color: isSelectedE[0] ? Colors.greenAccent : Colors.transparent,
        child: const Text('Yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
        color: isSelectedE[1] ? Colors.redAccent : Colors.transparent,
        child: const Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))
    ],
    onPressed: (int newIndex) {
      setState(() {
        for (int index = 0; index < isSelectedE.length; index++) {
          if (index == newIndex) {
            isSelectedE[index] = true;
            eIndex = newIndex;
          } else {
            isSelectedE[index] = false;
          }
        }
      });
    },
  );

  Widget examTimerMinutes() {
    if(eIndex == 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            "Set timer for exam(in minutes)".text.lg.bold.letterSpacing(1).make(),
            const SizedBox(height: 18,),
            SizedBox(
              width: 160,
              child: TextField(
                onChanged: (_) => setState(() {}),
                controller: _examETC,
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: context.cardColor
                    ),
                    labelText: "Enter Minutes",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: context.cardColor, width: 1)
                    ),
                    errorText: _examErrorText,
                ),
                style: TextStyle(
                  color: context.cardColor,
                ),
                cursorColor: context.cardColor,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 18,),
            "Set per question timer(in minutes)".text.lg.bold.letterSpacing(1).make(),
            const SizedBox(height: 8,),
            wantQuesTimerButtons(),
            const SizedBox(height: 22,),

          ],
        );
    } else {
        return const SizedBox();
    }
  }

  Widget wantQuesTimerButtons() {
    return ToggleButtons(
      isSelected: isSelectedQ,
      renderBorder: true,
      borderColor: context.cardColor,
      selectedBorderColor: context.cardColor,
      borderRadius: BorderRadius.circular(15.0),
      borderWidth: 2,
      selectedColor: MyTheme.black,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            color: isSelectedQ[0] ? Colors.greenAccent : Colors.transparent,
            child: const Text('Yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
            color: isSelectedQ[1] ? Colors.redAccent : Colors.transparent,
            child: const Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))
      ],
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < isSelectedQ.length; index++) {
            if (index == newIndex) {
              isSelectedQ[index] = true;
              qIndex = newIndex;
            } else {
              isSelectedQ[index] = false;
            }
          }
        });
      },
    );
  }

  Widget wantQuesTimerTextField() {
    if(qIndex == 0 && eIndex == 0) {
      return SizedBox(
        width: 160,
        height: 80,
        child: TextField(
          onChanged: (_) => setState(() {}),
          controller: _questionETC,
          decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: context.cardColor
              ),
              labelText: "Enter Minutes",
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: context.cardColor, width: 1)
              ),
              errorText: _questionErrorText
          ),
          style: TextStyle(
            color: context.cardColor,
          ),
          cursorColor: context.cardColor,
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.next,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget numQuesTextField() {
    return SizedBox(
      width: 160,
      child: TextField(
        onChanged: (_) => setState(() {}),
        controller: _numQuestionETC,
        decoration: InputDecoration(
            labelStyle: TextStyle(
                color: context.cardColor
            ),
            labelText: "Enter Questions",
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.cardColor, width: 1)
            ),
            errorText: _numQuestionErrorText
        ),
        style: TextStyle(
          color: context.cardColor,
        ),
        cursorColor: context.cardColor,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget startExam() => Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          if (validate()) {
            if (eIndex == 0) {
              if (qIndex == 0) {
                Navigator.pushNamed(
                    context,
                    MyRoutes.mcqRoute,
                    arguments: {
                      'subjectList': widget.subjectList,
                      'index': widget.index,
                      'examTime': _examETC.value.text,
                      'questionTime': _questionETC.value.text,
                      'numQuestions': _numQuestionETC.value.text
                    }
                );
              } else {
                Navigator.pushNamed(
                    context,
                    MyRoutes.mcqRoute,
                    arguments: {
                      'subjectList': widget.subjectList,
                      'index': widget.index,
                      'examTime': _examETC.value.text,
                      'questionTime': 'notSet',
                      'numQuestions': _numQuestionETC.value.text
                    }
                );
              }
            } else {
              Navigator.pushNamed(
                  context,
                  MyRoutes.mcqRoute,
                  arguments: {
                    'subjectList': widget.subjectList,
                    'index': widget.index,
                    'examTime': 'notSet',
                    'questionTime': 'notSet',
                    'numQuestions': _numQuestionETC.value.text
                  }
              );
            }
          }
        },
        child: Text('Start Exam',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: MyTheme.white),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          primary: context.primaryColor,
          elevation: 0,
          shape: const StadiumBorder(),
        ),
      )
  );

  bool validate() {
    if(_examETC.text.isEmpty || _questionETC.text.isEmpty || _numQuestionETC.text.isEmpty) {
      return false;
    } else {
      if (int.parse(_questionETC.value.text) > 10 || int.parse(_questionETC.value.text) < 1 || int.parse(_numQuestionETC.value.text) > widget.subjectList![widget.index!].totalMcqInSubject!) {
        return false;
      }
      return true;
    }
  }

  String? get _examErrorText {
    final text = _examETC.value.text;
    if (text.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  String? get _questionErrorText {
    final text = _questionETC.value.text;
    if (text.isEmpty) {
      return 'Field can\'t be empty';
    } else if (int.parse(text) > 10) {
      return 'Can\'t be more than 10';
    } else if (int.parse(text) < 1) {
      return 'Can\'t be less than 1';
    }
    return null;
  }

  String? get _numQuestionErrorText {
    final text = _numQuestionETC.value.text;
    if (text.isEmpty) {
      return 'Field can\'t be empty';
    } else if (int.parse(text) > widget.subjectList![widget.index!].totalMcqInSubject!) {
      return 'Can\'t be more than total';
    } else if (int.parse(text) < 10) {
      return 'Can\'t be less than 10';
    }
    return null;
  }
}
