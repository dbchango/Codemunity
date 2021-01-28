import 'package:code_munnity/models/author.dart';
import 'package:flutter/material.dart';

class AuthorBoxWidget extends StatelessWidget {
  final Author author;
  const AuthorBoxWidget(
    {
      Key key,
      this.author
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Flexible(
            flex: 0,
            child: RichText(
              overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text:  author == null? "None":author.name,
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
                  backgroundImage: NetworkImage(author.avatarimgurl),
                  backgroundColor: Colors.grey,
            ),
          ),
        ],
      ),
);
}
}