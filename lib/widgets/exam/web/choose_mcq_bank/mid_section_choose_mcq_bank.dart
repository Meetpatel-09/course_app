import 'package:course_app_ui/widgets/exam/choose_mcq_bank/mcq_banks_list.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
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
  final String token;
  const MidSectionChooseMCQBank({Key? key, required this.mcqBanks, required this.subjectList, required this.subjectIndex, required this.subjectID, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
          maxWidth: 1400.0,
          minHeight: MediaQuery.of(context).size.height - 100
      ),
      color: context.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: MediaQuery.of(context).size.width < 500 ? const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0) : const EdgeInsets.only(top: 30.0, left: 55.0, right: 55.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                subjectList[subjectIndex].subject!.text.xl2.semiBold.make(),
                Container(
                  height: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width > 580 ? 215.0 * (mcqBanks.result!.length / 1.5) : 250.0 * (mcqBanks.result!.length / 1.5) : ResponsiveWidget.isMediumScreen(context) ? 210.0 * (mcqBanks.result!.length / 2.0) : 210.0 * (mcqBanks.result!.length / 4.0),
                  width: 1400.0,
                  padding: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width > 580 ? const EdgeInsets.symmetric(horizontal: 100.0,vertical: 10.0) : const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0) : ResponsiveWidget.isMediumScreen(context) ? const EdgeInsets.symmetric(horizontal: 100, vertical: 15.0) : const EdgeInsets.symmetric(horizontal: 155, vertical: 15.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 2 : MediaQuery.of(context).size.width < 1250 ? 3 : 5,
                        childAspectRatio: ResponsiveWidget.isSmallScreen(context) ? 3/4 : MediaQuery.of(context).size.width < 1250 ? 3/4 : 3/3
                    ),
                    itemCount: mcqBanks.result!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MCQBanksList(
                            mcqBanks: mcqBanks,
                            mcqBanksIndex: index,
                            subjectIndex: subjectIndex,
                            subjectList: subjectList,
                            subjectID: subjectID,
                            token: token
                        ),
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
