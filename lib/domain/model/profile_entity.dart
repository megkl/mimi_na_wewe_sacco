import 'dart:convert';

import '../entity.dart';

class ProfileEntity extends Entity<String> {
  String? userFirstName;
  String? userMiddleName;
  String? userLastName;
  String? userIdentificationCountryOfIssue;
  //String? userIdentificationType;
  String? userIdentificationNumber;
  String? userEmailAddress;
  String? userPhoneNumber;
  //String? userAccountPin;
  bool? userAccountInformationIsVerified;
  bool? userAccountInformationIsLocked;
  bool? userIsAdmin;
  DateTime? userAccountInformationCreatedAt;
  DateTime? userAccountInformationUpdatedAt;

  ProfileEntity({
    String? id,
    this.userFirstName,
    this.userMiddleName,
    this.userLastName,
    this.userIdentificationCountryOfIssue,
    //this.userIdentificationType,
    this.userIdentificationNumber,
    this.userEmailAddress,
    this.userPhoneNumber,
    //this.userAccountPin,
    this.userAccountInformationIsVerified,
    this.userAccountInformationIsLocked,
    this.userIsAdmin,
    this.userAccountInformationCreatedAt,
    this.userAccountInformationUpdatedAt,
  }) : super(id!);

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        id: json["_id"],
        userFirstName: json["user_first_name"],
        userMiddleName: json["user_middle_name"],
        userLastName: json["user_last_name"],
        userIdentificationCountryOfIssue:
            json["user_identification_country_of_issue"],
        //userIdentificationType: json["user_identification_type"],
        userIdentificationNumber: json["user_identification_number"],
        userEmailAddress: json["user_email_address"],
        userPhoneNumber: json["user_phone_number"],
        //userAccountPin: json["user_account_pin"],
        userAccountInformationIsVerified:
            json["user_account_information_is_verified"],
        userAccountInformationIsLocked:
            json["user_account_information_is_locked"],
        userIsAdmin: json["user_is_admin"],
        userAccountInformationCreatedAt:
            DateTime.parse(json["user_account_information_created_at"]),
        userAccountInformationUpdatedAt:
            DateTime.parse(json["user_account_information_updated_at"]),
      );
  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "user_first_name": userFirstName,
      "user_middle_name": userMiddleName,
      "user_last_name": userLastName,
      "user_identification_country_of_issue": userIdentificationCountryOfIssue,
      //"user_identification_type": userIdentificationType,
      "user_identification_number": userIdentificationNumber,
      "user_email_address": userEmailAddress,
      "user_is_admin": userIsAdmin,
      "user_phone_number": userPhoneNumber,
      "user_account_information_is_verified": userAccountInformationIsVerified,
      "user_account_information_is_locked": userAccountInformationIsLocked,
      "user_account_information_created_at": userAccountInformationCreatedAt,
      "user_account_information_updated_at": userAccountInformationUpdatedAt,
    };
  }

  @override
  List<Object> get props => [
        id,
        userFirstName.toString(),
        userMiddleName.toString(),
        userLastName.toString(),
        userIdentificationCountryOfIssue.toString(),
        //userIdentificationType.toString(),
        userIdentificationNumber.toString(),
        userEmailAddress.toString(),
        userIsAdmin.toString(),
        userPhoneNumber.toString(),
        userAccountInformationIsVerified.toString(),
        userAccountInformationIsLocked.toString(),
        userAccountInformationCreatedAt.toString(),
        userAccountInformationUpdatedAt.toString(),
      ];
}
