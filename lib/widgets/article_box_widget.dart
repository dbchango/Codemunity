import 'package:code_munnity/models/author.dart';
import 'package:flutter/material.dart';

class ArticleBoxWidget extends StatelessWidget {
  final String title;
  final Author author;
  final String content;
  final Function press;
  //final String assetName;
  const ArticleBoxWidget(
    {
      Key key,
      this.title, 
      this.author,
      this.content,
      this.press,
      //this.assetName
    }
    ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Card(
      child:ClipRRect(
         borderRadius: BorderRadius.circular(10),
         child: Column(
           children: [
             Container(
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(12),
                 boxShadow: [
                   BoxShadow(
                     offset: Offset(0, 17),
                     blurRadius: 17,
                     spreadRadius: -23,
                     color: Colors.grey
                   )
                 ]
               ),
               child: Material(
                 color: Colors.transparent,
                 
                 child: Padding(
                     padding: const EdgeInsets.all(20.0),
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
                                 Container(
                    
                                 ),
                                 Row(
                                   children: [
                                     Container(
                                       child: Flexible(
                                        flex: 0,
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              style: TextStyle(color: Colors.black),
                                              text:  author == null? "Mayuko":author.name  
                                            ),
                                          ),
                                        
                                      ),
                                     ),
                                     Expanded(
                                   flex: 0,
                                   child: CircleAvatar(
                                     backgroundImage: NetworkImage('https://yt3.ggpht.com/ytc/AAUvwnivjbUJ86-ZYW6puGnhv0Rey-osg2TL00CF-sEXXw=s900-c-k-c0x00ffffff-no-rj'),
                                     backgroundColor: Colors.transparent,
                                    )
                                  )
                                   ],
                                 ),
                                  
                               ],
                             ),
                             //Spacer(),
                             //SvgPicture.asset(assetName),
                             
                             
                           ],
                         ),
                         Container(
                        
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
                                       Icon(Icons.remove_red_eye),
                                       Text(" Viewers "),

                                     ],
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Row(
                                     children: <Widget>[
                                       Icon(Icons.star_border),
                                       Text(" Stars "),
                                       
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
         ),
       ));
  }
}
