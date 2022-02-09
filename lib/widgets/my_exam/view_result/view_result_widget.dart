import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/widgets/my_exam/view_result/view_result_button.dart';
import 'package:flutter/material.dart';

class ViewResultWidget extends StatefulWidget {
  final int mbid;
  final String? subjectID;
  const ViewResultWidget({Key? key, required this.mbid, this.subjectID}) : super(key: key);

  @override
  _ViewResultWidgetState createState() => _ViewResultWidgetState();
}

class _ViewResultWidgetState extends State<ViewResultWidget> {
  bool isLoading = true;
  String token = "empty";
  final SharedServices _sharedServices = SharedServices();
  List<Result> myExamResultList = [];

  @override
  void initState() {
    super.initState();
    _sharedServices.getData("token").then((value) {
      if (value != null) {
        token = value;
        APIServices.getMyExamResult(widget.mbid.toString(), token).then((response) {
          if (response.toString().isNotEmpty) {
            print(response.result!.length);
            if (response.status == 200) {
              setState(() {
                myExamResultList = response.result!;
                isLoading = false;
              });
            }
          }
        });
      } else {
        token = "empty";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ?
    const Center(child: CircularProgressIndicator(),)
        :
    SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: Align(
          child: ViewResultButton(myExamResultList: myExamResultList),
        )
    );
  }
}
