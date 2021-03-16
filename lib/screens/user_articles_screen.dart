import 'package:code_munnity/theme/constants.dart';
import 'package:flutter/material.dart';

class UserArticlesScreen extends StatefulWidget {
  UserArticlesScreen({Key key}) : super(key: key);

  @override
  _UserArticlesScreenState createState() => _UserArticlesScreenState();
}

class _UserArticlesScreenState extends State<UserArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: getLogoImg(),
      ),
      body: Stack(
        children: [
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: .85,
            crossAxisSpacing: 2,
            mainAxisSpacing: 10,
            children: [
              
            ],
          ),
        ]
      ),
    );
  }
}