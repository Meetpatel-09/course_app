import 'package:course_app_ui/model/my_exam_models/my_exam_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/widgets/home/logout_button.dart';
import 'package:course_app_ui/widgets/my_exam/web/mid_section_subject_list.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/menu_drawer.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/navigation_bar.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyExamSubjectListPage extends StatefulWidget {
  const MyExamSubjectListPage({Key? key}) : super(key: key);

  @override
  State<MyExamSubjectListPage> createState() => _MyExamSubjectListPageState();
}

class _MyExamSubjectListPageState extends State<MyExamSubjectListPage> {
  List<Result> subjectList = [];
  bool _isLoading = true;
  String token = "";
  final SharedServices _sharedServices = SharedServices();

  @override
  void initState() {
    super.initState();
    _sharedServices.getData("token").then((value) {
      if (value != null) {
        token = value;
        APIServices.getMyExams(value).then((result) {
          if (result.status == 200) {
            subjectList = result.result!;
            if (!mounted) return;
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    });
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
      body: _isLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Column(
          children: [
            MidSectionSubjectList(subjectList: subjectList, token: token),
            const BottomNavigation(),
          ],
        ),
      ),
    );
  }
}
