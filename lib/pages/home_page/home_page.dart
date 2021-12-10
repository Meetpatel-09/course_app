import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/widgets/home/category_text.dart';
import 'package:course_app_ui/widgets/home/details_card.dart';
import 'package:course_app_ui/widgets/home/search_bar.dart';
import 'package:course_app_ui/widgets/home/share_box.dart';
import 'package:course_app_ui/widgets/home/sliding_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Result> _courses;
  late bool _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    APIServices.getCourse().then((courses) {
      _courses = courses;
      _isLoading = false;
    });
  }


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
              children: [
                // Center(child: Text('HOME', style: TextStyle(fontSize: 24),)),
                // SizedBox(height: 20,),
                const SearchBar(),
                const SizedBox(height: 15.0,),
                const ShareBox(),
                const SizedBox(height: 10.0,),
                const CategoryText(),
                const SlidingButtons(),
                const SizedBox(height: 15,),
                // const DetailsCard(),
                Text(_isLoading ? 'Loading' : '_courses.toString()')
              ],
            ),
          ),
        ),
    );
  }
}
