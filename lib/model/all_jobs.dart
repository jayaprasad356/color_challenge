class AllJobs {
  bool? success;
  String? message;
  List<Data>? data;

  AllJobs({this.success, this.message, this.data});

  AllJobs.fromJson(Map<String, dynamic> json) {
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
  String? jobId;
  String? title;
  String? description;
  String? totalSlots;
  String? slotsLeft;
  String? clientId;
  String? appliFees;
  String? highestIncome;
  String? status;
  String? refImage;
  String? appliedStatus;
  String? id;
  String? name;
  String? profile;

  Data(
      {this.jobId,
        this.title,
        this.description,
        this.totalSlots,
        this.slotsLeft,
        this.clientId,
        this.appliFees,
        this.highestIncome,
        this.status,
        this.refImage,
        this.appliedStatus,
        this.id,
        this.name,
        this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    title = json['title'];
    description = json['description'];
    totalSlots = json['total_slots'];
    slotsLeft = json['slots_left'];
    clientId = json['client_id'];
    appliFees = json['appli_fees'];
    highestIncome = json['highest_income'];
    status = json['status'];
    refImage = json['ref_image'];
    appliedStatus = json['applied_status'];
    id = json['id'];
    name = json['name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['title'] = title;
    data['description'] = description;
    data['total_slots'] = totalSlots;
    data['slots_left'] = slotsLeft;
    data['client_id'] = clientId;
    data['appli_fees'] = appliFees;
    data['highest_income'] = highestIncome;
    data['status'] = status;
    data['ref_image'] = refImage;
    data['applied_status'] = appliedStatus;
    data['id'] = id;
    data['name'] = name;
    data['profile'] = profile;
    return data;
  }
}
