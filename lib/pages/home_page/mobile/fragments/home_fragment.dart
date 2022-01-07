import 'package:course_app_ui/widgets/home/category/category_widget.dart';
import 'package:course_app_ui/widgets/home/logout_button.dart';
import 'package:course_app_ui/widgets/home/search_bar.dart';
import 'package:course_app_ui/widgets/home/share_box.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.home),
            SizedBox(width: 10,),
            Text('Home'),
          ],
        ),
        actions: const [
          Align(
            alignment: Alignment.centerRight,
            child: LogoutIconButton()
          )
        ],
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: Column(
                children: const [
                  SearchBar(),
                  SizedBox(height: 15.0,),
                  ShareBox(),
                  SizedBox(height: 10.0,),
                  CategoryWidget(),
                ],
              ),
            ),
        ),
    );
  }
}
