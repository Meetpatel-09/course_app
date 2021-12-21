import 'package:course_app_ui/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectDetailsPage extends StatefulWidget {
  const SubjectDetailsPage({Key? key}) : super(key: key);


  @override
  _SubjectDetailsPageState createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {

  late List<Topic>? _topic;
  bool _isEmpty = true;
  List<Subject>? subjectList = [];
  int? index = 0;


  @override
  void initState() {
    super.initState();



    // if (subjectList![index!].topic == null) {
    //   _topic = [];
    //   _isEmpty = true;
    // } else {
    //   _topic = subjectList![index!].topic;
    //   _isEmpty = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectList = arg['subjectList'];
    index = arg['index'];

    print(subjectList);
    print(index);
    // final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    //
    // if (arguments != null) print(arguments['subjectList']);
    // List<Subject> subjectListz = arguments['subjectList'];
    // print(subjectListz[0].subject);
    // ignore: avoid_print
    // print(_isEmpty);
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
                  Text(subjectList![index!].subjectid.toString(),
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
                  Text(subjectList![index!].cid.toString(), style: const TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Subject Name: ",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(subjectList![index!].subject.toString(),
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
                    Text(subjectList![index!].subjectStatus.toString(),
                        style: const TextStyle(fontSize: 18)),
                  ]
              ),
              const SizedBox(height: 5,),
              const Text("Subject create date:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(subjectList![index!].subjectCreatedat.toString(),
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Category:",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(subjectList![index!].category.toString(), style: const TextStyle(fontSize: 18)),
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
                    Text(subjectList![index!].categoryStatus.toString(),
                        style: const TextStyle(fontSize: 18)),
                  ]
              ),
              const SizedBox(height: 5,),
              const Text("category Create date:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(subjectList![index!].categoryCreatedat.toString(),
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
