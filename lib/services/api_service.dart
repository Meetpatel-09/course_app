import 'dart:convert';
import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static var client = http.Client();

  static Future<CourseModel> getCourses() async {

    var url = Uri.parse(courseAPI);

    // print('_temp');
    try {
      final response = await http.get(url);
      if(200 == response.statusCode) {

        final CourseModel courses = courseModelFromJson(response.body);

        // print(courses.result![1].subject![0].subject);

        return courses;
      } else {
        return CourseModel();
      }
    } catch(e) {
      return CourseModel();
    }
  }
}