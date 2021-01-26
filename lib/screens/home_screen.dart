
import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/pages/article_page.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/widgets/article_box_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ArticleService _service;
  Articles _list;
  @override
  void initState() {
    super.initState();
    _service = new ArticleService();
    _loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(size);
    return _list == null 
    ? Center(child: Text("Loading articles...")): Container(
      
      child: Padding(
                
                 padding: const EdgeInsets.symmetric(horizontal: 5),
                 child: ListView(
                   children: _list.items.map((e) {
                     return _getArticleItem(e);
                   }).toList(),
                 )
                ),
    );
  }

  

  _loadArticles() {
    _service.getArticles().then((value) {
      setState(() {
        _list = value;
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
        author: article.author,
        content: article.content,
        stars: article.stars,
        readers: article.readers,
      )
    ,);
      
    
  }

}
