import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:code_munnity/widgets/article_content_widget.dart';
import 'package:code_munnity/widgets/author_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  var hourFormated;
  var dateFormated;
  List<Reference> list = List();
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
          title: Container(
            height: 50,
            child: Image.asset('assets/images/logo_white_letters.png', fit: BoxFit.cover,)
            ),
       ),
       body: _currentArticle == null ? 
       Center(
         child:  Container(
           height:25.0, 
           width:25.0, 
           child: CircularProgressIndicator()
          )
       ):
       ZefyrScaffold(
         child: _getArticleBody()
       )
    );
  }

  ///This function retrieve an article
  _loadArticle(){
    _service.getArticle(widget.idArticle).then((value){
      _currentArticle = value;
      print(widget.idArticle);
      setState(() {
        date = DateTime.fromMillisecondsSinceEpoch(_currentArticle.date.seconds*1000);
        hourFormated = DateFormat.jm().format(date);
        dateFormated = DateFormat.yMMMEd().format(date);
        list = _currentArticle.references.references;
        print(list[0].reference);
      });
    });
  }

  ///This function return article body container 
  Widget _getArticleBody(){
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
                  image: NetworkImage(_currentArticle.imgurl),
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