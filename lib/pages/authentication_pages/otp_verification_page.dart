import 'dart:async';

import 'package:course_app_ui/widgets/authentication/auth_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({Key? key}) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  bool isAPICallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String otp = "xxxxxx";
  bool otpVerify = true;
  Duration duration = const Duration();
  Timer? timer;

  final FocusNode _focusDigit1 = FocusNode();
  final FocusNode _focusDigit2 = FocusNode();
  final FocusNode _focusDigit3 = FocusNode();
  final FocusNode _focusDigit4 = FocusNode();
  final FocusNode _focusDigit5 = FocusNode();
  final FocusNode _focusDigit6 = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusDigit1.dispose();
    _focusDigit2.dispose();
    _focusDigit3.dispose();
    _focusDigit4.dispose();
    _focusDigit5.dispose();
    _focusDigit6.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    duration = const Duration(seconds: 59);
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    const addSeconds = -1 ;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if(seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        iconTheme: IconThemeData(color: context.primaryColor),
      ),
      backgroundColor: context.canvasColor,
      body:  SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const LogoWidget(),
              const SizedBox(height: 35),
              "OTP Verification".text.bold.xl2.letterSpacing(1).make(),
              const EmailSentTo(),
              otpField(),
              const SizedBox(height: 25),
              verifyButton(),
              const SizedBox(height: 25),
              duration.inSeconds != 0 ? resendOTPTimer() : const ResendOTP(),
            ],
          ),
        )
      )
    );
  }

  Widget otpField() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          codeInput(
            null,
            _focusDigit1,
            _focusDigit2,
            0
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.063,
          ),
          codeInput(
            _focusDigit1,
            _focusDigit2,
            _focusDigit3,
            1
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.063,
          ),
          codeInput(
            _focusDigit2,
            _focusDigit3,
            _focusDigit4,
            2
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.063,
          ),
          codeInput(
            _focusDigit3,
            _focusDigit4,
            _focusDigit5,
            3
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.063,
          ),
          codeInput(
            _focusDigit4,
            _focusDigit5,
            _focusDigit6,
            4
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.063,
          ),
          codeInput(
            _focusDigit5,
            _focusDigit6,
            null,
            5
          ),
        ],
      ),
    );
  }

  Widget codeInput(FocusNode? newFocusNode0, FocusNode? newFocusNode1, FocusNode? newFocusNode2, int txtIndex) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.063,
          child: TextField(
            focusNode: newFocusNode1,
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            onChanged: (str) {
              if (str.length == 1) {
                FocusScope.of(context).requestFocus(newFocusNode2);
                otp = otp.substring(0, txtIndex) + str + otp.substring(txtIndex + 1, otp.length);
              } else if (str.isEmpty) {
                FocusScope.of(context).requestFocus(newFocusNode0);
                if(otp.isNotEmpty) {
                  otp = otp.substring(0, txtIndex) + "x" + otp.substring(txtIndex + 1, otp.length);
                }
              }
            },
            decoration: InputDecoration(
              hintText: "*",
              hintStyle: TextStyle(color: context.cardColor.withOpacity(0.7)),
              counterText: "",
            ),
          ),
        ),
      ],
    );
  }

  Widget verifyButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,),
      decoration: BoxDecoration(
        color: context.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          for (String i in otp.split("")) {
            // print(i);
            if (i == "x") {
              otpVerify = false;
            }
          }
          if (otpVerify) {
            // ignore: avoid_print
            print(otpVerify);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            "Verify & Proceed",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget resendOTPTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: context.cardColor.withOpacity(0.7),
              fontSize: 16.0,
            ),
            children: <TextSpan>[
              const TextSpan(text: "Resent OTP in"),
              TextSpan(
                text: " 00:" + seconds,
                style: TextStyle(
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

