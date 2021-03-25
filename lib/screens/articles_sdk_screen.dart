import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/widgets/article_box_widget.dart';
import 'package:flutter/material.dart';

class ArticlesSDKWidget extends StatelessWidget {
  const ArticlesSDKWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference articles = FirebaseFirestore.instance.collection('articles');
    
    return StreamBuilder<QuerySnapshot>(
            stream: articles.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError) {
                
                return Text(snapshot.error.toString());
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    height: 50.0,
                    width: 50.0,
                    child: Center(child: CircularProgressIndicator()));
              }
              
              return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot d) {
                  Article art = Article.fromJson(d.data());
                  art.id = d.id;
                  return ArticleBoxWidget(
                    article: art,
                  );
                } ).toList(),
              );
            },
          );
  }
}