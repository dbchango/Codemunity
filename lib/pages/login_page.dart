import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:code_munnity/theme/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    
    super.initState();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            _getBackground(context),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              width: MediaQuery.of(context).size.width,
              child: _getFormLogin(context),
            )
          ],
        ),
      )
    );
  }

  Widget _getBackground(BuildContext context){
    final size = MediaQuery.of(context).size;
    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Theme.of(context).primaryColorDark.withAlpha(100)
      ),
    );
    return Stack(
      children: [
        Container(
          height: size.height * 0.4,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight,
              ] )
          ),
        ),
        Positioned(top: 90, left: 30, child: circle),
        Positioned(top: -40, left: -30, child: circle),
        Positioned(bottom: -50, right: -10, child: circle),
        Positioned(bottom: 120, right: 20, child: circle),
        Positioned(bottom: -50, left: -20, child: circle),
        SafeArea(
          child: Center(
            child : Container(
              padding: EdgeInsets.only(top:75.0),
              child: Column(
              
                children: [
                  getLogoImg(height: 75),
                  
                  // Text('Login', style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          )
        )
      ],
    );
  }

  Widget _getFormLogin(BuildContext context){
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(child: Container(height: 180.0,)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            width: size.width * .80,
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Iniciar Sesión',
                  style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color:primaryColor),),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.email, color: primaryColor,),
                    hintText: 'usuario@mail.com',
                    labelText: 'Email'
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock, color: primaryColor,),
                    labelText: 'Contraseña'
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                RaisedButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                    child: Text('Ingresar'),
                  ),
                  textColor: Colors.white,
                  onPressed: ()=>{},
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}