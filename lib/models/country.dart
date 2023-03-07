// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

List<Country> countryFromJson(String str) => List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  Country({
    required this.name,
    required this.code,
    required this.languages,
    required this.flag,
  });

  String name;
  String code;
  List<String> languages;
  String flag;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    code: json["code"],
    languages: List<String>.from(json["languages"].map((x) => x)),
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "flag": flag,
  };
}
