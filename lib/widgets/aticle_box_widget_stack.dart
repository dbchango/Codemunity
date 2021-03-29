import 'package:code_munnity/models/article.dart';
import 'package:flutter/material.dart';

class ArticleBoxStack extends StatefulWidget {
  ArticleBoxStack({Key key, this.article}) : super(key: key);
  final Article article;
  @override
  _ArticleBoxStackState createState() => _ArticleBoxStackState();
}

class _ArticleBoxStackState extends State<ArticleBoxStack> {
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
          color: Colors.transparent,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: ClipRRect(
          
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(10),
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
               
                Align(alignment: Alignment.topLeft, child: _getText(widget.article.title, 12.0,2),), // title
                _getText(widget.article.abstract, 15.0, 4) // abstract
              ],
            ),
          ),
        ),
    );
  }

  Widget _getText(String content, double fontSize, int maxLines){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: RichText(
        maxLines: maxLines==null?1:maxLines,
        text: TextSpan(
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: fontSize, fontWeight: FontWeight.bold),
          text: content
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}