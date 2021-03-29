import 'dart:convert';

import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/models/quill_article.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/providers/quill_articles_service.dart';
import 'package:code_munnity/screens/articles_sdk_screen.dart';
import 'package:code_munnity/widgets/aticle_box_widget_stack.dart';
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
  ArticleService _service;
  Articles _list;
  FocusNode _focusNode;

  @override
  void initState() {
    _service = new ArticleService();
    super.initState();
    // final document = _loadDocument();
    // _controller = ZefyrController(document);
    _focusNode = FocusNode();
    _loadArticles();
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
          children:  [
            _list==null? Center(child: CircularProgressIndicator()):
            Container(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 3,
                childAspectRatio: .85,
                mainAxisSpacing: 10,
                children: _list.items.map((e) {return Container(padding: EdgeInsets.all(8), child: ArticleBoxStack(article: e,),);}).toList(),
              ),
            ),
            ArticlesSDKWidget()
          ],
        ),
      )
    );
  }
/*
  NotusDocument _loadDocument(){
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }*/
  
  void saveDocument(BuildContext context) async {
    final contents = jsonEncode(_controller.document);
    qa.content = contents;
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

  _loadArticles() {
    _service.getArticles().then((value) {
      if(mounted){
        setState(() {
          _list = value;
        });
      }
    });
  }

}