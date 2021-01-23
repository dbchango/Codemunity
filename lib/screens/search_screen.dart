import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/pages/article_page.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/widgets/article_box_widget.dart';
import 'package:flutter/material.dart';

class SearcScreen extends StatefulWidget {
  SearcScreen({Key key}) : super(key: key);

  @override
  _SearcScreenState createState() => _SearcScreenState();
}

class _SearcScreenState extends State<SearcScreen> {
  ArticleService _service;
  Articles _list;
  @override
  void initState() {
    _service = new ArticleService();
    super.initState();
    _loadArticles();
    
  }
  
  @override
  Widget build(BuildContext context) {
    
    return _list == null 
    ? Center(child: Text("Loading articles..."))
    : ListView(
      children: _list.items.map((e) {
        return _getArticleItem(e);
      }).toList(),
    );
    
  }

  

  _loadArticles(){
    _service.getArticles().then((value) {
      _list = value;
      print(_list);
      setState(() {
        
      });
    });
  }

  Widget _getArticleItem(Article article){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: 
          (context)=>ArticlePage(
            idArticle:article.id
          )));
      },
      child: ArticleBoxWidget(
        title: article.title,
      )
    ,);
      
    
  }
}