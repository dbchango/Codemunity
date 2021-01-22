
import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/providers/article_service.dart';
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
    return Container(
       
       child: Stack(
         children: <Widget>[
           SafeArea(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 12),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Expanded(
                     child: Column(
                       children: [
                         ArticleBoxWidget(
                             title: "My first post",
                             content: "When I first tapped into personal development, I tried to build as many positive habits as possible."
                                      +"I set up a morning routine, started to meditate, went to the gym frequently, and read at least one book per week."
                                      +"Yet, a year later, I didn’t feel happier, more fulfilled, or improved."
                                      +"And I didn’t understand why my life didn’t change even though I built all these new, powerful routines."
                                      +"Change your habits and you’ll change your life is one of the bold promises of the self-help world and I didn’t know why it didn’t work for me."
                                     
                          ),
                         ArticleBoxWidget(
                           title: "My first post is the bes sample to begin with this projecto test"
                         )
                       ],
                     )
                    ) 
                   

                 ],
               ),
              )
            )
         ],
       )
    );
  }

  

  _loadArticles() {
    _service.getArticles().then((value) {
      setState(() {
        _list = value;
      });
    });
  }

}
