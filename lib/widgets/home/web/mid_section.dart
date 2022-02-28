import 'package:course_app_ui/widgets/home/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MidSection extends StatelessWidget {
  const MidSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      constraints: const BoxConstraints(
          maxWidth: 1500
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 250,
            width: 500,
            child: Center(
              child: SearchBar(),
            ),
          ),
          Divider(
            thickness: 2, // thickness of the line
            indent: 20, // empty space to the leading edge of divider.
            endIndent: 20, // empty space to the trailing edge of the divider.
            color: Colors.black.withOpacity(0.3), // The color to use when painting the line.
            height: 1, // The divider's height extent.
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/download_from_google_play.png", fit: BoxFit.contain, width: 200,),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        Image.asset("assets/images/ss1.png", fit: BoxFit.cover, width: 200,),
                        const SizedBox(width: 20,),
                        Image.asset("assets/images/ss4.png", fit: BoxFit.contain, width: 200,),
                        const SizedBox(width: 20,),
                        Image.asset("assets/images/ss5.png", fit: BoxFit.contain, width: 200,),
                        const SizedBox(width: 20,),
                        Image.asset("assets/images/ss3.png", fit: BoxFit.contain, width: 200,),
                        const SizedBox(width: 20,),
                      ],
                    )
                  ],
                ),
              ),
              Center(child: Image.asset("assets/images/google_ads.png", fit: BoxFit.contain, width: 500,))
            ],
          ).p16(),
        ],
      ),
    ).centered();
  }
}
