import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  final String idArticle;
  ArticlePage({Key key, @required this.idArticle}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Article _currentArticle;
  ArticleService _service;

  @override
  void initState() {
    _service = new ArticleService();
    super.initState();
    _loadArticle();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: _currentArticle == null ? Text('Articulo'):Text(_currentArticle.title ?? ""),
       ),
       body: _currentArticle == null ? Center(child:  Container(height:25.0, width:25.0, child: CircularProgressIndicator())):
       CustomScrollView(slivers: [
        _appBar(_currentArticle.title),
        SliverList(delegate: SliverChildListDelegate([Text(_currentArticle.content), SizedBox(height: 15.0,)]))
      ],) 
    );
  }

  Widget _appBar(String title){
   return SliverAppBar(
     backgroundColor: 
     Theme.of(context).primaryColor, 
     pinned: true,
     expandedHeight: 200.0, 
     flexibleSpace: FlexibleSpaceBar(
       centerTitle: true,
       title: Text(title),
       background: FadeInImage(
         placeholder: AssetImage('assets/images/data_sciences.jpeg'),
       
         image: AssetImage('assets/images/data_structures.jpg'),
         fit: BoxFit.cover,
        ),
       
       
         
     ),
   );
  }

  _loadArticle(){
    _service.getArticle(widget.idArticle).then((value){
      _currentArticle = value;
      print(widget.idArticle);
      setState(() {
        
      });
    });
  }

}