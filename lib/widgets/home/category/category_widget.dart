import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/widgets/home/category/widgets/category_text.dart';
import 'package:course_app_ui/widgets/home/category/widgets/subject_list/subject_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late List<Result> _coursesList; // to store all the data from from home API
  late List<Subject> _subjectList; // to store the all subject details for the selected category
  bool _isLoading = true;
  List<bool> isSelected = []; // list of boolean for toggle button
  List<Widget> toggleButton = [];
  late int catIndex; // to store the index of category which is selected

  @override
  void initState() {
    super.initState();
    APIServices.getCourses().then((courses) {
      if (courses.toString().isNotEmpty) {
        _coursesList = courses.result!; // storing all the data from home API
        _subjectList = _coursesList[0].subject!; // storing the subject details of the first (index 0) category initially
        catIndex = 0; // initially setting the category index 0
        for (int i = 0; i < _coursesList.length; i++) { // setting selected and not selected the toggle button
          if (i == 0) { // keeping the first category toggle button as selected
            isSelected.add(true);
          } else {
            isSelected.add(false);
          }
        }
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(heightFactor: 10, child: CircularProgressIndicator());
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoryText(),
          slidingButtons(),
          const SizedBox(
            height: 10,
          ),
          detailsCard(),
        ],
      );
    }
  }

  Widget slidingButtons() => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        isSelected: isSelected,
        renderBorder: false,
        fillColor: context.canvasColor,
        splashColor: context.canvasColor,
        children: toggleChild(),
        onPressed: (int newIndex) { // when use clicks on any category toggle button we get the index of that button
          setState(() {
            for (int index = 0; index < _coursesList.length; index++) {
              if (index == newIndex) {
                isSelected[index] = true; // making the clicked button as selected category
                catIndex = newIndex; // setting the new category index
                _subjectList = _coursesList[newIndex].subject!; // setting the subject list data as per selected category
              } else {
                isSelected[index] = false;
              }
            }
          });
        },
      ),
    );

  Widget detailsCard() => SizedBox(
      height: 165,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _subjectList.length,
        itemBuilder: (context, index) {
          return  Padding(
              padding: index == _subjectList.length - 1
              ? const EdgeInsets.all(0)
              : const EdgeInsets.only(right: 8),
          child: SubjectList(
            subjectList: _subjectList,
              subjectIndex: index));
        }
      )
  );

  List<Widget> toggleChild() {
    toggleButton = [];
    for (int i = 0; i < _coursesList.length; i++) {
      toggleButton.add(tButton(i));
    }
    return toggleButton;
  }

  Widget tButton(int i) => Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: context.primaryColor, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: isSelected[i] ? context.primaryColor : context.canvasColor,
      ),
      child: Text(
        _coursesList[i].category.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected[i] ? MyTheme.white : context.cardColor,
        ),
      ));
}
