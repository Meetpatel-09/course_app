import 'package:course_app_ui/pages/home_page/mobile/fragments/exam_fragment.dart';
import 'package:course_app_ui/pages/home_page/mobile/fragments/home_fragment.dart';
import 'package:course_app_ui/pages/home_page/mobile/fragments/my_exam_fragment.dart';
import 'package:course_app_ui/pages/home_page/mobile/fragments/profile_fragment.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  final screens = [
    const HomeFragment(),
    const ExamFragment(),
    const MyExamFragment(),
    const ProfileFragment(),
  ];
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: screens,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: currentIndex == 0 ? context.primaryColor : MyTheme.blueGrey,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.paste, color: currentIndex == 1 ? context.primaryColor : MyTheme.blueGrey,),
              label: 'Exam',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_sharp, color: currentIndex == 2 ? context.primaryColor : MyTheme.blueGrey,),
              label: 'My Exam',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: currentIndex == 3 ?context.primaryColor : MyTheme.blueGrey,),
              label: 'Profile',
            ),
          ],
        )
    );
  }
}
