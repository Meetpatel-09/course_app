import 'package:course_app_ui/model/my_exam_models/my_exam_banks_model.dart';
import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart' as banks;
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // to check the platform if it is web or mobile

class MCQBanksList extends StatelessWidget {
  const MCQBanksList({Key? key, required this.mcqBanksIndex, this.mcqBanks, this.subjectID}) : super(key: key);
  final int mcqBanksIndex;
  final List<Result>? mcqBanks;
  final String? subjectID;

  @override
  Widget build(BuildContext context) {
    final SharedServices _sharedServices = SharedServices();
    banks.MyExamResultModel myExamResult;
    late int mbid;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: context.primaryColor),
        color: context.backgroundColor
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: () {
            mbid = mcqBanks![mcqBanksIndex].mbid;
            _sharedServices.getData("token").then((value) {
              if (value != null) {
                APIServices.getMyExamResult(mbid.toString(), value).then((response) {
                  if (response.toString().isNotEmpty) {
                    if (response.status == 200) {
                        myExamResult = response;
                        Navigator.pushNamed(
                            context,
                            MyRoutes.myExamMCQPageRoute,
                            arguments: {
                              'myExamResult': myExamResult
                            }
                        );
                    }
                  }
                });
              } else {
              }
            });
          },
          splashColor: context.primaryColor.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8,),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/mcq-bank.png", width: kIsWeb ? ResponsiveWidget.isSmallScreen(context) ? 60.0 : 80.0 : 60.0, height: kIsWeb ? 80.0 : 60.0, color: context.cardColor,)
                ),
                const SizedBox(height: 15,),
                Align(child:  mcqBanks![mcqBanksIndex].queBankName.text.bold.center.size(kIsWeb ? ResponsiveWidget.isSmallScreen(context) ? 14.0 : 18.0 : 14.0).letterSpacing(1).color(context.cardColor).make()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
