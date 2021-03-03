import 'package:cloud_firestore/cloud_firestore.dart';
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
        return Text("");
      },
    );
  }
}