import 'package:course_app_ui/model/my_exam_models/my_exam_banks_model.dart';
import 'package:course_app_ui/widgets/my_exam/choose_mcq_bank/mcq_banks_list.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MidSectionMCQBanks extends StatefulWidget {
  const MidSectionMCQBanks({Key? key, required this.mcqBanks, required this.subjectID, required this.token}) : super(key: key);
  final List<Result> mcqBanks;
  final String subjectID;
  final String token;

  @override
  State<MidSectionMCQBanks> createState() => _MidSectionMCQBanksState();
}

class _MidSectionMCQBanksState extends State<MidSectionMCQBanks> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 100
      ),
      color: context.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25.0,),
          Align(child: "Choose MCQ Bank".text.bold.xl2.make()),
          Container(
              height: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width > 580 ? 215.0 * (widget.mcqBanks.length / 1.5) : 250.0 * (widget.mcqBanks.length / 1.5) : ResponsiveWidget.isMediumScreen(context) ? 210.0 * (widget.mcqBanks.length / 2.0) : 210.0 * (widget.mcqBanks.length / 4.0),
              width: 1400.0,
              padding: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width > 580 ? const EdgeInsets.symmetric(horizontal: 100.0,vertical: 10.0) : const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0) : ResponsiveWidget.isMediumScreen(context) ? const EdgeInsets.symmetric(horizontal: 100, vertical: 15.0) : const EdgeInsets.symmetric(horizontal: 155, vertical: 15.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 2 : MediaQuery.of(context).size.width < 1250 ? 3 : 5,
                      childAspectRatio: ResponsiveWidget.isSmallScreen(context) ? 2/2 : MediaQuery.of(context).size.width < 1250 ? 3/3 : 3/3
                  ),
                  itemCount: widget.mcqBanks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: MCQBanksList(
                        mcqBanks: widget.mcqBanks,
                        mcqBanksIndex: index,
                        subjectID: widget.subjectID,
                        // token: widget.token,
                      ),
                    );
                  }
              )
          ),
        ],
      ),
    );
  }

}
