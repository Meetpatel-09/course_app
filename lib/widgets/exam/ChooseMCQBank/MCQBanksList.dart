import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQBanksList extends StatelessWidget {
  const MCQBanksList({Key? key, this.mcqBanks, required this.index}) : super(key: key);
  final List<Result>? mcqBanks;
  final int index;

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

          },
          splashColor: context.primaryColor.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child:
                      index == 0 ?
                      Image.asset("assets/images/mcq-bank.png", width: 100, height: 100, color: context.cardColor,)
                        :
                      Image.asset("assets/images/mcq-bank.png", width: 100, height: 100, color: context.cardColor.withOpacity(0.5),)

                ),
                const SizedBox(height: 15,),
                Align(child:  index == 0 ? "MCQ Bank ${mcqBanks![index].mbid}".text.bold.lg.center.color(context.cardColor).make() : "MCQ bank ${mcqBanks![index].mbid}".text.bold.lg.center.color(context.cardColor.withOpacity(0.5)).make()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
