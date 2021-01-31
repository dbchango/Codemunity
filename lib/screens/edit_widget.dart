import 'dart:convert';

import 'package:code_munnity/models/article.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class EditWidget extends StatefulWidget {
  final Article article;
  EditWidget({Key key, this.article}) : super(key: key);

  @override
  _EditWidgetState createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {

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

    
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Editor page"),
        actions: <Widget>[
          Builder(builder: (context)=>IconButton(
            icon: Icon(Icons.save),
            onPressed: ()=>_saveDocument(context),
          )),
          Builder(builder: (context)=>IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: (){
              
            },
          ))
        ]
      ),
       body: ZefyrScaffold(
         child: ZefyrEditor(
           padding: EdgeInsets.all(16),
           controller: _controller, 
           focusNode: _focusNode
          ),
        ),
    );
  }

  ///Load the document to be edited in Zefyr 
  NotusDocument _loadDocument(){
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Escriba el contenido de su post aqui...\n");
    return NotusDocument.fromDelta(delta);
  }
  
  void _saveDocument(BuildContext context) {
    
    final contents = jsonEncode(_controller.document);
    widget.article.content = contents;
    print(widget.article.content);
    
  }
}