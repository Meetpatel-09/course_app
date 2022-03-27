import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/widgets/exam/web/exam/subject_list.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectListMidSection extends StatefulWidget {
  final List<Result> coursesList; // to store all the data from from home API
  final List<Subject> subjectList; // to store the all subject details for the selected category
  final int catIndex;  // to store the index of category which is selected
  const SubjectListMidSection({Key? key, required this.coursesList, required this.subjectList, required this.catIndex}) : super(key: key);

  @override
  State<SubjectListMidSection> createState() => _SubjectListMidSectionState();
}

class _SubjectListMidSectionState extends State<SubjectListMidSection> {
  final SharedServices _sharedServices = SharedServices();
  String token = "empty";

  @override
  void initState() {
    super.initState();
    _sharedServices.getData("token").then((value) {
      if (value != null) {
        setState(() {
          token = value;
        });
      } else {
        token = "notSet";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Colors.purple,
            padding: const EdgeInsets.only(top: 30.0, left: 55.0, right: 55.0),
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.70,
            ),
            child: Column(
              children: [
                widget.coursesList[widget.catIndex].category!.text.xl2.semiBold.make(),
                Container(
                  width: 950,
                  height: ResponsiveWidget.isSmallScreen(context) ? 205.0 * (widget.subjectList.length) : ResponsiveWidget.isMediumScreen(context) ? 180.0 * (widget.subjectList.length / 2) : 140.0 * (widget.subjectList.length / 3),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 1 : ResponsiveWidget.isMediumScreen(context) ? 2 : 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: ResponsiveWidget.isSmallScreen(context) ? 4/2 : ResponsiveWidget.isMediumScreen(context) ? 4/1.4 : 6/2.2
                      ),
                      itemCount: widget.subjectList.length,
                      itemBuilder: (context, index) => SubjectList(subjectList: widget.subjectList, subjectIndex: index, token: token, isRecent: false),
                  ),
                )
              ],
            ),
          ),
          Divider(
            thickness: 2, // thickness of the line
            color: Colors.black.withOpacity(0.3), // The color to use when painting the line.
            height: 20, // The divider's height extent.
          ),
          Container(
            padding: ResponsiveWidget.isSmallScreen(context) ? const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0) : const EdgeInsets.symmetric(horizontal: 155.0, vertical: 50.0),
            child: Column(
              crossAxisAlignment: ResponsiveWidget.isSmallScreen(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                "Recently Visited Subjects".text.xl2.semiBold.make(),
                Container(
                  height: ResponsiveWidget.isSmallScreen(context) ? 185 * 3 : 200,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ListView.builder(
                    scrollDirection: ResponsiveWidget.isSmallScreen(context) ? Axis.vertical : Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == widget.subjectList.length - 1
                          ? const EdgeInsets.all(0)
                          : const EdgeInsets.only(right: 8, top: 12),
                        child: SubjectList(subjectList: widget.subjectList, subjectIndex: index, token: token, isRecent: true),
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
