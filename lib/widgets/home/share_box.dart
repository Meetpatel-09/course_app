import 'package:course_app_ui/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShareBox extends StatelessWidget {
  const ShareBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 100, child: Text('Share with Friends', style: TextStyle(color: MyTheme.white, fontWeight: FontWeight.bold, fontSize: 16),)),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12.0),
                primary: context.canvasColor,
                shape: const StadiumBorder(),
              ),
              child: Text('Share', style: TextStyle(color: context.cardColor),)),
        ],
      ),
    );
  }
}
