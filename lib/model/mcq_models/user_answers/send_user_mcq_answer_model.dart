class SendUserMCQAnswers {
  SendUserMCQAnswers({
    required this.token,
    required this.userMcqId,
    required this.mbid,
    required this.mcqid,
    required this.ans,
    required this.queRemainingTime,
    required this.queTotalTakenTime,
  });
  late final String token;
  late final int userMcqId;
  late final int mbid;
  late final List<dynamic> mcqid;
  late final List<dynamic> ans;
  late final List<dynamic> queRemainingTime;
  late final List<dynamic> queTotalTakenTime;

  SendUserMCQAnswers.fromJson(Map<String, dynamic> json){
    token = json['token'];
    userMcqId = json['user_mcq_id'];
    mbid = json['mbid'];
    mcqid = List.castFrom<dynamic, int>(json['mcqid']);
    ans = List.castFrom<dynamic, int>(json['ans']);
    queRemainingTime = List.castFrom<dynamic, int>(json['que_remaining_time']);
    queTotalTakenTime = List.castFrom<dynamic, int>(json['que_total_taken_time']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['user_mcq_id'] = userMcqId;
    _data['mbid'] = mbid;
    _data['mcqid'] = mcqid;
    _data['ans'] = ans;
    _data['que_remaining_time'] = queRemainingTime;
    _data['que_total_taken_time'] = queTotalTakenTime;
    return _data;
  }
}