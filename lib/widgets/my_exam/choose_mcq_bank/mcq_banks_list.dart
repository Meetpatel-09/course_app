import 'package:course_app_ui/model/my_exam_models/my_exam_banks_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQBanksList extends StatelessWidget {
  const MCQBanksList({Key? key, required this.mcqBanksIndex, this.mcqBanks, this.subjectID}) : super(key: key);
  final int mcqBanksIndex;
  final List<Result>? mcqBanks;
  final String? subjectID;

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
              Navigator.pushNamed(
                  context,
                  MyRoutes.viewResultPageRoute,
                  arguments: {
                    'mbid': mcqBanks![mcqBanksIndex].mbid,
                    'subjectID': subjectID
                  }
              );
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
                    child: Image.asset("assets/images/mcq-bank.png", width: 60, height: 60, color: context.cardColor,)
                ),
                const SizedBox(height: 15,),
                Align(child:  mcqBanks![mcqBanksIndex].queBankName.text.bold.center.letterSpacing(1).color(context.cardColor).make()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
