class TestSeriesLeaderBoardModel {
  String? type;
  String? message;
  List<Ranklist>? ranklist;

  TestSeriesLeaderBoardModel({this.type, this.message, this.ranklist});

  TestSeriesLeaderBoardModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['ranklist'] != null) {
      ranklist = <Ranklist>[];
      json['ranklist'].forEach((v) {
        ranklist!.add(new Ranklist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.ranklist != null) {
      data['ranklist'] = this.ranklist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ranklist {
  int? slNo;
  int? rank;
  String? name;
  int? userId;
  int? score;
  int? totalCorrect;
  int? totalIncorrect;
  int? totalUnattempted;

  Ranklist(
      {this.slNo,
      this.rank,
      this.name,
      this.userId,
      this.score,
      this.totalCorrect,
      this.totalIncorrect,
      this.totalUnattempted});

  Ranklist.fromJson(Map<String, dynamic> json) {
    slNo = json['sl_no'];
    rank = json['rank'];
    name = json['name'];
    userId = json['user_id'];
    score = json['score'];
    totalCorrect = json['total_correct'];
    totalIncorrect = json['total_incorrect'];
    totalUnattempted = json['total_unattempted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sl_no'] = this.slNo;
    data['rank'] = this.rank;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['score'] = this.score;
    data['total_correct'] = this.totalCorrect;
    data['total_incorrect'] = this.totalIncorrect;
    data['total_unattempted'] = this.totalUnattempted;
    return data;
  }
}
