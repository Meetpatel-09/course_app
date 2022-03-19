import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MidSectionMyExam extends StatefulWidget {
  const MidSectionMyExam({Key? key}) : super(key: key);

  @override
  State<MidSectionMyExam> createState() => _MidSectionMyExamState();
}

class _MidSectionMyExamState extends State<MidSectionMyExam> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: 1400.0,
          minHeight: MediaQuery.of(context).size.height - 100
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                "Computer Basics".text.xl3.semiBold.make(),
                Row(
                  children: [
                    "Exam Timer ".text.xl.semiBold.make(),
                    "01:23".text.xl.semiBold.make()
                  ],
                ),
              ],
            ).px(10),
            // const SizedBox(height: 30.0,),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           for (int i = 1; i < 11 ; i++)
            //             Container(
            //                 margin: const EdgeInsets.only(right: 5.0, left: 0),
            //                 padding: const EdgeInsets.all(10.0),
            //                 decoration: BoxDecoration(
            //                   border: Border.all(color: context.primaryColor, width: 1),
            //                   borderRadius: const BorderRadius.all(Radius.circular(5)),
            //                   color:i == 1 ? context.primaryColor : context.canvasColor,
            //                 ),
            //                 child: Center(
            //                   child: "Q no.- $i".text.xl.color(i == 1 ? MyTheme.white : context.cardColor,).make(),
            //                 )
            //             ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 30.0,),
            Column(
              children: [
                for (int i = 1; i < 11 ; i++)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: context.backgroundColor,
                        // borderRadius: BorderRadius.circular(0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              // spreadRadius: 7,
                              blurRadius: 10.0,
                              offset: const Offset(0.0, 0.75)
                          ),
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headings(),
                        const SizedBox(height: 20.0,),
                        "Top Hat Test is a relatively new product where professors can administer tests online through Top Hat?".text.xl2.semiBold.make(),
                        const SizedBox(height: 15.0,),
                        options(),
                        const SizedBox(height: 10.0,),
                      ],
                    ).pSymmetric(v: 30.0, h: 40.0),
                  ).py(10.0),
              ],
            ),
            // buttons(),
          ],
        ),
      ),
    );
  }

  Widget headings() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: "Question 1".text.xl.semiBold.make()
        ),
        // Row(
        //   children: [
        //     "Question Timer ".text.xl.semiBold.make(),
        //     "00:45".text.xl.semiBold.make()
        //   ],
        // ),
      ],
    );
  }

  Widget options() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          decoration: BoxDecoration(
              color: context.backgroundColor,
              border: Border.all(
                  color:
                  // userAnswer[pageIndex + 1] ==
                  //     (i + 1).toString()
                  //     ? context.primaryColor
                  //     :
                  context.cardColor.withOpacity(0.5),
                  width: 2.0
              )
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: context.cardColor.withOpacity(0.1),
                    border: Border(
                      right: BorderSide(
                        color: context.cardColor.withOpacity(0.5),
                        width: 2.0,
                      ),
                    )
                ),
                child: "A".text.xl2.semiBold.make().p(15.0),
              ),
              const SizedBox(width: 10.0,),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 350,
                  child: "key part of a student's with an X".richText.xl.semiBold.make()
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0,),
        Container(
          // padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.4),
              border: Border.all(
                  color:
                  // userAnswer[pageIndex + 1] ==
                  //     (i + 1).toString()
                  //     ? context.primaryColor
                  //     :
                  Colors.red,
                  width: 2.0
              )
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.5),
                    border: const Border(
                      right: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    )
                ),
                child: "B".text.xl2.semiBold.make().p(15.0),
              ),
              const SizedBox(width: 10.0,),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 350,
                  child: "With an X".richText.xl.semiBold.make()
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0,),
        Container(
          // padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          decoration: BoxDecoration(
              color: context.backgroundColor,
              border: Border.all(
                  color:
                  // userAnswer[pageIndex + 1] ==
                  //     (i + 1).toString()
                  //     ? context.primaryColor
                  //     :
                  context.cardColor.withOpacity(0.5),
                  width: 2.0
              )
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: context.cardColor.withOpacity(0.1),
                    border: Border(
                      right: BorderSide(
                        color: context.cardColor.withOpacity(0.5),
                        width: 2.0,
                      ),
                    )
                ),
                child: "C".text.xl2.semiBold.make().p(15.0),
              ),
              const SizedBox(width: 10.0,),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 350,
                  child: "Key part of".richText.xl.semiBold.make()
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0,),
        Container(
          // padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.4),
              border: Border.all(
                  color:
                  // userAnswer[pageIndex + 1] ==
                  //     (i + 1).toString()
                  //     ? context.primaryColor
                  //     :
                  Colors.green,
                  width: 2.0
              )
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.5),
                    border: const Border(
                      right: BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    )
                ),
                child: "D".text.xl2.semiBold.make().p(15.0),
              ),
              const SizedBox(width: 10.0,),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 350,
                  child: "Student's with an X".richText.xl.semiBold.make()
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: ButtonStyle(
            padding:  MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(20.0)),
            backgroundColor: MaterialStateProperty.all(context.primaryColor.withOpacity(0.2)),
            maximumSize: MaterialStateProperty.all(const Size(120, 50)),
            minimumSize: MaterialStateProperty.all(const Size(120, 50)),
            // shape: MaterialStateProperty.all(
            //   RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            // ),
          ),
          onPressed: () {},
          child: "Previous".text.xl.make(),
        ),
        TextButton(
          style: ButtonStyle(
            padding:  MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(20.0)),
            backgroundColor: MaterialStateProperty.all(context.primaryColor.withOpacity(0.2)),
            maximumSize: MaterialStateProperty.all(const Size(120, 50)),
            minimumSize: MaterialStateProperty.all(const Size(120, 50)),
            // shape: MaterialStateProperty.all(
            //   RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            // ),
          ),
          onPressed: () {},
          child: "Next".text.xl.make(),
        ),
      ],
    ).pSymmetric(v: 20.0);
  }
}
