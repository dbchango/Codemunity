import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:code_munnity/utils/preferences.dart';
import 'package:code_munnity/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _prefs = new Preferences();
  Author _currentAuthor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentAuthor = Author.fromJson(json.decode(_prefs.gauthor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
  
        centerTitle: true,
        title: Row(mainAxisSize: MainAxisSize.min, children: [Text("Mi perfil  "), Icon(Icons.account_circle)],),
        ),
      body: profilePageBody()
    );
  }


  Widget profilePageBody(){
    return Container(
        child: ListView(
          padding: EdgeInsets.all(25),
          children: [
            Container(
              padding: EdgeInsets.all(40),
              child: PhysicalModel(
                shape: BoxShape.circle,
                elevation: 10.0,
                color: Colors.black,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: Image.network(_currentAuthor.avatarimgurl)
              ),
              )
            ),
           
            Text(
              "Nombre", 
              style: getTitlesAccountScreen(), 
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              mainAxisSize: MainAxisSize.min, 
              children: [
                Text(
                  _currentAuthor.name + " " + _currentAuthor.surname, 
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 17),
                )
              ],
            ),
            getSizedBox(),
            Text(
              "Correo", 
              style: getTitlesAccountScreen(), 
              textAlign: TextAlign.center,
            ),
            Text(
              _currentAuthor.mail, 
              style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 17),
              textAlign: TextAlign.center,
            ),
            getSizedBox(),

            Text(
              "Área de conocimiento:", 
              style: getTitlesAccountScreen(), 
              textAlign: TextAlign.center,
            ),
            Text(
              _currentAuthor.knowledgearea, 
              style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 17),
              textAlign: TextAlign.center,
            ),
            getSizedBox(),

            Text(
              "Descripción", 
              style: getTitlesAccountScreen(), 
              textAlign: TextAlign.center,
            ),
            Container(
              child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                    maxLines: 4,
                    text: TextSpan(
                      style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 17),
                      text: _currentAuthor.about
                    ),  
                  overflow: TextOverflow.ellipsis,
                  ),
              ),
            )

          ],
        ),
      );
  }

}