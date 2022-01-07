import 'package:course_app_ui/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TempPage extends StatefulWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  // List<Subject>? subjectList = [];
  // int index = 0;
  // String wantExamTime = "No";
  // String wantQuestionTime = "No";
  // String examTime = "notSet";
  // String questionTime = "notSet";
  // late String numQuestions;
  // String token = "empty";
  // int mbid = 0;

  @override
  Widget build(BuildContext context) {
    // final arg = ModalRoute.of(context)!.settings.arguments as Map;
    // subjectList = arg['subjectList'];
    // index = arg['index'];
    // token = arg['token'];
    // mbid = arg['mbid'];
    // examTime = arg['examTime'];
    // wantExamTime = arg['wantExamTime'];
    // wantQuestionTime = arg['wantQuestionTime'];
    // questionTime = arg['questionTime'];
    // numQuestions = arg['numQuestions'];

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        "done".richText.make()
      ],
    );
  }
}
