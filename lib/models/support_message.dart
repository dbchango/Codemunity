// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

SupportMessage supportMessageFromJson(String str) => SupportMessage.fromJson(json.decode(str));

String supportMessageToJson(SupportMessage data) => json.encode(data.toJson());

class SupportMessage {
  SupportMessage({
    this.id,
    this.title,
    this.text,
    this.screenshot,
  });
  String id;
  String title;
  String text;
  String screenshot;

  factory SupportMessage.fromJson(Map<String, dynamic> json) => SupportMessage(
        id : json['id'],
        title: json["title"],
        text: json["text"],
        screenshot: json["screenshot"],
      );

  Map<String, dynamic> toJson() => {
        "id":id,
        "title": title,
        "text": text,
        "screenshot": screenshot,
      };
}
