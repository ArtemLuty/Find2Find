class SchoolResponse {
  int? id;
  String? schoolName;
  int? postCode;

  SchoolResponse({this.id, this.schoolName, this.postCode});

  SchoolResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolName = json['schoolName'];
    postCode = json['postCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schoolName'] = this.schoolName;
    data['postCode'] = this.postCode;
    return data;
  }
}