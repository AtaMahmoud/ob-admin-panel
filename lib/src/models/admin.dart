class Admin {
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String country;

  Admin({
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.country,
  });

  Admin.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'] as String;
    lastName = json['lastName'] as String ;
    email = json['email'] as String ;
    mobileNumber = json['mobileNumber'] as String ;
    country = json['country'] as String ;
  }
  Map<String, String> toJson() {
    final data = <String, String>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['mobileNumber'] = mobileNumber;
    data['country'] = country;

    return data;
  }
}
