import 'dart:async';

import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ResendOTPTimer extends StatefulWidget {
  const ResendOTPTimer({Key? key}) : super(key: key);

  @override
  State<ResendOTPTimer> createState() => _ResendOTPTimerState();
}

class _ResendOTPTimerState extends State<ResendOTPTimer> {
  Duration duration = const Duration();
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
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
