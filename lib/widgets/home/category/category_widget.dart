import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/subject_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/widgets/home/category/widgets/category_text.dart';
import 'package:course_app_ui/widgets/home/category/widgets/details_card.dart';
import 'package:course_app_ui/widgets/home/category/widgets/subject_list.dart';
import 'package:course_app_ui/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  late List<Result> _coursesList;
  late bool _isLoading;
  late int _categoryIndex;
  List<bool> isSelected = [true, false, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    APIServices.getCourse().then((courses) {
      _coursesList = courses;
      _isLoading = false;
      // print(_coursesList[0].subject![0].subject);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
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
      children: [
        Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: context.primaryColor, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: isSelected[0] ? context.primaryColor : context.canvasColor,
            ),
            child: const Text('Computer Network', style: TextStyle(fontSize: 15,),)
        ),
        Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: MyTheme.lightBluishColor, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: isSelected[1] ? context.primaryColor : context.canvasColor,
            ),
            child: const Text('Computer Network')
        ),
        Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: MyTheme.lightBluishColor, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: isSelected[2] ? context.primaryColor : context.canvasColor,
            ),
            child: const Text('Computer Network')
        ),
      ],
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < isSelected.length; index++) {
            if (index == newIndex) {
              isSelected[index] = true;
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
    child: FutureBuilder<List<SubjectModel>>(
      future: APIServices.getSubject(),
      builder: (context, snapshot) {
        final subjects = snapshot.data;
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: 'Something went wrong!!!'.text.make());
            } else {
              return buildList(subjects!);
            }
        }
      },
    ),
  );

  Widget buildList(List<SubjectModel> subjects) => ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: subjects.length,
    itemBuilder: (context, index) {
      return SubjectList(
        subjectId: subjects[index].subjectid.toString(),
        cId: subjects[index].cid.toString(),
        subjectName: subjects[index].subject,
        subjectStatus: subjects[index].subjectStatus.toString(),
        subjectCratedDate: subjects[index].subjectCreatedat,
        category: subjects[index].category,
        categoryStatus: subjects[index].categoryStatus.toString(),
        categoryCreatedDate: subjects[index].categoryCreatedat,
      );
    },
  );

}
