import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/widgets/exam/choose_mcq_bank/mcq_banks_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQBanks extends StatefulWidget {
  const MCQBanks({Key? key, this.mcqBanks, this.subjectList, this.subjectIndex, this.subjectID}) : super(key: key);
  final MCQBanksModel? mcqBanks;
  final List<Subject>? subjectList;
  final int? subjectIndex;
  final String? subjectID;

  @override
  State<MCQBanks> createState() => _MCQBanksState();
}

class _MCQBanksState extends State<MCQBanks> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(child: "Choose MCQ Bank".text.bold.xl.make()),
        mcqBank(),
      ],
    );
  }

  Widget mcqBank() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 6),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                childAspectRatio: 3/4
              ),
              itemCount: widget.mcqBanks!.result!.length,
              itemBuilder: (context, index) {
                return MCQBanksList(
                  mcqBanks: widget.mcqBanks,
                  mcqBanksIndex: index,
                  subjectIndex: widget.subjectIndex,
                  subjectList: widget.subjectList,
                  subjectID: widget.subjectID
                );
              }
          )
      ),
    );
  }
}
