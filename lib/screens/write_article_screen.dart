import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WriteArticleScreen extends StatefulWidget {
  WriteArticleScreen({Key key}) : super(key: key);

  @override
  _WriteArticleScreenState createState() => _WriteArticleScreenState();
}

class _WriteArticleScreenState extends State<WriteArticleScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    return Container(
       padding:  EdgeInsets.all(50),
       child: Form(
         key: _formKey,
         child: ListView(
           children: <Widget>[
           Padding(
             
             padding: const EdgeInsets.symmetric(horizontal: 2),
             child: Container(child: Text("New Publication" ,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
           ),
           TextFormField(
               
             )
         ],
         ) 
       ),
    );
  }
}