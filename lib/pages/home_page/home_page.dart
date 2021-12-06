import 'package:cource_app_ui/pages/home_page/widgets/details_card.dart';
import 'package:cource_app_ui/pages/home_page/widgets/search_bar.dart';
import 'package:cource_app_ui/pages/home_page/widgets/share_box.dart';
import 'package:cource_app_ui/pages/home_page/widgets/sliding_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: const [
            Center(child: Text('HOME', style: TextStyle(fontSize: 24),)),
            SizedBox(height: 20,),
            SearchBar(),
            SizedBox(height: 20,),
            ShareBox(),
            SizedBox(height: 20,),
            SlidingButtons(),
            SizedBox(height: 15,),
            DetailsCard(),
          ],
        ),
      ),
    );
  }
}
