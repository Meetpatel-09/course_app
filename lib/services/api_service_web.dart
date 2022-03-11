
import 'package:course_app_ui/model/auth_models/register/register_response_model.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:http/http.dart' as http;

class APIServicesWeb {
  static var client = http.Client();

  static Future<RegisterResponseModel> registerNew(String fullName, String email, String mobileNo, String? password, String address, String userRole, String provider, var imageBytes, String fileName) async {

    String url = Config().registerAPI;

    var request = http.MultipartRequest('POST', Uri.parse(url));

    List<int> listData = imageBytes;

    request.fields['full_name'] = fullName;
    request.fields['email'] = email;
    request.fields['mobile_no'] = mobileNo.toString();
    if (password != null) {
      request.fields['password'] = password;
    }
    request.fields['address'] = address;
    request.fields['user_role'] = userRole;
    request.fields['provider'] = provider;

    request.files.add(http.MultipartFile.fromBytes('profile', listData,
        filename: fileName));

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    // Map<String, dynamic> map = respStr as Map<String, dynamic>;
    // print(map.values);
    // print(map.keys);
    // int status = int.parse(map.values.first.toString());
    // String msg = map.values.last.toString();
    print(registerResponseModelJson(respStr));
    return registerResponseModelJson(respStr);
    // return RegisterResponseModel(status: response.statusCode);
  }
}
