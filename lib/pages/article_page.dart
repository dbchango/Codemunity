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
       Container(
         padding: EdgeInsets.all(40),
         child: ListView(
           children: <Widget>[
             Padding(
               padding: EdgeInsets.only(bottom: 10),
               child: Text(_currentArticle.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
             ),
             Padding(
               padding: EdgeInsets.symmetric(vertical: 4),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text("Date"),
                   Row(
                     children: [
                       Container(
                          child: Flexible(
                          flex: 0,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text:  _currentArticle.author == null? "None":_currentArticle.author.name,
                                style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(fontSize: 15,)
                              ),
                            ),
                          
                        ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                                backgroundImage: NetworkImage(_currentArticle.author.avatarimgurl),
                                backgroundColor: Colors.transparent,
                          ),
                        ),
                     ],
                   )
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 10),
               child: FadeInImage(
                placeholder: AssetImage('assets/images/data_sciences.jpeg'),
            
                image: AssetImage('assets/images/data_structures.jpg'),
                fit: BoxFit.cover,
               ),
             ),
             Text(_currentArticle.content)
           ],
         ),
       )
       /*
       CustomScrollView(
         slivers: [
          SliverList(delegate: SliverChildListDelegate([Text(_currentArticle.content), SizedBox(height: 15.0,)]))
         ],
       ) */
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