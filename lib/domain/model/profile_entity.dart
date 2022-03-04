class ProfileEntity {
  String? username;
  String? firstName;
  String? middleName;
  String? lastName;
  bool? isActive;
  String? dOB;
  String? location;
  String? phoneNumber;
  String? emailAddress;
  String? idNumber;
  String? img;
  bool? isLocked;
  bool? isVerified;
  bool? isAdmin;

  ProfileEntity(
      {username,
      firstName,
      middleName,
      lastName,
      isActive,
      dOB,
      location,
      phoneNumber,
      emailAddress,
      img,
      isLocked,
      isVerified,
      isAdmin});

  ProfileEntity.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    isActive = json['is_active'];
    dOB = json['DOB'];
    location = json['location'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    img = json['img'];
    isLocked = json['is_Locked'];
    isVerified = json['is_verified'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['is_active'] = isActive;
    data['DOB'] = dOB;
    data['location'] = location;
    data['phone_number'] = phoneNumber;
    data['email_address'] = emailAddress;
    data['img'] = img;
    data['is_Locked'] = isLocked;
    data['is_verified'] = isVerified;
    data['is_admin'] = isAdmin;
    return data;
  }
}
