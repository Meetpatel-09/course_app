import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryText extends StatelessWidget {
  const CategoryText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        'Categories',
        style: TextStyle(
          color: context.cardColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
