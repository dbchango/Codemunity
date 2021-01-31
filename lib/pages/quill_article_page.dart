import 'dart:convert';

import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/models/quill_article.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/providers/quill_articles_service.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:code_munnity/widgets/author_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class QuillArticlePage extends StatefulWidget {
  final String idQuill;
  QuillArticlePage({Key key, @required this.idQuill}) : super(key: key);

  @override
  _QuillArticlePageState createState() => _QuillArticlePageState();
}

class _QuillArticlePageState extends State<QuillArticlePage> {
  QuillArticle _currentQuill;
  QuillArticlesService _service;
  DateTime date;
  ZefyrController _controller;
  FocusNode _focusNode;
  NotusDocument _document;
  var hourFormated;
  var dateFormated;
  @override
  void initState() {
    _service = new QuillArticlesService();
    super.initState();
     _loadQuill();
     _focusNode = FocusNode();
  }
  
  @override
  Widget build(BuildContext context) {
    final Widget body = (_document == null || _currentQuill == null)
        ? Center(child: CircularProgressIndicator())
        : ZefyrScaffold(
          child: ZefyrView(
            document: _document,
          )
        );
    return Scaffold(
      appBar: AppBar(title: Text(( _currentQuill == null)?"":_currentQuill.title),),
     
      body: (_document == null || _currentQuill == null)? Center(child: CircularProgressIndicator()):
      Container(
        padding: EdgeInsets.all(40),
        child: ZefyrScaffold(
          child: Column(
          children: [
            Text(_currentQuill.title),
            ZefyrView(
              document: _document,
              ),
            ],
          )
        )
      ),
    );
  }

  _loadQuill() {
    _service.retrieveQuill(widget.idQuill).then((value){
      _currentQuill = value;
      print(value.toJson());
      setState(() {
        //_controller = ZefyrController(_loadDocument());
        _document = _loadDocument();
      });
    });
  }

  NotusDocument _loadDocument() {
    if (_currentQuill.content!=null) {
      final contents = _currentQuill.content;
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

}