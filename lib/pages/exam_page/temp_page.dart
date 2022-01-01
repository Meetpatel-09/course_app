import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TempPage extends StatefulWidget {
  const TempPage({Key? key, this.subjectList, this.index}) : super(key: key);
  final List<Subject>? subjectList;
  final int? index;

  @override
  _TempPageState createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  bool isSelectedE = true;
  bool isSelectedQ = false;
  final _examETC = TextEditingController(text: "40");
  final _questionETC = TextEditingController(text: "2");
  final _numQuestionETC = TextEditingController(text: "20");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          "Welcome to MCQ Page. By appearing for the exam, students will be able to understand various question patterns. We also provide you with the statistics based on your MCQ results. You may choose timer for every MCQ.".richText.justify.make(),
          const SizedBox(height: 18.0,),
          Container(color: context.cardColor.withOpacity(0.3), height: 2,),
          const SizedBox(height: 18.0,),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: context.backgroundColor
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                numOfQuestions(),
                const SizedBox(height: 40.0,),
                wantTimerExam(),
                examTimerTextField(),
                const SizedBox(height: 40.0,),
                wantTimerQuestion(),
                questionTimerTextField(),
                const SizedBox(height: 45.0,),
                nextButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget wantTimerExam() => Row(
    children: [
      "Want to set timer?".text.lg.bold.letterSpacing(1).make(),
      Switch(
          value: isSelectedE,
          onChanged: (_) => setState(() {
            if (isSelectedE) {
              isSelectedE = false;
            } else {
              isSelectedE = true;
            }
          },)
      )
    ],
  );

  Widget examTimerTextField() {
    if (isSelectedE ) {
      return Row(
        children: [
          "Set  ".text.lg.make(),
          SizedBox(
            width: 50,
            child: TextField(
              onChanged: (_) => setState(() {}),
              keyboardType: TextInputType.number,
              controller: _examETC,
              textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  isDense: true,
                  errorText: _examErrorText
                )
            ),
          ),
          " minutes timer for exam".text.lg.make()
        ],
      );
    } else {
      return const SizedBox(height: 30,);
    }
  }

  Widget wantTimerQuestion() {
    if (isSelectedE) {
      return Row(
        children: [
          "Want to set per Question?".text.lg.bold.letterSpacing(1).make(),
          Switch(
              value: isSelectedQ,
              onChanged: (_) =>
                  setState(() {
                    if (isSelectedQ) {
                      isSelectedQ = false;
                    } else {
                      isSelectedQ = true;
                    }
                  },)
          )
        ],
      );
    } else {
      return const SizedBox(height: 42,);
    }
  }

  Widget questionTimerTextField() {
    if (isSelectedQ && isSelectedE) {
      return Row(
        children: [
          "Set ".text.lg.make(),
          SizedBox(
            width: 50,
            child: TextField(
              onChanged: (_) => setState(() {}),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              controller: _questionETC,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                errorText: _questionErrorText
              )
            ),
          ),
          " minutes timer per Question".text.lg.make()
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget numOfQuestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            "Give exam of ".richText.lg.bold.letterSpacing(1.0).make(),
            SizedBox(
              width: 50,
              child: TextField(
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                controller: _numQuestionETC,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  isDense: true,
                  errorText: _numQuestionErrorText,
                )
              ),
            ),
            " number of ".richText.lg.bold.letterSpacing(1.0).make(),
          ],
        ),
        const SizedBox(height: 5,),
        "Questions from ${widget.subjectList![widget.index!].totalMcqInSubject} Questions".richText.lg.bold.letterSpacing(1.0).make()
      ],
    );
  }

  Widget nextButton() {
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
        onPressed: () async {
          if (validate()) {
            if (isSelectedE) {
              if (isSelectedQ) {
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
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 55),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Start Exam",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        )
      ),
    );
  }

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
