import 'package:code_munnity/models/article_favorite.dart';
import 'package:code_munnity/pages/article_page.dart';
import 'package:code_munnity/widgets/author_box_widget.dart';
import 'package:flutter/material.dart';

class ArticleFavoriteBoxWidget extends StatelessWidget {
  final ArticleFavorite article;
  const ArticleFavoriteBoxWidget({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print(article.toJson());
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: 
          (context){
            print(article);
            return ArticlePage(
            idArticle:article.idArticle
          );
          }));
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 4,
        shadowColor: Theme.of(context).backgroundColor,
        child:Column(
             children: [
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(15),
                   boxShadow: [
                     BoxShadow(
                       offset: Offset(0, 17),
                       blurRadius: 17,
                       spreadRadius: -23,
                       color: Colors.transparent
                     )
                   ]
                 ),
                 child: Material(
                   color: Colors.transparent,
                   child: Padding(
                       padding: const EdgeInsets.all(15),
                       child: Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Container(
                                 width: screenWidth/2,
                                 child: Align(
                                 alignment: Alignment.topLeft,
                                 child: RichText(
                                      maxLines: 2,
                                      text: TextSpan(
                                        style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                                        text: article.title
                                      ),  
                                      overflow: TextOverflow.ellipsis,
                                     ),
                               ),
                               ),
                               AuthorBoxWidget(
                                 author:article.author,
                               )
                             ],
                           ),
                           Container(
                             padding: EdgeInsets.symmetric(vertical: screenWidth/20),
                             child: Align(
                             alignment: Alignment.topLeft,
                             child: RichText(
                                   maxLines: 4,
                                   text: TextSpan(
                                     style: Theme.of(context)
                                     .textTheme
                                     .headline6
                                     .copyWith(fontSize: 15),
                                     text: article.abstract
                                   ),  
                                 overflow: TextOverflow.ellipsis,
                                 ),
                           ),
                           ),/*
                           Container(          
                             child: Padding(
                               padding: const EdgeInsets.all(6.0),
                               child: Row(
                                 children: <Widget>[
                                   _getCounter(" Lectores ", Icons.remove_red_eye_outlined, article.readers),
                                   _getCounter(" Estrellas ", Icons.star_border, article.stars),
                                 ],
                               ),
                             )
                           ),*/
                         ],
                       ),
                      ),
                  ),
               ),
             ],
           ),
          ),
    );
  }
}