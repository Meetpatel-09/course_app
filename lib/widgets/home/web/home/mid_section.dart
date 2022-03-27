import 'package:course_app_ui/widgets/home/search_bar.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MidSection extends StatelessWidget {
  const MidSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);

    var appImages = [
      Image.asset("assets/images/ss4.png", fit: BoxFit.contain, width: isSmallScreen ? 250 : 200,).p12(),
      Image.asset("assets/images/ss5.png", fit: BoxFit.contain, width: isSmallScreen ? 250 : 200,).p12(),
      Image.asset("assets/images/ss3.png", fit: BoxFit.contain, width: isSmallScreen ? 250 : 200,).p12(),
      Image.asset("assets/images/ss1.png", fit: BoxFit.contain, width: isSmallScreen ? 250 : 200,).p12(),
    ];

    var section2 = <Widget>[
      Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset("assets/images/download_from_google_play.png", fit: BoxFit.contain, width: 200,),
            const SizedBox(height: 30,),
            ResponsiveWidget.isLargeScreen(context)
                ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: appImages,
            )
                :
            ResponsiveWidget.isMediumScreen(context)
                ?
            mediumScreenSection(appImages, context)
                :
              Column(
                children: appImages,
              )
          ],
        ),
      ),
      Center(child: Image.asset("assets/images/google_ads.png", fit: BoxFit.contain, width: 500,))
    ];

    return Container(
      color: context.backgroundColor,
      constraints: const BoxConstraints(
          maxWidth: 1500
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 450,
            child: Center(
              child: const SearchBar().p32(),
            ),
          ),
          Divider(
            thickness: 2, // thickness of the line
            indent: 20, // empty space to the leading edge of divider.
            endIndent: 20, // empty space to the trailing edge of the divider.
            color: Colors.black.withOpacity(0.3), // The color to use when painting the line.
            height: 1, // The divider's height extent.
          ),
          MediaQuery.of(context).size.width < 1475
              ?
          Column(children: section2,).p16()
              :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: section2,
          ).p16()
        ],
      ),
    ).centered();
  }

  Widget mediumScreenSection(var appImages, BuildContext context) =>  SizedBox(
    height: (MediaQuery.of(context).size.width - 100) *  2.2,
    width: MediaQuery.of(context).size.width - 100,
    child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            crossAxisCount: 2,
            childAspectRatio: 3/6.45
        ),
        itemCount: 4,
        itemBuilder:  (context, index)  {
          return appImages[index];
        }
    ),
  );
}
