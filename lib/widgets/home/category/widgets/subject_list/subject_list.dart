import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/home/category/widgets/subject_list/widgets/explore_more.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectList extends StatelessWidget {
  final List<Subject> subjectList;
  final int index;
  const SubjectList({Key? key, required this.subjectList, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width / 1.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: context.primaryColor),
          color: context.backgroundColor
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          SizedBox(
            height: 100,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(subjectList[index].subject.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
          const SizedBox(height: 15,),
          Align(child: ExploreMore(subjectList: subjectList, index: index,)),
          ],
        ),
      );
  }
}
