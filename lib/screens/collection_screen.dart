import 'dart:convert';

import 'package:code_munnity/models/quill_article.dart';
import 'package:code_munnity/providers/quill_articles_service.dart';
import 'package:code_munnity/screens/articles_sdk_screen.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class CollectionScreen extends StatefulWidget {
  CollectionScreen({Key key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  //This allows to control the editor and the document
  
  QuillArticlesService _quillService = new QuillArticlesService();
  QuillArticle qa = new QuillArticle();
  ZefyrController _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "REST", icon:Icon(Icons.cloud_circle_rounded)),
              Tab(text: "SDK", icon:Icon(Icons.book_online))
            ],
        ),
        
        ),
        body: TabBarView(
          children: [
            ZefyrScaffold(
            child: ZefyrEditor(
              padding: EdgeInsets.all(16),
              controller: _controller, 
              focusNode: _focusNode
              ),
            ),
            ArticlesSDKWidget()
          ],
        ),
      )
    );
  }

  ///Load the document to be edited in Zefyr 
  NotusDocument _loadDocument(){
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }
  
  void saveDocument(BuildContext context) async {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly
    final contents = jsonEncode(_controller.document);
    qa.content = contents;
    //qa.title = "";
    await _quillService.createQuillArticle(qa).then(
      (value) {
        print(value.toJson());
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("${value.title}\n${value.text}"),
          )
        );
      }
    );
    
  }

  

}