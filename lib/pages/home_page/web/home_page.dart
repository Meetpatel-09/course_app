import 'package:course_app_ui/widgets/home/logout_button.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:course_app_ui/widgets/home/web/home/mid_section.dart';
import 'package:course_app_ui/widgets/web/navigation_bar//menu_drawer.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/navigation_bar.dart';
import 'package:course_app_ui/widgets/web/navigation_bar//responsive.dart';
import 'package:flutter/material.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ResponsiveWidget.isSmallScreen(context)
          ?
        AppBar(
          title: const Text('Course App'),
          actions: const [
            Align(
                alignment: Alignment.centerRight,
                child: LogoutIconButton()
            )
          ],
        )
            :
        PreferredSize(
            child: const CustomNavigationBar(),
            preferredSize: Size(screenSize.width, screenSize.height)
        ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            MidSection(),
            BottomNavigation(),
          ],
        ),
      ),
    );
  }
}
