import 'package:course_app_ui/model/course_model.dart';
// import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/exam/start_exam_page/start_exam_button.dart';
// import 'package:course_app_ui/model/mcq_models/user_settings_request_model.dart';
// import 'package:course_app_ui/pages/exam_page/temp_page.dart';
// import 'package:course_app_ui/services/api_service.dart';
// import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class StartExamPage extends StatefulWidget {
  const StartExamPage({Key? key}) : super(key: key);

  @override
  State<StartExamPage> createState() => _StartExamPageState();
}

class _StartExamPageState extends State<StartExamPage> {
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

  Widget nextButton() => StartExamButton(
    token: token,
    index: index,
    mbid: mbid,
    subjectList: subjectList!,
    wantExamTimer: wantExamTimer,
    examTime: examTime,
    wantQuestionTimer: wantQuestionTimer,
    questionTime: questionTime,
    numQuestions: numQuestions,
  );
}
