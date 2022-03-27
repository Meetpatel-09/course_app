import 'dart:async';

import 'package:course_app_ui/model/auth_models/otp_verification/otp_request_model.dart';
import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/authentication/auth_widgets.dart';
import 'package:course_app_ui/widgets/web/navigation_bar//auth_navigation_bar.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OTPVerificationPageWeb extends StatefulWidget {
  final String email;
  const OTPVerificationPageWeb({Key? key, required this.email}) : super(key: key);

  @override
  _OTPVerificationPageWebState createState() => _OTPVerificationPageWebState();
}

class _OTPVerificationPageWebState extends State<OTPVerificationPageWeb> {
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
        backgroundColor: context.canvasColor,
        body: ResponsiveWidget.isSmallScreen(context)
            ?
        SingleChildScrollView(
          child: Column(
            children: [
              const AuthNavigationBar(fromLogIn: true),
              midSection().p(16.0),
              const BottomNavigation(),
            ],
          ),
        )
            :
        Stack(
            children: [
              bgImage(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const AuthNavigationBar(fromLogIn: false),
                    Stack(
                      children: [
                        bgImage2(),
                        midSection(),
                      ],
                    ),
                    const BottomNavigation(),
                  ],
                ),
              ),
            ]
        ).centered(),
    );
  }

  Widget bgImage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 2.25
      ),
      decoration: BoxDecoration(
        color: context.primaryColor.withOpacity(0.2),
      ),
    );
  }

  Widget bgImage2() {
    return Container(
      height: MediaQuery.of(context).size.height,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 2.25
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/otp-numeric.webp'),
          )
      ),
    );
  }

  Widget midSection() {
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding:  ResponsiveWidget.isSmallScreen(context)
              ? const EdgeInsets.all(0.0) : EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 2,
            right: MediaQuery.of(context).size.width / 15,
          ),
          child: Column(
            children: [
              // const LogoWidget(),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
              ),
              "OTP Verification".text.bold.size(30).color(context.cardColor).make(),
              // 'Enter the OTP and click on Verify & Proceed'.text.lg.color(context.cardColor.withOpacity(0.7)).make(),
              EmailSentTo(email: widget.email,),
              otpField(),
              const SizedBox(height: 25),
              verifyButton(),
              const SizedBox(height: 25),
              duration.inSeconds != 0 ? resendOTPTimer() : ResendOTP(email: widget.email,),
            ],
          ),
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
            width: MediaQuery.of(context).size.width * 0.031,
          ),
          codeInput(
              _focusDigit1,
              _focusDigit2,
              _focusDigit3,
              1
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.031,
          ),
          codeInput(
              _focusDigit2,
              _focusDigit3,
              _focusDigit4,
              2
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.031,
          ),
          codeInput(
              _focusDigit3,
              _focusDigit4,
              _focusDigit5,
              3
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.031,
          ),
          codeInput(
              _focusDigit4,
              _focusDigit5,
              _focusDigit6,
              4
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.031,
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
          width: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width * 0.031,
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
      width: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width - 100 : MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
        color: context.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          for (String i in otp.split("")) {
            if (i == "x") {
              otpVerify = false;
            }
          }
          if (otpVerify) {

            OTPRequestModel model = OTPRequestModel(
                email: widget.email,
                otp: int.parse(otp)
            );

            AuthService.otpVerify(model).then((response) {
              if (response.status == 200) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(Config().appName),
                      content: const Text("Registration Successful, Click on OK"),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              MyRoutes.loginRoute, (route) => false);
                        },
                            child: const Text("OK")),
                      ],
                    )
                );
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(Config().appName),
                      content: Text(response.msg),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text("OK")),
                      ],
                    )
                );
              }
            });
          } else {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(Config().appName),
                  content: const Text("Please Enter Valid OTP"),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text("OK")),
                  ],
                ));
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

    // 9 --> 09     11 --> 11
    // adding '0' in front of single digit number
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

