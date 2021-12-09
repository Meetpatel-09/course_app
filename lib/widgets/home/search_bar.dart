import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primaryColor) ,borderRadius: const BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primaryColor) ,borderRadius: const BorderRadius.all(Radius.circular(10))),
        hintText: 'Search',
        prefixIcon: Icon(Icons.search_sharp, color: context.primaryColor,),
        fillColor: context.backgroundColor,
        filled: true
      ),
      style: TextStyle(color: context.primaryColor),
      textInputAction: TextInputAction.search,
    );
  }
}
