import 'Data.dart';
import 'dart:convert';

RespMain respMainFromJson(String str) => RespMain.fromJson(json.decode(str));
String respMainToJson(RespMain data) => json.encode(data.toJson());
class RespMain {
  RespMain({
      this.status, 
      this.data, 
      this.message,});

  RespMain.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }
  String? status;
  List<Data>? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}