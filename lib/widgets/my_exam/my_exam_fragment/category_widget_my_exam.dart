import 'package:course_app_ui/model/my_exam_models/my_exam_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/widgets/my_exam/my_exam_fragment/subject_list.dart';
import 'package:flutter/material.dart';

class CategoryWidgetMyExam extends StatefulWidget {
  const CategoryWidgetMyExam({Key? key}) : super(key: key);

  @override
  _CategoryWidgetMyExamState createState() => _CategoryWidgetMyExamState();
}

class _CategoryWidgetMyExamState extends State<CategoryWidgetMyExam> {
  late List<Result> _subjectList;
  bool _isLoading = true;
  final SharedServices _sharedServices = SharedServices();

  @override
  void initState() {
    super.initState();
    _sharedServices.getData("token").then((value) {
      print(value);
      if (value != null) {
        APIServices.getMyExams(value).then((result) {
          if (result.status == 200) {
            _subjectList = result.result!;
            if (!mounted) return;
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(heightFactor: 10, child: CircularProgressIndicator())
        : detailsCard();
  }

  Widget detailsCard() => Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.height -  (MediaQuery.of(context).size.height / 4),
      child: ListView.builder(
          itemCount: _subjectList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: index == _subjectList.length - 1
                  ? const EdgeInsets.only(bottom: 60)
                  : const EdgeInsets.only(bottom: 8),
              child: SubjectList(
                  subjectList: _subjectList,
                  subjectIndex: index),
            );
          }
      )
  );
}
