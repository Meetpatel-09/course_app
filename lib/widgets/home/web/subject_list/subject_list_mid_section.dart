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
    return Container(
      color: context.backgroundColor,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15
              ),
              Container(
                // color: Colors.purple,
                padding: const EdgeInsets.only(top: 30.0, left: 55.0, right: 55.0),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.70,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.coursesList[widget.catIndex].category!.text.xl2.semiBold.make(),
                    Container(
                      width: 950,
                      height: 140.0 * (widget.subjectList.length / 3.0),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 6/2.2
                          ),
                          itemCount: widget.subjectList.length,
                          itemBuilder: (context, index) => SubjectList(subjectList: widget.subjectList, subjectIndex: index, token: widget.token, isResent: false),
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
          Divider(
            thickness: 2, // thickness of the line
            color: Colors.black.withOpacity(0.3), // The color to use when painting the line.
            height: 20, // The divider's height extent.
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 155.0, vertical: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Recently Visited Subjects".text.xl2.semiBold.make(),
                Container(
                  height: 175,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == widget.subjectList.length - 1
                          ? const EdgeInsets.all(0)
                          : const EdgeInsets.only(right: 8),
                        child: SubjectList(subjectList: widget.subjectList, subjectIndex: index, token: widget.token, isResent: true),
                      );
                    }
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
