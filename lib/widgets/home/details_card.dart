import 'package:course_app_ui/model/subject_model.dart';
import 'package:course_app_ui/widgets/home/subject_list.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({Key? key}) : super(key: key);

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {

  List<SubjectModel> _subjects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getSubjects();
  }

  Future<void> getSubjects() async {
    _subjects = await APIServices.getSubject();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: _isLoading ? const Center(child: CircularProgressIndicator())
             : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _subjects.length,
                itemBuilder: (context, index) {
                  return SubjectList(
                    subjectId: _subjects[index].subjectid.toString(),
                    cId: _subjects[index].cid.toString(),
                    subjectName: _subjects[index].subject,
                    subjectStatus: _subjects[index].subjectStatus.toString(),
                    subjectCratedDate: _subjects[index].subjectCreatedat,
                    category: _subjects[index].category,
                    categoryStatus: _subjects[index].categoryStatus.toString(),
                    categoryCreatedDate: _subjects[index].categoryCreatedat,
                  );
                },
             ),
    );
  }
}
