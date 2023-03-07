// To parse this JSON data, do
//
//     final stream = streamFromJson(jsonString);

import 'dart:convert';

List<StreamS> streamFromJson(String str) => List<StreamS>.from(json.decode(str).map((x) => StreamS.fromJson(x)));

String streamToJson(List<StreamS> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StreamS {
  StreamS({
    this.channel,
    required this.url,
    this.httpReferrer,
    this.userAgent,
    this.status,
    this.width,
    this.height,
    this.bitrate,
    this.frameRate,
    required this.addedAt,
    required this.updatedAt,
    required this.checkedAt,
  });

  String? channel;
  String url;
  String? httpReferrer;
  String? userAgent;
  String? status;
  int? width;
  int? height;
  int? bitrate;
  double? frameRate;
  String addedAt;
  String updatedAt;
  String checkedAt;

  factory StreamS.fromJson(Map<String, dynamic> json) => StreamS(
    channel: json["channel"],
    url: json["url"],
    httpReferrer: json["http_referrer"],
    userAgent: json["user_agent"],
    status: json["status"],
    width: json["width"],
    height: json["height"],
    bitrate: json["bitrate"],
    frameRate: json["frame_rate"]?.toDouble(),
    addedAt: json["added_at"],
    updatedAt: json["updated_at"],
    checkedAt: json["checked_at"],
  );

  Map<String, dynamic> toJson() => {
    "channel": channel,
    "url": url,
    "http_referrer": httpReferrer,
    "user_agent": userAgent,
    "status": status,
    "width": width,
    "height": height,
    "bitrate": bitrate,
    "frame_rate": frameRate,
    "added_at": addedAt,
    "updated_at": updatedAt,
    "checked_at": checkedAt,
  };
}
