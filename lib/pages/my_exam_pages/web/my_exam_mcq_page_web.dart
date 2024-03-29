import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/my_exam/mid_section_my_exam.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/menu_drawer.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/navigation_bar.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/material.dart';

class MyExamMCQPageWeb extends StatefulWidget {
  final List<Result> myExamResultList;
  final MyExamResultModel myExamResult;
  const MyExamMCQPageWeb({Key? key, required this.myExamResultList, required this.myExamResult}) : super(key: key);

  @override
  State<MyExamMCQPageWeb> createState() => _MyExamMCQPageWebState();
}

class _MyExamMCQPageWebState extends State<MyExamMCQPageWeb> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    // initializing the page controller
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    // disposing the page controller
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ResponsiveWidget.isSmallScreen(context)
          ?
      AppBar(
        title: const Text('My Exam'),
      )
          :
      PreferredSize(
          child: const CustomNavigationBar(),
          preferredSize: Size(screenSize.width, screenSize.height)
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MidSectionMyExam(
              controller: controller,
              myExamResultList: widget.myExamResultList,
              myExamResult: widget.myExamResult,
              onChangedPage: (page) {
                if (page == widget.myExamResultList.length - 1) {
                  setState(() {
                    // btnText = "last page";
                  });
                }
              },
            ),
            const BottomNavigation(),
          ],
        ),
      ),
    );
  }
}
