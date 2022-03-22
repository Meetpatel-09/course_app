import 'package:course_app_ui/model/my_exam_models/my_exam_banks_model.dart';
import 'package:course_app_ui/pages/my_exam_pages/mobile/choose_my_exam_mcq_bank_page.dart';
import 'package:course_app_ui/pages/my_exam_pages/web/choose_my_exam_mcq_bank_page.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ChooseMyExamMCQBankPage extends StatefulWidget {
  const ChooseMyExamMCQBankPage({Key? key}) : super(key: key);

  @override
  _ChooseMyExamMCQBankPageState createState() => _ChooseMyExamMCQBankPageState();
}

class _ChooseMyExamMCQBankPageState extends State<ChooseMyExamMCQBankPage> {
  String subjectID = "";
  List<Result>? mcqBanks = [];
  String token = "empty";
  bool _isLoading = true;
  final SharedServices _sharedServices = SharedServices();

  @override
  void initState() {
    _sharedServices.getData("token").then((value) {
      if (value != null) {
        setState(() {
          token = value;
          _isLoading = false;
        });
      } else {
        setState(() {
          token = "empty";
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectID = arg['subjectID'];
    mcqBanks = arg['mcqBanks'];

    return _isLoading ? const Center(child: CircularProgressIndicator()) : LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          return ChooseMyExamMCQBankPageWeb(token: token, subjectID: subjectID, mcqBanks: mcqBanks!,);
        } else {
          // Mobile Screen
          return ChooseMyExamMCQBankPageMobile(token: token, subjectID: subjectID, mcqBanks: mcqBanks!,);
        }
      },
    );
  }
}

//  MCQBanks(mcqBanks: mcqBanks, subjectID: subjectID, token: token,),