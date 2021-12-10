import 'package:course_app_ui/widgets/home/category/category_widget.dart';
import 'package:course_app_ui/widgets/home/search_bar.dart';
import 'package:course_app_ui/widgets/home/share_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        Row(
          children: const [
            Icon(Icons.home),
            SizedBox(width: 10,),
            Text('Home')],),
      ),
      //   const Center(child: Text('Home'))
      // ),
      // drawer: const Drawer(),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: const [
                // Center(child: Text('HOME', style: TextStyle(fontSize: 24),)),
                // SizedBox(height: 20,),
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
