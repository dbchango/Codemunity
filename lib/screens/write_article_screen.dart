import 'package:flutter/material.dart';

class WriteArticleScreen extends StatefulWidget {
  WriteArticleScreen({Key key}) : super(key: key);

  @override
  _WriteArticleScreenState createState() => _WriteArticleScreenState();
}

class _WriteArticleScreenState extends State<WriteArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('Write Article Widget'),
    );
  }
}