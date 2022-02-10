import 'package:course_app_ui/model/my_exam_models/my_exam_banks_model.dart';
import 'package:course_app_ui/widgets/my_exam/choose_mcq_bank/mcq_banks_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQBanks extends StatefulWidget {
  final List<Result>?  mcqBanks;
  final String? subjectID;
  final String? token;
  const MCQBanks({Key? key, this.mcqBanks, this.subjectID, this.token}) : super(key: key);

  @override
  _MCQBanksState createState() => _MCQBanksState();
}

class _MCQBanksState extends State<MCQBanks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15,),
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
              itemCount: widget.mcqBanks?.length,
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
    );
  }
}
