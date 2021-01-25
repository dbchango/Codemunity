import 'package:code_munnity/models/author.dart';
import 'package:flutter/material.dart';

class ArticleBoxWidget extends StatelessWidget {
  final String title;
  final Author author;
  final String content;
  final Function press;
  final int readers;
  final int stars;

  //final String assetName;
  const ArticleBoxWidget(
    {
      Key key,
      this.title, 
      this.author,
      this.content,
      this.press,
      this.readers,
      this.stars
      //this.assetName
    }
    ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
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
                                       text: title
                                     ),  
                                   overflow: TextOverflow.ellipsis,
                                   ),
                             ),
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       child: Flexible(
                                        flex: 0,
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text:  author == null? "None":author.name  
                                            ),
                                          ),
                                        
                                      ),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                       child: CircleAvatar(
                                       backgroundImage: NetworkImage(author.avatarimgurl),
                                       backgroundColor: Colors.transparent,
                                    ),
                                     )
                                   ],
                                 ),
                                  
                               ],
                             ),
                           ],
                         ),
                         Container(
                           padding: EdgeInsets.symmetric(vertical: screenWidth/20),
                           child: Align(
                           alignment: Alignment.topLeft,
                           child: RichText(
                                 maxLines: 13,
                                 text: TextSpan(
                                   style: Theme.of(context)
                                   .textTheme
                                   .headline6
                                   .copyWith(fontSize: 15),
                                   text: content
                                 ),  
                               overflow: TextOverflow.ellipsis,
                               ),
                         ),
                         ),
                         Container(          
                           child: Padding(
                             padding: const EdgeInsets.all(6.0),
                             child: Row(
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Row(
                                     children: <Widget>[
                                       Icon(Icons.remove_red_eye_outlined),
                                       Text(readers.toString(), style: TextStyle(fontStyle: FontStyle.italic, ),),
                                       Text(" Lectores " , style: TextStyle(fontWeight: FontWeight.bold, ),)

                                     ],
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Row(
                                     children: <Widget>[
                                       Icon(Icons.star_border),
                                       Text(stars.toString(), style: TextStyle(fontStyle: FontStyle.italic, ),),
                                       Text(" Estrellas ", style: TextStyle(fontWeight: FontWeight.bold,),)

                                     ],
                                   ),
                                 )
                               ],
                             ),
                           )
                         ),
                       ],
                     ),
                    ),
                ),
             ),
           ],
         ),);
  }
}
