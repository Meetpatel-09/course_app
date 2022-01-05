import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQBanksList extends StatelessWidget {
  const MCQBanksList({Key? key, this.mcqBanks, required this.mcqBanksIndex, this.subjectList, this.subjectIndex}) : super(key: key);
  final int mcqBanksIndex;
  final MCQBanksModel? mcqBanks;
  final List<Subject>? subjectList;
  final int? subjectIndex;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: context.primaryColor),
          color: context.backgroundColor
      ),
      child: Material(
        // color: context.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: () {

            Navigator.pushNamed(
              context,
              MyRoutes.userMCQSettingsRoute,
              arguments: {
                'subjectList': subjectList,
                'subjectIndex': subjectIndex,
                'mcqBanks': mcqBanks,
                'mcqBanksIndex': mcqBanksIndex,
              }
            );
          },
          splashColor: mcqBanksIndex == 0 ? context.primaryColor.withOpacity(0.5) : context.canvasColor,
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8,),
                Align(
                  alignment: Alignment.center,
                  child:
                  mcqBanksIndex == 0 ?
                      Image.asset("assets/images/mcq-bank.png", width: 100, height: 100, color: context.cardColor,)
                        :
                      Image.asset("assets/images/mcq-bank.png", width: 100, height: 100, color: context.cardColor.withOpacity(0.5),)

                ),
                const SizedBox(height: 15,),
                Align(child:  mcqBanksIndex == 0 ? mcqBanks!.result![mcqBanksIndex].queBankName.text.bold.lg.center.color(context.cardColor).make() : mcqBanks!.result![mcqBanksIndex].queBankName.text.bold.lg.center.color(context.cardColor.withOpacity(0.5)).make()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
