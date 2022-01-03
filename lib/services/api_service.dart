import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_banks_model.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static var client = http.Client();

  static Future<CourseModel> getCourses() async {

    var url = Uri.parse(Config().courseAPI);

    try {
      final response = await http.get(url);
      if(200 == response.statusCode) {

        final CourseModel courses = courseModelFromJson(response.body);

        return courses;
      } else {
        return CourseModel();
      }
    } catch(e) {
      return CourseModel();
    }
  }

  static Future<MCQBanksModel> getMCQBank(String subjectID) async {

    var url = Uri.parse(Config().getMCQBankAPI + subjectID);

    try {
      final response = await http.get(url);

      print(response.body);
      print(response.statusCode);
      print(response.headers);

      if(200 == response.statusCode) {

        final MCQBanksModel courses = mcqBanksModelFromJson(response.body);

        return courses;
      } else {
        return MCQBanksModel();
      }
    } catch(e) {
      return MCQBanksModel();
    }
  }
}