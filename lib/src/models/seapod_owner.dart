class SeapodOwner {
  String id;
  String userName;
  int checkInDate;
  String profilePicUrl;
  List<Seapod> seapods;
  String country;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  List<EmergencyContact> emergencyContacts;

  SeapodOwner({
    this.id,
    this.userName,
    this.checkInDate,
    this.profilePicUrl,
    this.seapods,
    this.country,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.emergencyContacts,
  });

  SeapodOwner.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userName = json['userName'];
    checkInDate = json['checkInDate'];
    profilePicUrl = json['profilePicUrl'];
    seapods = [];
    json['seaPods'].forEach((e) => seapods.add(Seapod.fromJson(e)));
    country = json['country'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    emergencyContacts = [];

    if (json['emergencyContacts'].isNotEmpty)
      json['emergencyContacts']
          .forEach((e) => emergencyContacts.add(EmergencyContact.fromJson(e)));
  }
}

class Seapod {
  String seapodName;
  String userType;

  Seapod({
    this.seapodName,
    this.userType,
  });

  Seapod.fromJson(Map<String, dynamic> json) {
    seapodName = json['seapodName'];
    userType = json['userType'];
  }
}

class EmergencyContact {
  String id;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;

  EmergencyContact({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
  });

  EmergencyContact.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
  }
}
