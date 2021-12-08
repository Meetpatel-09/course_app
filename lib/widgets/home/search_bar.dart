import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple) ,borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Search',
          prefixIcon: Icon(Icons.search_sharp, color: Colors.deepPurple,),
      ),
      textInputAction: TextInputAction.search,
    );
  }
}
