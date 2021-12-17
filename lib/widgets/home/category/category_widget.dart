import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
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
  List<Color> colorList = const [Color(0xffFFC46C), Color(0xff39D1CB), Color(0xff4FAAFF), Color(0xffB38977), Color(0xff8274F2), Color(0xffFF6464), Color(0xff75483E)];
  late int catIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIServices.getCourses().then((courses) {
      if(courses.toString().isNotEmpty) {
        _coursesList = courses.result!;
        // print(_coursesList);
        _subjectList = _coursesList[0].subject!;
        catIndex = 0;
        for(int i = 0; i < _coursesList.length; i++) {
          if (i == 0) {
            isSelected.add(true);
          } else {
            isSelected.add(false);
          }
          if (colorList.length < _coursesList.length) {
            colorList.add(colorList[i]);
          }
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

  //  print(_isLoading);

    return _isLoading ? const Center(heightFactor: 10,child: CircularProgressIndicator()) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoryText(),
          slidingButtons(),
          const SizedBox(height: 10,),
          detailsCard()
        ],
      );
  }

  Widget slidingButtons() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: ToggleButtons(
      isSelected: isSelected,
      renderBorder: false,
      // color: context.cardColor,
      // selectedColor: context.backgroundColor,
      fillColor: context.canvasColor,
      splashColor: context.canvasColor,
      children:
        toggleChild(),
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
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _subjectList.length,
          itemBuilder: (context, index) {
            return SubjectList(subjectList: _subjectList, index: index, catColor: colorList[catIndex],);
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
        border: Border.all(color: colorList[i], width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: isSelected[i] ? colorList[i] : context.canvasColor,
      ),
      child: Text(_coursesList[i].category.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: isSelected[i] ? context.backgroundColor : colorList[i],),)
  );
}
