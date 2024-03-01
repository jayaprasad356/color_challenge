class JobsResult {
  bool? success;
  String? message;
  List<Data>? data;

  JobsResult({this.success, this.message, this.data});

  JobsResult.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? id;
  String? userJobsId;
  String? position;
  String? income;
  String? userId;
  String? jobsId;

  Data(
      {this.name,
        this.id,
        this.userJobsId,
        this.position,
        this.income,
        this.userId,
        this.jobsId});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    userJobsId = json['user_jobs_id'];
    position = json['position'];
    income = json['income'];
    userId = json['user_id'];
    jobsId = json['jobs_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['user_jobs_id'] = userJobsId;
    data['position'] = position;
    data['income'] = income;
    data['user_id'] = userId;
    data['jobs_id'] = jobsId;
    return data;
  }
}
