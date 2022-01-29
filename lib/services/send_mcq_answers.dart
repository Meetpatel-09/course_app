import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/model/mcq_models/send_user_mcq_answer_model.dart';

import 'api_service.dart';

class SendMCQAnswers {

  late bool wantQuestionTimer;
  late String questionTime;
  late List<Result> mcqQuestions;
  late String token;
  late String userMCQID;
  late int mbid;

  Map<int, String> userAnswerToSend = {};
  Map<int, Duration> userMCQQuestionTimer = {};
  int mcqId = 0;
  List<int> mcqIDs = [];

  void sendData() {
    // print(userAnswerToSend);
    // print(mcqIDs);
    String na= "";

    Map<int ,String> finalAnswers = {};
    Map<int ,Duration> finalQuestionTime = {};

    for (var element in mcqIDs) {
      finalAnswers[element] = na;
    }

    for (var element in mcqIDs) {
      finalQuestionTime[element] = Duration(seconds: int.parse(questionTime));
    }

    final thirdMap = {
      ...finalAnswers,
      ...userAnswerToSend,
    };

    final thirdMap2 = {
      ...finalQuestionTime,
      ...userMCQQuestionTimer,
    };

    // print(thirdMap);

    // variables to store mcq questions and answers
    List<int> q = thirdMap.keys.toList();
    List<String> a = thirdMap.values.toList();

    List queRemainingTime = [];
    List queTotalTakenTime = [];

    // checking if there was a question timer
    if(wantQuestionTimer) {

      for(int i = 0; i < thirdMap2.length; i++) {

        int n = mcqQuestions[i].mcqid;
        int? s = thirdMap2[n]?.inSeconds;
        int? r = s!;
        int? t = (int.parse(questionTime) * 60) - r;

        queRemainingTime.add(r);
        queTotalTakenTime.add(t);
      }
    }

    SendUserMCQAnswers model = SendUserMCQAnswers(
      token: token,
      userMcqId: int.parse(userMCQID),
      mbid: mbid,
      ans: a,
      mcqid: q,
      queRemainingTime: queRemainingTime,
      queTotalTakenTime: queTotalTakenTime,
    );

    print("${model.mbid}, ${model.userMcqId}, ${model.token}, ${model.mcqid}, ${model.queTotalTakenTime}, ${model.queRemainingTime}, ${model.ans} ");

    APIServices.sendMCQUserAnswer(model, token, true);
  }

}