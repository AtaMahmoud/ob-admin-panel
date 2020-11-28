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
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    country = json['country'];
  }
  Map<String, String> toJson() {
    final Map<String, String> data = Map<String, String>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['country'] = this.country;

    return data;
  }
}
