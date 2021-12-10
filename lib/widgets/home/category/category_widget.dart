import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/widgets/home/category/widgets/category_text.dart';
import 'package:course_app_ui/widgets/home/category/widgets/subject_list.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIServices.getCourses().then((courses) {
      _coursesList = courses.result!;
      _subjectList = _coursesList[0].subject!;
      for(int i = 0; i < _coursesList.length; i++) {
        if (i == 0) {
          isSelected.add(true);
        } else {
          isSelected.add(false);
        }
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return _isLoading ? const Center(heightFactor: 10,child: CircularProgressIndicator()) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoryText(),
          slidingButtons(),
          const SizedBox(height: 15,),
          detailsCard()
        ],
      );
  }

  Widget slidingButtons() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: ToggleButtons(
      isSelected: isSelected,
      renderBorder: false,
      color: context.cardColor,
      selectedColor: context.backgroundColor,
      fillColor: context.canvasColor,
      splashColor: context.canvasColor,
      children:
        toggleChild(),
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < _coursesList.length; index++) {
            // _n = 0;
            if (index == newIndex) {
              isSelected[index] = true;
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
      height: 400,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _subjectList.length,
          itemBuilder: (context, index) {
            return SubjectList(
              subjectId: _subjectList[index].subjectid.toString(),
              cId: _subjectList[index].cid.toString(),
              subjectName: _subjectList[index].subject,
              subjectStatus: _subjectList[index].subjectStatus.toString(),
              subjectCratedDate: _subjectList[index].subjectCreatedat,
              category: _subjectList[index].category,
              categoryStatus: _subjectList[index].categoryStatus.toString(),
              categoryCreatedDate: _subjectList[index].categoryCreatedat,
            );
          }
      )
  );

  List<Widget> toggleChild() {
    toggleButton = [];
    for(int i = 0; i < _coursesList.length; i++) {
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
        color: isSelected[i] ? context.primaryColor : context.backgroundColor,
      ),
      child: Text(_coursesList[i].category.toString(), style: const TextStyle(fontWeight: FontWeight.bold),)
  );
}
