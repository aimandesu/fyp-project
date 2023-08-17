import 'dart:io';

class HelpFormModel {
  final String name;
  final String address;
  final String postcode;
  final String district;
  final String phone;
  final String noIC;
  final String gender;
  final int age;
  final String category;
  final File selectedPDF;
  final List<File> pictures;

  //kena tmbh district, ni for pisahkn reference tu

  HelpFormModel({
    required this.name,
    required this.address,
    required this.postcode,
    required this.district,
    required this.phone,
    required this.noIC,
    required this.gender,
    required this.age,
    required this.category,
    required this.selectedPDF,
    required this.pictures,
  });
}
