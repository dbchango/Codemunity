// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    this.title,
    this.text,
    this.icon,
  });

  String title;
  String text;
  String icon;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        title: json["title"],
        text: json["text"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "icon": icon,
      };
}
