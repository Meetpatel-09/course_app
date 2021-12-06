import 'package:course_app_ui/pages/home_page/home_page.dart';
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
      home: Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: currentIndex,
              children: screens,
            ),
          ),
        bottomNavigationBar: BottomNavigationBar(
          // type: BottomNavigationBarType.fixed,
          // selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.blueGrey,
          fixedColor: Colors.lightBlue,
          showUnselectedLabels: true,
          currentIndex: currentIndex,

          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: currentIndex == 0 ? Colors.lightBlue : Colors.blueGrey,),
                label: 'Home',
                backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.paste, color: currentIndex == 1 ? Colors.lightBlue : Colors.blueGrey,),
                label: 'Exam',
                backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_sharp, color: currentIndex == 2 ? Colors.lightBlue : Colors.blueGrey,),
                label: 'My Exam',
                backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: currentIndex == 3 ? Colors.lightBlue : Colors.blueGrey,),
                label: 'Profile',
                backgroundColor: Colors.white
            ),
          ],
        )
      )
    );
  }
}