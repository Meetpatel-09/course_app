import 'package:course_app_ui/pages/home_page/mobile/fragments/exam_fragment.dart';
import 'package:course_app_ui/pages/home_page/mobile/fragments/home_fragment.dart';
import 'package:course_app_ui/pages/home_page/mobile/fragments/my_exam_fragment.dart';
import 'package:course_app_ui/pages/home_page/mobile/fragments/profile_fragment.dart';
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
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: context.primaryColor.withOpacity(0.7),
          backgroundColor: context.backgroundColor,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
          )
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: currentIndex,
          onDestinationSelected: (currentIndex) =>
              setState(() => this.currentIndex = currentIndex),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.paste),
              label: 'Exam',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_sharp),
              label: 'My Exam',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
