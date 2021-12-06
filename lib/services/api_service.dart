import 'dart:convert';
import 'package:cource_app_ui/model/subject_model.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static var client = http.Client();

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
