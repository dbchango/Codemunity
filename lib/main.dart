

import 'package:code_munnity/bloc/provider_bloc.dart';
import 'package:code_munnity/pages/login_page.dart';
import 'package:code_munnity/providers/content_provider.dart';
import 'package:code_munnity/utils/preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ContentProvider>(
      create: (_) => ContentProvider(),
    ),
 
    
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  final prefs = new Preferences();
  
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    return ChangeNotifierProvider<ContentProvider>(
      create: (BuildContext context) => ContentProvider(),
      child: Consumer<ContentProvider>(builder: (context, provider, __){
        provider.initDarkMode(prefs.mode);
        return MaterialApp(
        title: 'CodeMmunity',
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text("Error al iniciar",
                      style: Theme.of(context).textTheme.headline3),
                ),
              );
            }
            
            if(snapshot.connectionState == ConnectionState.done){
              return LoginPage();
            }
            return Container(
                  child: Center(
                    child: CircularProgressIndicator()
                  )
                );
          },
        ),
        themeMode: prefs.mode == true ?ThemeMode.dark:ThemeMode.light,
        darkTheme: ThemeData(
          cardColor: Colors.black26,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          accentColor: Colors.black
        ),
        theme: ThemeData(
          cardColor: Colors.white,
          primaryColorLight: Colors.indigo[300],
          primaryColorDark: Colors.black,
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        
      );
      },)
    );
  }


  
}

