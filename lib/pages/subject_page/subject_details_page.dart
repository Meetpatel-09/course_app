import 'package:course_app_ui/model/course_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectDetailsPage extends StatefulWidget {
  const SubjectDetailsPage({Key? key, this.subjectList}) : super(key: key);
  final List<Subject>? subjectList;

  @override
  _SubjectDetailsPageState createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {

  late List<Topic>? _topic;
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    if (widget.subjectList![0].topic!.isEmpty) {
      _topic = [];
      _isEmpty = true;
    } else {
      _topic = widget.subjectList![0].topic;
      _isEmpty = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    // ignore: avoid_print
    print(_isEmpty);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Subject ID:",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(widget.subjectList![0].subjectid.toString(),
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
                  Text(widget.subjectList![0].cid.toString(), style: const TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Subject Name: ",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(widget.subjectList![0].subject.toString(),
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Subject Status: ",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(widget.subjectList![0].subjectStatus.toString(),
                        style: const TextStyle(fontSize: 18)),
                  ]
              ),
              const SizedBox(height: 5,),
              const Text("Subject create date:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(widget.subjectList![0].subjectCreatedat.toString(),
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Category:",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(widget.subjectList![0].category.toString(), style: const TextStyle(fontSize: 18)),
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
                    Text(widget.subjectList![0].categoryStatus.toString(),
                        style: const TextStyle(fontSize: 18)),
                  ]
              ),
              const SizedBox(height: 5,),
              const Text("category Create date:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(widget.subjectList![0].categoryCreatedat.toString(),
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _isEmpty ? [] : [
                  const Text("Topic:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(_topic![0].topic.toString(),
                      style: const TextStyle(fontSize: 18)),
                  const Text("Topic id:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(_topic![0].topicid.toString(),
                      style: const TextStyle(fontSize: 18)),
                  const Text("Topic created date:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(_topic![0].topicCreatedat.toString(),
                      style: const TextStyle(fontSize: 18)),
                  const Text("Topic Status:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(_topic![0].topicStatus.toString(),
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
