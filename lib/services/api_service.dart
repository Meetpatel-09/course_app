import 'dart:convert';
import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/subject_model.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static var client = http.Client();

  static Future<List<Result>> getCourse() async {

    var url = Uri.parse(courseAPI);

    final response = await http.get(url);

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['result']) {
      _temp.add(i);
    }

    // print(_temp);

    return Result.coursesFromSnapshot(_temp);

    // try{
    //   final response = await http.get(url);
    //     if(200 == response.statusCode) {
    //       // final CourseModel courses = courseModelFromJson(response.body);
    //       // return courses;
    //
    //       Map data = jsonDecode(response.body);
    //       List _temp = [];
    //
    //       for (var i in data['result']) {
    //         _temp.add(i);
    //       }
    //
    //       // print(_temp);
    //
    //       return CourseModel.coursesFromSnapshot(_temp);
    //     } else {
    //       return <CourseModel>[];
    //     }
    // } catch(e) {
    //   return <CourseModel>[];
    // }
  }

  static Future<List<SubjectModel>> getSubject() async {

    String subjectAPI = "http://80.209.236.127:8082/subject";

    var url = Uri.parse(subjectAPI);

    final response = await http.get(url);

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['result']) {
      _temp.add(i);
    }

    return SubjectModel.subjectsFtromSnapshot(_temp);
  }
}
