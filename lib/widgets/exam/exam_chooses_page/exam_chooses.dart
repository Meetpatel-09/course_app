import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/user_mcq_settings/user_settings_request_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExamChooses extends StatefulWidget {
  const ExamChooses({Key? key, this.subjectList, this.subjectIndex, required this.token, this.mbid, this.subjectID}) : super(key: key);
  final List<Subject>? subjectList;
  final int? subjectIndex;
  final String token;
  final int? mbid;
  final String? subjectID;

  @override
  _ExamChoosesState createState() => _ExamChoosesState();
}

class _ExamChoosesState extends State<ExamChooses> {
  bool isSelectedE = true;
  bool isSelectedQ = false;
  TextEditingController _examETC = TextEditingController(text: "40");
  TextEditingController _questionETC = TextEditingController(text: "2");
  TextEditingController _numQuestionETC = TextEditingController(text: "20");
  bool _isLoading = true;
  bool _lockSettings = false;

  String numQuestions = "20";
  late int userMCQId;
  late String wantExamTimer;
  late String examTime;
  late String wantQuestionTimer;
  late String questionTime;
  dynamic remainingTime;
  dynamic totalTakenTime;

  @override
  void initState() {
    super.initState();
    APIServices.getUserSettings(widget.mbid.toString(), widget.token.toString()).then((response) {
      if (response.toString().isNotEmpty) {
        if (response.status == 200) {
          setState(() {
            _lockSettings = true;
          });

          if (response.result!.isEmpty) {
            setState(() {
              _lockSettings = false;
            });
          } else {
            userMCQId = response.result![0].userMcqId;
            wantExamTimer = response.result![0].setExamTimer;
            if (response.result![0].setExamTimer == "Yes") {
              isSelectedE = true;
              examTime = response.result![0].examTimer.toString();
              _examETC = TextEditingController(text: examTime);
            } else {
              isSelectedE = false;
            }
            wantQuestionTimer = response.result![0].setPerQueTimer;
            if (response.result![0].setPerQueTimer == "Yes") {
              isSelectedQ = true;
              questionTime = response.result![0].perQueTimer.toString();
              _questionETC = TextEditingController(text: questionTime);
            }
            remainingTime = response.result![0].remainingTime;
            totalTakenTime = response.result![0].totalTakenTime;

            _numQuestionETC = TextEditingController(text: "");
          }
        }

        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_lockSettings);

    return Padding(
      padding: const EdgeInsets.all(18),
      child: _isLoading ? const Center(child: CircularProgressIndicator(),) : Column(
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
          onChanged: (_) {
            if (_lockSettings) {
              null;
            } else {
              setState(() {
                if (isSelectedE) {
                  isSelectedE = false;
                } else {
                  isSelectedE = true;
                }
              },);
            }
          }
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
                enabled: _lockSettings ? false : true,
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
              onChanged: (_) {
                if (_lockSettings) {
                  null;
                } else {
                  setState(() {
                    if (isSelectedQ) {
                      isSelectedQ = false;
                    } else {
                      isSelectedQ = true;
                    }
                  },);
                }
              }
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
                // if user has already attempted the but not completed and again try to give exam.
                // so then lock exam settings so it can edit them
                enabled: _lockSettings ? false : true,
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
                  enabled: _lockSettings ? false : true,
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
        "Questions from ${widget.subjectList![widget.subjectIndex!].totalMcqInSubject} Questions".richText.lg.bold.letterSpacing(1.0).make()
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
            if (_lockSettings) {
              if (wantExamTimer == "Yes") {
                if (wantQuestionTimer == "Yes") {
                    Navigator.pushNamed(
                        context,
                        MyRoutes.startExamRoute,
                        arguments: {
                          'subjectList': widget.subjectList,
                          'index': widget.subjectIndex,
                          'token': widget.token,
                          'mbid': widget.mbid,
                          'wantExamTimer': true,
                          'examTime': examTime,
                          'wantQuestionTimer': true,
                          'questionTime': questionTime,
                          'numQuestions': numQuestions,
                          'user_mcq_id': userMCQId,
                          'subjectID': widget.subjectID
                        }
                    );

                } else {
                  Navigator.pushNamed(
                      context,
                      MyRoutes.startExamRoute,
                      arguments: {
                        'subjectList': widget.subjectList,
                        'index': widget.subjectIndex,
                        'token': widget.token,
                        'mbid': widget.mbid,
                        'wantExamTimer': true,
                        'examTime': examTime,
                        'wantQuestionTimer': false,
                        'questionTime': 'notSet',
                        'numQuestions': numQuestions,
                        'user_mcq_id': userMCQId,
                        'subjectID': widget.subjectID
                      }
                  );
                }
              } else {
                Navigator.pushNamed(
                    context,
                    MyRoutes.startExamRoute,
                    arguments: {
                      'subjectList': widget.subjectList,
                      'index': widget.subjectIndex,
                      'token': widget.token,
                      'mbid': widget.mbid,
                      'wantExamTimer': false,
                      'examTime': 'notSet',
                      'wantQuestionTimer': false,
                      'questionTime': 'notSet',
                      'numQuestions': numQuestions,
                      'user_mcq_id': userMCQId,
                      'subjectID': widget.subjectID
                    }
                );
              }
              // print("locked");
            } else {
              if (validate()) {
                if (isSelectedE) {
                  if (isSelectedQ) {
                    UserSettingsRequestModel model = UserSettingsRequestModel(
                      token: widget.token,
                      setExamTimer: "Yes",
                      examTimer: int.parse(_examETC.value.text),
                      setPerQueTimer: "Yes",
                      perQueTimer: int.parse(_questionETC.value.text),
                      mbid: widget.mbid,
                    );

                    APIServices.userSettings(model).then((response) {
                      if (response.status == 200) {
                        Navigator.pushNamed(
                            context,
                            MyRoutes.startExamRoute,
                            arguments: {
                              'subjectList': widget.subjectList,
                              'index': widget.subjectIndex,
                              'token': widget.token,
                              'mbid': widget.mbid,
                              'wantExamTimer': true,
                              'examTime': _examETC.value.text,
                              'wantQuestionTimer': true,
                              'questionTime': _questionETC.value.text,
                              'numQuestions': _numQuestionETC.value.text,
                              'user_mcq_id': response.userMCQID,
                              'subjectID': widget.subjectID
                            }
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                  title: Text(response.status.toString()),
                                  content: Text(response.msg!),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, MyRoutes.homeRoute);
                                        },
                                        child: const Text("OK")),
                                  ],
                                )
                        );
                      }
                    });
                  } else {
                    UserSettingsRequestModel model = UserSettingsRequestModel(
                      token: widget.token,
                      setExamTimer: "Yes",
                      examTimer: int.parse(_examETC.value.text),
                      setPerQueTimer: "No",
                      mbid: widget.mbid,
                    );

                    APIServices.userSettings(model).then((response) {
                      if (response.status == 200) {
                        Navigator.pushNamed(
                            context,
                            MyRoutes.startExamRoute,
                            arguments: {
                              'subjectList': widget.subjectList,
                              'index': widget.subjectIndex,
                              'token': widget.token,
                              'mbid': widget.mbid,
                              'wantExamTimer': true,
                              'examTime': _examETC.value.text,
                              'wantQuestionTimer': false,
                              'questionTime': 'notSet',
                              'numQuestions': _numQuestionETC.value.text,
                              'user_mcq_id': response.userMCQID,
                              'subjectID': widget.subjectID
                            }
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                  title: Text(response.status.toString()),
                                  content: Text(response.msg!),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, MyRoutes.homeRoute);
                                      },
                                      child: const Text("OK")),
                                  ],
                                )
                        );
                      }
                    });
                  }
                } else {
                  UserSettingsRequestModel model = UserSettingsRequestModel(
                    token: widget.token,
                    setExamTimer: "No",
                    setPerQueTimer: "No",
                    mbid: widget.mbid,
                  );

                  APIServices.userSettings(model).then((response) {
                    if (response.status == 200) {
                      Navigator.pushNamed(
                          context,
                          MyRoutes.startExamRoute,
                          arguments: {
                            'subjectList': widget.subjectList,
                            'index': widget.subjectIndex,
                            'token': widget.token,
                            'mbid': widget.mbid,
                            'wantExamTimer': false,
                            'examTime': 'notSet',
                            'wantQuestionTimer': false,
                            'questionTime': 'notSet',
                            'numQuestions': _numQuestionETC.value.text,
                            'user_mcq_id': response.userMCQID,
                            'subjectID': widget.subjectID
                          }
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) =>
                          AlertDialog(
                            title: Text(response.status.toString()),
                            content: Text(response.msg!),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, MyRoutes.homeRoute);
                                  },
                                  child: const Text("OK")),
                            ],
                          )
                      );
                    }
                  });
                }
              }
            }
          },
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Continue",
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
      if (int.parse(_questionETC.value.text) > 10 || int.parse(_questionETC.value.text) < 1 || int.parse(_numQuestionETC.value.text) > widget.subjectList![widget.subjectIndex!].totalMcqInSubject!) {
        return false;
      }
      return true;
    }
  }

  // Validating the exam time text field
  String? get _examErrorText {
    final text = _examETC.value.text;
    if (text.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Validating the time per question text field
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

  // Validating the number of question text field
  String? get _numQuestionErrorText {
    final text = _numQuestionETC.value.text;
    if (text.isEmpty) {
      return 'Field can\'t be empty';
    } else if (int.parse(text) > widget.subjectList![widget.subjectIndex!].totalMcqInSubject!) {
      return 'Can\'t be more than total';
    } else if (int.parse(text) < 10) {
      return 'Can\'t be less than 10';
    }
    return null;
  }
}
