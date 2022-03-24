import 'package:course_app_ui/model/my_exam_models/my_exam_banks_model.dart';
import 'package:course_app_ui/widgets/my_exam/choose_mcq_bank/mcq_banks_list.dart';
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
              height: 210.0 * (widget.mcqBanks.length > 5 ? widget.mcqBanks.length / 4.0 : widget.mcqBanks.length),
              width: 1400.0,
              padding: const EdgeInsets.symmetric(horizontal: 155.0,vertical: 15.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 5,
                      childAspectRatio: 3/2.3
                  ),
                  itemCount: widget.mcqBanks.length,
                  itemBuilder: (context, index) {
                    return MCQBanksList(
                      mcqBanks: widget.mcqBanks,
                      mcqBanksIndex: index,
                      subjectID: widget.subjectID,
                      // token: widget.token,
                    );
                  }
              )
          ),
        ],
      ),
    );
  }

}
