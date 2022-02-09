import 'package:course_app_ui/widgets/my_exam/view_result/view_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewResultPage extends StatefulWidget {
  const ViewResultPage({Key? key}) : super(key: key);

  @override
  _ViewResultPageState createState() => _ViewResultPageState();
}

class _ViewResultPageState extends State<ViewResultPage> {

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String subjectID = arg['subjectID'];
    int mbid = arg['mbid'];

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "My Exam".text.make()
            ],
          ),
        ),
        body: ViewResultWidget(mbid: mbid, subjectID: subjectID),
    );
  }
}
