import 'dart:io';

class HelpFormModel {
  final String name;
  final String address;
  final String postcode;
  final String subDistrict;
  final String phone;
  final String noIC;
  final String gender;
  final int age;
  final String category;
  final File selectedPDF;
  final List<File> pictures;
  final List<Map<String, String>> familyMembers;
  final bool reviewed;
  final String authUID;
  final bool approved;
  final String actions;
  final String comment;

  HelpFormModel({
    required this.name,
    required this.address,
    required this.postcode,
    required this.subDistrict,
    required this.phone,
    required this.noIC,
    required this.gender,
    required this.age,
    required this.category,
    required this.selectedPDF,
    required this.pictures,
    required this.familyMembers,
    this.reviewed = false,
    required this.authUID,
    this.approved = false,
    this.actions = "",
    this.comment = "",
  });

  Map<String, dynamic> toJson(
    String selectedPDF,
    List<String> pictures,
    DateTime date,
  ) =>
      {
        'name': name,
        'address': address,
        'postcode': postcode,
        'subDistrict': subDistrict,
        'phone': phone,
        'noIC': noIC,
        'gender': gender,
        'age': age,
        'category': category,
        'selectedPDF': selectedPDF,
        'pictures': pictures,
        'familyMembers': familyMembers,
        'reviewed': reviewed,
        'authUID': authUID,
        'approved': approved,
        'date': date,
        'actions': actions,
        'comment': comment,
      };
}
