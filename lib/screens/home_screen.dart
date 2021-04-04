
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/models/article_favorite.dart';
import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/utils/preferences.dart';
import 'package:code_munnity/widgets/article_box_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ArticleService _service;
  Articles _list;
  final prefs = new Preferences();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Author gAuthor = new Author(); 
  
  @override
  void initState() {
    super.initState();
    _service = new ArticleService();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    gAuthor = Author.fromJson(json.decode(prefs.gauthor));
    print('Id autor: '+gAuthor.id);
    CollectionReference articles = FirebaseFirestore.instance.collection('articles');
    return StreamBuilder<QuerySnapshot>(
      stream: articles.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator(),),
                );
        }
        return Scaffold(
        key: scaffoldKey,
        body: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot d) {
                  Article art = Article.fromJson(d.data());
                  art.id = d.id;
                  return ArticleBoxWidget(
                    article: art,
                  );
                } ).toList(),
              )
        );
      }
    ); 
  }

  Widget _getFavoritesButton(Article articleF){
    return IconButton(
      icon: Icon(Icons.favorite), 
      onPressed: () {
        _addFavorites(articleF);
      },
    );
  }

  void _addFavorites(Article article){
    CollectionReference articlesCollection = FirebaseFirestore.instance.collection('articles_favorites');
    ArticleFavorite _favorite = ArticleFavorite(
      idUserFavorite: gAuthor.uid,
      abstract: article.abstract, 
      author: article.author,
      category: article.category,
      content: article.content,
      date: article.date,
      id: article.id,
      idauthor: article.idauthor,
      idcategory: article.idcategory,
      imgurl: article.imgurl,
      labels: article.labels,
      references: article.references,
      title: article.title
    );
    articlesCollection.add(_favorite.toJson()).then((value) {
      scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Articulo de id: ${_favorite.id} agregado a favoritos"))
        );
    });
  }

  


}
