import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // to check the platform if it is web or mobile

class MCQBanksList extends StatelessWidget {
  const MCQBanksList({Key? key, this.mcqBanks, required this.mcqBanksIndex, this.subjectList, this.subjectIndex, this.subjectID, this.token}) : super(key: key);
  final int mcqBanksIndex;
  final MCQBanksModel? mcqBanks;
  final List<Subject>? subjectList;
  final int? subjectIndex;
  final String? subjectID;
  final String? token;

  @override
  Widget build(BuildContext context) {

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

            if (token == "empty") {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  MyRoutes.loginRoute,
                      (route) => false
              );
            }

            if (mcqBanks!.result![mcqBanksIndex].isActive != "Disabled") {
              Navigator.pushNamed(
                  context,
                  MyRoutes.userMCQSettingsRoute,
                  arguments: {
                    'subjectList': subjectList,
                    'subjectIndex': subjectIndex,
                    'mcqBanks': mcqBanks,
                    'mcqBanksIndex': mcqBanksIndex,
                    'subjectID': subjectID
                  }
              );
            }
          },
          splashColor: mcqBanks!.result![mcqBanksIndex].isActive != "Disabled" ? context.primaryColor.withOpacity(0.5) : context.canvasColor,
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0,),
                Align(
                  alignment: Alignment.center,
                  child:
                  mcqBanks!.result![mcqBanksIndex].isActive != "Disabled" ?
                      Image.asset("assets/images/mcq-bank.png", width: kIsWeb ? 80.0 : 60.0, height: kIsWeb ? 80.0 : 60.0, color: context.cardColor,)
                        :
                      Image.asset("assets/images/mcq-bank.png", width: kIsWeb ? 80.0: 60.0, height: kIsWeb ? 80.0 : 60.0, color: context.cardColor.withOpacity(0.5),)
                ),
                const SizedBox(height: 15.0,),
                Align(
                    child: mcqBanks!.result![mcqBanksIndex].isActive != "Disabled"
                        ?
                    mcqBanks!.result![mcqBanksIndex].queBankName.text.bold.center.size(kIsWeb ? 18.0 : 14.0).letterSpacing(1.0).color(context.cardColor).make()
                        :
                    mcqBanks!.result![mcqBanksIndex].queBankName.text.bold.center.size(kIsWeb ? 18.0 : 14.0).letterSpacing(1.0).color(context.cardColor.withOpacity(0.5)).make()
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
