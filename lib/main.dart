import 'package:course_app_ui/pages/home_page/home_page.dart';
import 'package:course_app_ui/widgets/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const Center(child: Text('Exam', style: TextStyle(fontSize: 55),),),
    const Center(child: Text('My Exam', style: TextStyle(fontSize: 55),),),
    const Center(child: Text('Profile', style: TextStyle(fontSize: 55),),),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      // color: ,
      home: Scaffold(
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
                icon: Icon(Icons.home, color: currentIndex == 0 ? MyTheme.lightBluishColor : MyTheme.blueGrey,),
                label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.paste, color: currentIndex == 1 ? MyTheme.lightBluishColor : MyTheme.blueGrey,),
                label: 'Exam',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_sharp, color: currentIndex == 2 ? MyTheme.lightBluishColor : MyTheme.blueGrey,),
                label: 'My Exam',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: currentIndex == 3 ? MyTheme.lightBluishColor : MyTheme.blueGrey,),
                label: 'Profile',
            ),
          ],
        )
      )
    );
  }
}