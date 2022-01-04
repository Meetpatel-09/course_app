import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/widgets/exam/ChooseMCQBank/MCQBanksList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQBanks extends StatefulWidget {
  const MCQBanks({Key? key, this.mcqBanks}) : super(key: key);
  final MCQBanksModel? mcqBanks;

  @override
  State<MCQBanks> createState() => _MCQBanksState();
}

class _MCQBanksState extends State<MCQBanks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Choose MCQ bank".text.bold.xl.make(),
        mcqBank(),
      ],
    );
  }

  Widget mcqBank() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height - 120,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1/1
            ),
            itemCount: widget.mcqBanks!.result!.length,
            itemBuilder: (context, index) {
              return MCQBanksList(
                mcqBanks: widget.mcqBanks!.result,
                index: index
              );
            }
        )
    );
  }
}
