import 'package:code_munnity/models/message_model.dart';
import 'package:code_munnity/models/support_message.dart';
import 'package:code_munnity/utils/routes.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';

class SupportService{
  String _urlRoot = fireStoreURL+"supportmessages";
  Map<String, String> _headers = {"Content-Type": "application/json"};

  SupportService();

  Future<Message> post(SupportMessage sm) async {
    final resp = await http.post(_urlRoot, headers: _headers, body: supportMessageToJson(sm));
    if(resp.body.isEmpty) return null;
    final decodedData = json.decode(resp.body);
    final message = new Message.fromJson(decodedData);
    return message;
  }

  Future<String> uploadImage(File img) async {
    final url = Uri.parse(cloudinaryURL);
    final mimeType = mime(img.path).split("/");

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath("file", img.path,
    contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final imageResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(imageResponse);
    if( resp.statusCode != 200 ){
      print('Error: ' + resp.body);
      return null;
    }
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }


}