// To parse this JSON data, do
//
//     final channel = channelFromJson(jsonString);

import 'dart:convert';

List<Channel> channelFromJson(String str) => List<Channel>.from(json.decode(str).map((x) => Channel.fromJson(x)));

String channelToJson(List<Channel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Channel {
  Channel({
    required this.id,
    required this.name,
    required this.altNames,
    this.network,
    required this.owners,
    required this.country,
    this.subdivision,
    this.city,
    required this.broadcastArea,
    required this.languages,
    required this.categories,
    required this.isNsfw,
    this.launched,
    this.closed,
    this.replacedBy,
    this.website,
    required this.logo,
  });

  String id;
  String name;
  List<String> altNames;
  dynamic network;
  List<String> owners;
  String country;
  String? subdivision;
  String? city;
  List<String> broadcastArea;
  List<String> languages;
  List<String> categories;
  bool isNsfw;
  DateTime? launched;
  dynamic closed;
  dynamic replacedBy;
  String? website;
  String logo;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    id: json["id"],
    name: json["name"],
    altNames: List<String>.from(json["alt_names"].map((x) => x)),
    network: json["network"],
    owners: List<String>.from(json["owners"].map((x) => x)),
    country: json["country"],
    subdivision: json["subdivision"],
    city: json["city"],
    broadcastArea: List<String>.from(json["broadcast_area"].map((x) => x)),
    languages: List<String>.from(json["languages"].map((x) => x)),
    categories: List<String>.from(json["categories"].map((x) => x)),
    isNsfw: json["is_nsfw"],
    launched: json["launched"] == null ? null : DateTime.parse(json["launched"]),
    closed: json["closed"],
    replacedBy: json["replaced_by"],
    website: json["website"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "alt_names": List<dynamic>.from(altNames.map((x) => x)),
    "network": network,
    "owners": List<dynamic>.from(owners.map((x) => x)),
    "country": country,
    "subdivision": subdivision,
    "city": city,
    "broadcast_area": List<dynamic>.from(broadcastArea.map((x) => x)),
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "is_nsfw": isNsfw,
    "launched": "${launched!.year.toString().padLeft(4, '0')}-${launched!.month.toString().padLeft(2, '0')}-${launched!.day.toString().padLeft(2, '0')}",
    "closed": closed,
    "replaced_by": replacedBy,
    "website": website,
    "logo": logo,
  };
}
