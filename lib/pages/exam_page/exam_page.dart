import 'package:course_app_ui/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Subject>? subjectList = [];
    int index = 0;
    bool _isEmpty = true;

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectList = arg['subjectList'];
    index = arg['index'];

    if (subjectList != null) {
      _isEmpty = false;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: context.backgroundColor
          ),
          child: _isEmpty ? Center(child: "Something went wrong".text.make(),) : subList(subjectList, index)
        ),
      ),
    );
  }

  Widget subList(List<Subject>? subjectList, int index) {
    List<Topic>? _topic = [];
    _topic = subjectList![index].topic;
    bool _isEmpty = true;
    // ignore: prefer_is_empty
    if (_topic!.length != 0) {
      _isEmpty = false;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Subject Name: ",
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subjectList[index].subject.toString().richText.size(18).make(),
        const SizedBox(height: 5,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _isEmpty ? [] : [
            const Text("Topic:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(_topic[0].topic.toString(),
                style: const TextStyle(fontSize: 18)),
            const Text("Topic id:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(_topic[0].topicid.toString(),
                style: const TextStyle(fontSize: 18)),
            const Text("Topic created date:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(_topic[0].topicCreatedat.toString(),
                style: const TextStyle(fontSize: 18)),
            const Text("Topic Status:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(_topic[0].topicStatus.toString(),
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ],
    );
  }
}
