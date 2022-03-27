import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: context.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: "Home".text.semiBold.white.size(20.0).make()
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              //   child: Divider(
              //     color: Colors.blueGrey.shade400,
              //     thickness: 2,
              //   ),
              // ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: "Copyright © 2022 | Course App".text.white.size(16).make()
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}