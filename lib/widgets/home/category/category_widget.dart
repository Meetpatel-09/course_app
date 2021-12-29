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
  late List<Result> _coursesList;
  late List<Subject> _subjectList;
  bool _isLoading = true;
  List<bool> isSelected = [];
  List<Widget> toggleButton = [];
  late int catIndex;

  @override
  void initState() {
    super.initState();
    APIServices.getCourses().then((courses) {
      if (courses.toString().isNotEmpty) {
        _coursesList = courses.result!;
        _subjectList = _coursesList[0].subject!;
        catIndex = 0;
        for (int i = 0; i < _coursesList.length; i++) {
          if (i == 0) {
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
    return _isLoading
        ? const Center(heightFactor: 10, child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CategoryText(),
              slidingButtons(),
              const SizedBox(
                height: 10,
              ),
              detailsCard()
            ],
          );
  }

  Widget slidingButtons() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ToggleButtons(
          isSelected: isSelected,
          renderBorder: false,
          fillColor: context.canvasColor,
          splashColor: context.canvasColor,
          children: toggleChild(),
          onPressed: (int newIndex) {
            setState(() {
              for (int index = 0; index < _coursesList.length; index++) {
                if (index == newIndex) {
                  isSelected[index] = true;
                  catIndex = newIndex;
                  _subjectList = _coursesList[newIndex].subject!;
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
            index: index));
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
