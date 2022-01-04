import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TempPage extends StatefulWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  List<Subject>? subjectList = [];
  int index = 0;
  late int mbid;
  String token = "emapty";
  final SharedServices _sharedServices = SharedServices();

  @override
  void initState() {
    _sharedServices.checkLogIn("token").then((value) {
      if (value != null) {
        setState(() {
          token = value;
          print(token);
        });
      } else {
        token = "empty";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectList = arg['subjectList'];
    index = arg['index'];
    mbid = arg['mbid'];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: container(),
          )
      ),
    );
  }

  Widget container() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '${subjectList![index].subject}'.richText.lg.make(),
        const SizedBox(height: 10,),
        mbid.toString().richText.lg.make(),
        const SizedBox(height: 10,),
        token.richText.lg.make(),
      ],
    );
  }
}
