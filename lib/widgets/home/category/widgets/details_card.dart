import 'package:course_app_ui/model/subject_model.dart';
import 'package:course_app_ui/widgets/home/category/widgets/subject_list.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({Key? key}) : super(key: key);

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {

  // List<SubjectModel> _subjects = [];
  // bool _isLoading = true;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getSubjects();
  // }
  //
  // Future<void> getSubjects() async {
  //   // _subjects = await APIServices.getSubject();
  //   setState(() {
  //     // _isLoading = false;
  //   });
  // }

  // _isLoading ? const Center(child: CircularProgressIndicator())
  //     :

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: FutureBuilder<List<SubjectModel>>(
                future: APIServices.getSubject(),
                builder: (context, snapshot) {
                  final subjects = snapshot.data;

                  switch(snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Center(child: 'Something went wrong!!!'.text.make());
                      } else {
                        return buildList(subjects!);
                      }
                  }
                },
             ),
    );
  }

  Widget buildList(List<SubjectModel> subjects) => ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: subjects.length,
    itemBuilder: (context, index) {
      // final subject = subjects[index];
      return SubjectList(
        subjectId: subjects[index].subjectid.toString(),
        cId: subjects[index].cid.toString(),
        subjectName: subjects[index].subject,
        subjectStatus: subjects[index].subjectStatus.toString(),
        subjectCratedDate: subjects[index].subjectCreatedat,
        category: subjects[index].category,
        categoryStatus: subjects[index].categoryStatus.toString(),
        categoryCreatedDate: subjects[index].categoryCreatedat,
      );
    },
  );
}

