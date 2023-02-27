class RegistrationResponse {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? scope;
  int? userRoleId;
  String? userRoleName;
  int? userId;
  String? username;
  String? cellphone;
  String? email;
  String? firstName;
  String? lastName;
  String? registrationDate;

  RegistrationResponse(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.scope,
      this.userRoleId,
      this.userRoleName,
      this.userId,
      this.username,
      this.cellphone,
      this.email,
      this.firstName,
      this.lastName,
      this.registrationDate});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    userRoleId = json['userRoleId'];
    userRoleName = json['userRoleName'];
    userId = json['userId'];
    username = json['username'];
    cellphone = json['Cellphone'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    registrationDate = json['registrationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['scope'] = this.scope;
    data['userRoleId'] = this.userRoleId;
    data['userRoleName'] = this.userRoleName;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['Cellphone'] = this.cellphone;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['registrationDate'] = this.registrationDate;
    return data;
  }
}
