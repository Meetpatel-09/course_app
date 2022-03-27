import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/exam/web/choose_mcq_bank/mid_section_choose_mcq_bank.dart';
import 'package:course_app_ui/widgets/home/logout_button.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/menu_drawer.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/navigation_bar.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChooseMCQBankPageWeb extends StatelessWidget {
  final List<Subject> subjectList;
  final int subjectIndex;
  final MCQBanksModel mcqBanks;
  final String token;
  final String subjectID;
  const ChooseMCQBankPageWeb({Key? key, required this.subjectList, required this.subjectIndex, required this.mcqBanks, required this.token, required this.subjectID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // when user press the back button redirecting to home page using WillPopScope
    // done because if use comes to this page after completing exam and then tries to go back
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
        return true;
      },
      child: Scaffold(
        appBar: ResponsiveWidget.isSmallScreen(context)
            ?
        AppBar(
          title: const Text('Choose MCQ Bank'),
        )
            :
        PreferredSize(
            child: const CustomNavigationBar(),
            preferredSize: Size(screenSize.width, screenSize.height)
        ),
        drawer: const MenuDrawer(),
        backgroundColor: context.canvasColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              MidSectionChooseMCQBank(subjectList: subjectList,subjectIndex: subjectIndex,mcqBanks: mcqBanks, subjectID: subjectID, token: token),
              const BottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }
}