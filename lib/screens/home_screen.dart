
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_munnity/models/article.dart';
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
    
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
        return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
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

  


}
