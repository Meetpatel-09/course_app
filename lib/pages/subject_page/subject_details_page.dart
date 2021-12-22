import 'package:course_app_ui/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectDetailsPage extends StatelessWidget {
  const SubjectDetailsPage({Key? key}) : super(key: key);

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
          // margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(color: context.primaryColor),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Subject ID:",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(subjectList[index].subjectid.toString(),
                style: const TextStyle(fontSize: 18)),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("C ID:",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(subjectList[index].cid.toString(), style: const TextStyle(fontSize: 18)),
          ],
        ),
        const SizedBox(height: 5,),
        const Text("Subject Name: ",
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(subjectList[index].subject.toString(),
            style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 5,),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Subject Status: ",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(subjectList[index].subjectStatus.toString(),
                  style: const TextStyle(fontSize: 18)),
            ]
        ),
        const SizedBox(height: 5,),
        const Text("Subject create date:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(subjectList[index].subjectCreatedat.toString(),
            style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 5,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Category:",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(subjectList[index].category.toString(), style: const TextStyle(fontSize: 18)),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("category Status: ",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(subjectList[index].categoryStatus.toString(),
                  style: const TextStyle(fontSize: 18)),
            ]
        ),
        const SizedBox(height: 5,),
        const Text("category Create date:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(subjectList[index].categoryCreatedat.toString(),
            style: const TextStyle(fontSize: 18)),
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
