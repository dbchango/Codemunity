import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/models/article_favorite.dart';
import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/models/quill_article.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/providers/auth.dart';
import 'package:code_munnity/providers/quill_articles_service.dart';
import 'package:code_munnity/screens/articles_sdk_screen.dart';
import 'package:code_munnity/utils/preferences.dart';
import 'package:code_munnity/widgets/article_box_widget.dart';
import 'package:code_munnity/widgets/aticle_fav_box_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';
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
  Preferences _prefs = new Preferences();
  final AuthService _auth = AuthService();
  Articles _list;
  Author gAuthor;
  User currUser;
  CollectionReference articlesFReff = FirebaseFirestore.instance.collection('articles_favorites');
  FocusNode _focusNode;
  final prefs = new Preferences();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
  
    gAuthor = Author.fromJson(json.decode(_prefs.gauthor));
    Query articles = articlesFReff.where('idUserFavorite', isEqualTo: gAuthor.uid);
    return StreamBuilder<QuerySnapshot>(
      stream: articles.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            key: scaffoldKey,
            body: Center(
              child:LoadingRotating.square()
            ),
          );
        }
        return Scaffold(
          key: scaffoldKey,
          body: ListView(
            children: 
            
              snapshot.data.docs.map((DocumentSnapshot d){
                var temp = d.data();
                ArticleFavorite artFav = ArticleFavorite.fromJson(temp);
                artFav.id = d.id;
                return Card(
                  child: Column(
                    children:[
                      ArticleFavoriteBoxWidget(
                        article: artFav,
                      ),
                      _getDeleteButton(artFav)
                    ]
                  ),
                );
              }).toList(),
          ),
        );
      },
    );
  }

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

  Widget _getDeleteButton(ArticleFavorite articleF){
    return IconButton(
      icon: Icon(Icons.delete), 
      onPressed: () {
        deleteDocument(articleF.id);
      },
    );
  }

  void deleteDocument(String idArticle) async {
    articlesFReff.doc(idArticle).delete()
    .then((value) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Articulo eliminado de favoritos"))
      );
    })
    .catchError((error) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Failed to delete user: $error"))
      );
    });
    
  }

}