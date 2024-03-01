class JobsIncome {
  bool? success;
  String? message;
  List<Data>? data;

  JobsIncome({this.success, this.message, this.data});

  JobsIncome.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? jobsId;
  String? position;
  String? income;

  Data({this.id, this.jobsId, this.position, this.income});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobsId = json['jobs_id'];
    position = json['position'];
    income = json['income'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jobs_id'] = jobsId;
    data['position'] = position;
    data['income'] = income;
    return data;
  }
}
