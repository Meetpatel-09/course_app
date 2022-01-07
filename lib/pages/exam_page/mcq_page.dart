import 'package:course_app_ui/model/course_model.dart';
// import 'package:course_app_ui/model/mcq_models/user_settings_request_model.dart';
// import 'package:course_app_ui/pages/exam_page/temp_page.dart';
// import 'package:course_app_ui/services/api_service.dart';
// import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQPage extends StatefulWidget {
  const MCQPage({Key? key}) : super(key: key);

  @override
  State<MCQPage> createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {
  List<Subject>? subjectList = [];
  int index = 0;
  String wantExamTimer = "No";
  String wantQuestionTimer = "No";
  String examTime = "notSet";
  String questionTime = "notSet";
  late String numQuestions;
  String token = "empty";
  int mbid = 0;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectList = arg['subjectList'];
    index = arg['index'];
    token = arg['token'];
    mbid = arg['mbid'];
    examTime = arg['examTime'];
    wantExamTimer = arg['wantExamTimer'];
    wantQuestionTimer = arg['wantQuestionTimer'];
    questionTime = arg['questionTime'];
    numQuestions = arg['numQuestions'];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Exam".text.make()
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: container(),
        )
      ),
    );
  }

  Widget container() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // '${subjectList![index].subject}'.richText.lg.make(),
          // const SizedBox(height: 10,),
          // examTime.richText.lg.make(),
          // const SizedBox(height: 10,),
          // questionTime.richText.lg.make(),
          // const SizedBox(height: 10,),
          // numQuestions.text.lg.make(),
          // const SizedBox(height: 10,),
          // token.richText.lg.make(),
          // const SizedBox(height: 10,),
          // mbid.text.lg.make()
          nextButton()
        ],
      ),
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
            // Start button with post user mcq settings
              // if (wantExamTimer == "Yes") {
              //   if (wantQuestionTimer == "Yes") {
              //     UserSettingsRequestModel model = UserSettingsRequestModel(
              //         token: token,
              //         setExamTimer: wantExamTimer,
              //         examTimer: int.parse(examTime),
              //         setPerQueTimer: wantQuestionTimer,
              //         perQueTimer: int.parse(questionTime),
              //         mbid: mbid,
              //     );
              //
              //     APIServices.userSettings(model).then((response) {
              //       if (response.status == 200) {
              //         Navigator.push(
              //             context,
              //           MaterialPageRoute (
              //             builder: (BuildContext context) => const TempPage(),
              //           ),
              //         );
              //       } else {
              //         showDialog(
              //             context: context,
              //             builder: (context) => AlertDialog(
              //               title: const Text("Unknown Error"),
              //               content: const Text("This is an error message!!!"),
              //               actions: [
              //                 TextButton(
              //                     onPressed: () {
              //                       Navigator.pop(context);
              //                       Navigator.pushNamed(context, MyRoutes.homeRoute);
              //                     },
              //                     child: const Text("OK")),
              //               ],
              //             )
              //         );
              //       }
              //     });
              //   } else {
              //     UserSettingsRequestModel model = UserSettingsRequestModel(
              //         token: token,
              //         setExamTimer: wantExamTimer,
              //         examTimer: int.parse(examTime),
              //         setPerQueTimer: wantQuestionTimer,
              //         mbid: mbid,
              //     );
              //
              //     APIServices.userSettings(model).then((response) {
              //       if (response.status == 200) {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute (
              //             builder: (BuildContext context) => const TempPage(),
              //           ),
              //         );
              //       } else {
              //         showDialog(
              //             context: context,
              //             builder: (context) => AlertDialog(
              //               title: const Text("Unknown Error"),
              //               content: const Text("This is an error message!!!"),
              //               actions: [
              //                 TextButton(
              //                     onPressed: () {
              //                       Navigator.pop(context);
              //                       Navigator.pushNamed(context, MyRoutes.homeRoute);
              //                     },
              //                     child: const Text("OK")),
              //               ],
              //             )
              //         );
              //       }
              //     });
              //   }
              // } else {
              //   UserSettingsRequestModel model = UserSettingsRequestModel(
              //     token: token,
              //     setExamTimer: wantExamTimer,
              //     setPerQueTimer: wantQuestionTimer,
              //     mbid: mbid,
              //   );
              //
              //   APIServices.userSettings(model).then((response) {
              //     if (response.status == 200) {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute (
              //           builder: (BuildContext context) => const TempPage(),
              //         ),
              //       );
              //     } else {
              //       showDialog(
              //           context: context,
              //           builder: (context) => AlertDialog(
              //             title: const Text("Unknown Error"),
              //             content: const Text("This is an error message!!!"),
              //             actions: [
              //               TextButton(
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                     Navigator.pushNamed(context, MyRoutes.homeRoute);
              //                   },
              //                   child: const Text("OK")),
              //             ],
              //           )
              //       );
              //     }
              //   });
              // }


            // new codw
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
}
