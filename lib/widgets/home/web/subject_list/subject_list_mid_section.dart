import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/web/exam/subject_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectListMidSection extends StatefulWidget {
  final List<Result> coursesList; // to store all the data from from home API
  final List<Subject> subjectList; // to store the all subject details for the selected category
  final int catIndex;  // to store the index of category which is selected
  final String token;
  const SubjectListMidSection({Key? key, required this.coursesList, required this.subjectList, required this.catIndex, required this.token}) : super(key: key);

  @override
  State<SubjectListMidSection> createState() => _SubjectListMidSectionState();
}

class _SubjectListMidSectionState extends State<SubjectListMidSection> {

  @override
  Widget build(BuildContext context) {
    print(widget.subjectList[1].subject);
    return Container(
      color: context.backgroundColor,
      constraints: BoxConstraints(
        // maxWidth: 1500,
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15
              ),
              Container(
                // color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 30),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.70,
                  minHeight: MediaQuery.of(context).size.height / 1.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.coursesList[widget.catIndex].category!.text.xl2.semiBold.make(),
                    Container(
                      width: 950,
                      height: MediaQuery.of(context).size.height / 1.7,
                      // color: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 4/2
                          ),
                          itemCount: widget.subjectList.length,
                          itemBuilder: (context, index) => SubjectList(subjectList: widget.subjectList, subjectIndex: index, token: widget.token),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15
              ),
            ],
          ),
          Container(
            color: Colors.green,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height / 3,
            ),
            // child: ,
          )
        ],
      ),
    );
  }
}
