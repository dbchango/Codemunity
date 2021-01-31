import 'dart:io';

import 'package:code_munnity/utils/routes.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class StorageService{
  StorageService();

  Future<String> _uploadImg(File img)async{
    final url = Uri.parse(cloudinaryURL);
    final mimeType = mime(img.path).split("/");
    final imageUploadReq = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
                                'file', 
                                img.path,
                                contentType: MediaType(mimeType[0], mimeType[1])
                              );
    imageUploadReq.files.add(file);
    final imageRespone = await imageUploadReq.send();
    final resp = await http.Response.fromStream(imageRespone);
    if(resp.statusCode != 200){
      print('Error ${resp.body}');
      return null;
    }
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }

  Future<String> uploadImg(File img){
    return _uploadImg(img);
  }

}