import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class ArticleContentWidget extends StatefulWidget {
  final String content;
  ArticleContentWidget({
    Key key,
    this.content
  }) : super(key: key);

  @override
  _ArticleContentWidgetState createState() => _ArticleContentWidgetState();
}

class _ArticleContentWidgetState extends State<ArticleContentWidget> {
  
  NotusDocument _document;

  @override
  void initState() {
    super.initState();
    _document = _loadDocument();
  }
  @override
  Widget build(BuildContext context) {
    return  _getBuild();
  }

  Widget _getBuild(){
    if(widget.content == null){
      return Center(child: CircularProgressIndicator());
    }else{
      return ZefyrView(
            document: _document,
          );
    }
  }

  NotusDocument _loadDocument() {
    if (widget.content!=null ) {
      final contents = widget.content;
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    final Delta delta = Delta()..insert("No se ha podido cargar el contenido\n");
    return NotusDocument.fromDelta(delta);
  }

}