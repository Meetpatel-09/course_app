import 'package:course_app_ui/pages/home_page/mobile/fragments/exam_fragment.dart';
import 'package:course_app_ui/pages/home_page/mobile/fragments/home_fragment.dart';
import 'package:course_app_ui/pages/home_page/mobile/fragments/my_exam_fragment.dart';
import 'package:course_app_ui/pages/home_page/mobile/fragments/profile_fragment.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({Key? key}) : super(key: key);

  @override
  _HomePageMobileState createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {

  // index of fragments initialized by the value '0' so when app is first launched it is home fragment
  int currentIndex = 0;
  // boolean variable set to false on load to redirect to the desire fragment e.g profile fragment
  bool isClicked = false;

  final screens = [
    const HomeFragment(),
    const ExamFragment(),
    const MyExamFragment(),
    const ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    if (!isClicked) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final arg = ModalRoute.of(context)!.settings.arguments as Map;
        if (arg['index'] != null) {
          currentIndex = arg['index'];
        }
      }
    }

    return Scaffold(
      // considering different types of devices and their pre-occupied constraints of screen like status bar
      // Using SafeArea Widget in order to make our UI adaptive and error-free.
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
              setState(() {
                this.currentIndex = currentIndex;
                isClicked = true;
              }),
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
