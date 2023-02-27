class RegistrationModel {
  String? firstName;
  String? lastName;
  String? dob;
  String? username;
  String? password;
  int? schoolId;
  String? email;
  int? taxNumber;

  RegistrationModel(
      {this.firstName,
      this.lastName,
      this.dob,
      this.username,
      this.taxNumber,
      this.password,
      this.schoolId,
      this.email});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    taxNumber = json['taxNumber'];
    username = json['username'];
    password = json['password'];
    schoolId = json['schoolId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dob'] = this.dob;
    data['taxNumber'] = this.taxNumber;
    data['username'] = this.username;
    data['password'] = this.password;
    data['schoolId'] = this.schoolId;
    data['email'] = this.email;
    return data;
  }
}
