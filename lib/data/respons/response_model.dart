class LoginModal {
  int? id;
  List<String>? roles;
  String? accessToken;
  String? sessionId;
  String? message;

  LoginModal(
      {this.id, this.roles, this.accessToken, this.sessionId, this.message});

  LoginModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roles = json['roles'].cast<String>();
    accessToken = json['accessToken'];
    sessionId = json['sessionId'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roles'] = this.roles;
    data['accessToken'] = this.accessToken;
    data['sessionId'] = this.sessionId;
    data['message'] = this.message;
    return data;
  }
}
