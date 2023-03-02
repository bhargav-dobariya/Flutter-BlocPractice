class LoginModel {
  String? statusCode;
  String? statusMessage;
  String? datetime;
  String? ngVersion;
  Null? data;

  LoginModel(
      {this.statusCode,
      this.statusMessage,
      this.datetime,
      this.ngVersion,
      this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    datetime = json['datetime'];
    ngVersion = json['ng_version'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['datetime'] = this.datetime;
    data['ng_version'] = this.ngVersion;
    data['data'] = this.data;
    return data;
  }
}
