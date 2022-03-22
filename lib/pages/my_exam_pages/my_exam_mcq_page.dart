import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/pages/my_exam_pages/mobile/my_exam_mcq_page_mobile.dart';
import 'package:course_app_ui/pages/my_exam_pages/web/my_exam_mcq_page_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyExamMCQPage extends StatelessWidget {
  const MyExamMCQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<Result> myExamResultList;
    late MyExamResultModel myExamResult;

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    myExamResult = arg['myExamResult'];
    myExamResultList = myExamResult.result!;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          return MyExamMCQPageWeb(myExamResult: myExamResult, myExamResultList: myExamResultList,);
        } else {
          // Mobile Screen
          return MyExamMCQPageMobile(myExamResult: myExamResult, myExamResultList: myExamResultList,);
        }
      },
    );
  }
}
