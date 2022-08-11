import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/link.dart';
// dynamic _parseAndDecode(String response) {
//   return jsonDecode(response);
// }
class LinkRepo{
  // dynamic parseJson(String text) {
  //   return compute(_parseAndDecode, text);
  // }
  Future<Links?> getLink()async{
    var dio = Dio();
    // (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    dio.options.baseUrl = 'https://ku8989.net/api';
    try{
      final res = await dio.get('/get_data1.php?id=11');
      if(res.statusCode!=200){
        return null;
      }
      var link = json.decode(res.data);
      var links = Links.fromJson(link);
      return links;
    }catch(e){
      rethrow;
    }
  }
}