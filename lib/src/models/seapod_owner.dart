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
    id = json['_id'] as String;
    userName = json['userName'] as String;
    checkInDate = json['checkInDate'] as int;
    profilePicUrl = json['profilePicUrl'] as String;
    seapods = [];
    json['seaPods'].forEach(
        (e) => seapods.add(Seapod.fromJson(e as Map<String, dynamic>)));
    country = json['country'] as String;
    firstName = json['firstName'] as String;
    lastName = json['lastName'] as String;
    email = json['email'] as String;
    mobileNumber = json['mobileNumber'] as String;
    emergencyContacts = [];
    final emergContacts = json['emergencyContacts'] as Map<String, dynamic>;
    if (emergContacts.isNotEmpty) {
      json['emergencyContacts'].forEach(
        (e) => emergencyContacts.add(
          EmergencyContact.fromJson(e as Map<String, dynamic>),
        ),
      );
    }
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
    seapodName = json['seapodName'] as String;
    userType = json['userType'] as String;
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
    id = json['_id'] as String;
    firstName = json['firstName'] as String;
    lastName = json['lastName'] as String;
    email = json['email'] as String;
    mobileNumber = json['mobileNumber'] as String;
  }
}
