// To parse this JSON data, do
//
//     final links = linksFromJson(jsonString);

import 'dart:convert';

Links linksFromJson(String str) => Links.fromJson(json.decode(str));

String linksToJson(Links data) => json.encode(data.toJson());

class Links {
  Links({
     this.id,
     this.linkHome,
     this.linkHelp,
     this.linkPolicy,
     this.linkZalo,
  });

  String? id;
  String? linkHome;
  String? linkHelp;
  String? linkPolicy;
  String? linkZalo;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    id: json["Id"],
    linkHome: json["linkHome"],
    linkHelp: json["linkHelp"],
    linkPolicy: json["linkPolicy"],
    linkZalo: json["linkZalo"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "linkHome": linkHome,
    "linkHelp": linkHelp,
    "linkPolicy": linkPolicy,
    "linkZalo": linkZalo,
  };
}
