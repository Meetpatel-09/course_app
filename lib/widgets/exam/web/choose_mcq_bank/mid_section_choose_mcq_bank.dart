import 'package:course_app_ui/widgets/exam/choose_mcq_bank/mcq_banks_list.dart';
import 'package:flutter/material.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/model/course_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MidSectionChooseMCQBank extends StatelessWidget {
  final MCQBanksModel mcqBanks;
  final List<Subject> subjectList;
  final int subjectIndex;
  final String subjectID;
  const MidSectionChooseMCQBank({Key? key, required this.mcqBanks, required this.subjectList, required this.subjectIndex, required this.subjectID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: context.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Colors.purple,
            padding: const EdgeInsets.only(top: 30.0, left: 55.0, right: 55.0),
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.70,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                subjectList[subjectIndex].subject!.text.xl2.semiBold.make(),
                Container(
                  height: 200.0 * (mcqBanks.result!.length / 5.0),
                  width: 1400.0,
                  padding: const EdgeInsets.symmetric(horizontal: 155.0,vertical: 15.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: kIsWeb ? 5 : 3,
                        childAspectRatio: kIsWeb ? 3/2.3 : 3/4
                    ),
                    itemCount: mcqBanks.result!.length,
                    itemBuilder: (context, index) {
                      return MCQBanksList(
                          mcqBanks: mcqBanks,
                          mcqBanksIndex: index,
                          subjectIndex: subjectIndex,
                          subjectList: subjectList,
                          subjectID: subjectID
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
