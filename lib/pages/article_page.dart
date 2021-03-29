import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:code_munnity/widgets/article_content_widget.dart';
import 'package:code_munnity/widgets/author_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zefyr/zefyr.dart';

class ArticlePage extends StatefulWidget {
  final String idArticle;
  ArticlePage({Key key, @required this.idArticle}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Article _currentArticle;
  ArticleService _service;
  DateTime date;
  
  List<Reference> list = List();
  @override
  void initState() {
    _service = new ArticleService();
    super.initState();

    
  }
  
  @override
  Widget build(BuildContext context) {
    
    String id = widget.idArticle;
    DocumentReference docRef = FirebaseFirestore.instance.doc('articles/$id');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
            title: Container(
              height: 50,
              child: Image.asset('assets/images/logo_white_letters.png', fit: BoxFit.cover,)
              ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: docRef.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.hasError){
              return Text('Error al consultar.');
            }

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            _currentArticle = Article.fromJson(snapshot.data.data());
            return ZefyrScaffold(
              child: _getArticleBody()
            );
          },
        )
      );
  }



  ///This function return article body container 
  Widget _getArticleBody(){
    final date = DateTime.fromMillisecondsSinceEpoch(_currentArticle.date.seconds*1000);
    var hourFormated = DateFormat.jm().format(date);
    var dateFormated = DateFormat.yMMMEd().format(date);
    return Container(
           child: ListView(
             children: <Widget>[
               Padding(
                 padding: topElementsPadding(),
                 child: Text(_currentArticle.title, style: titleStyles(),),
               ),
               Padding(
                 padding: colElementsPadding(),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Text(dateFormated+" "+hourFormated),
                     
                     AuthorBoxWidget(
                       author: _currentArticle.author,
                     )
                   ],
                 ),
               ),
               Padding(
                 padding: imageNearBorder(),
                 child: FadeInImage(
                  placeholder: AssetImage('assets/images/logo_white_bg.png'),
                  image: _currentArticle.imgurl==null? AssetImage('assets/images/logo_white_bg.png') :NetworkImage(_currentArticle.imgurl),
                  fit: BoxFit.cover,
                 ),
               ),
               Padding(
                 padding: colElementsPadding(),
                 child: ArticleContentWidget(
                   content: _currentArticle.content,
                  ),
               ),
               Padding(
                 padding: colElementsPadding(),
                 child: Text("Referencias", style: subtitleStyles(),),
               ),
               Padding(
                 padding: colElementsPadding(),
                 child: Container(
                    decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)
                   ),
                   width: double.infinity,
                   child: Column(
                     
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: list == null ? []:list.map((e) {
                       return _getReference(e);
                     }).toList(),
                   ),
                 ),
               )
             ],
           ),
         );
  }

  ///This function return the article references
  Widget _getReference(Reference ref){
    return Container(
      alignment: Alignment.centerLeft,
   
      child: Text("[${(list.indexOf(ref)+1).toString()}] ${ref.reference}", textAlign: TextAlign.left,)
    );
  }

}