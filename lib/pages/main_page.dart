import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/pages/maps_page.dart';
import 'package:code_munnity/pages/profile_page.dart';
import 'package:code_munnity/pages/support_PAGE.dart';
import 'package:code_munnity/providers/content_provider.dart';
import 'package:code_munnity/screens/collection_screen.dart';
import 'package:code_munnity/screens/home_screen.dart';
import 'package:code_munnity/screens/search_screen.dart';
import 'package:code_munnity/screens/write_article_screen.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:code_munnity/utils/preferences.dart';
import 'package:code_munnity/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  
  static List<Widget> _pages = <Widget>[
    HomeScreen(
      key: PageStorageKey('Home'),
    ),
    WriteArticleScreen(
      key: PageStorageKey('Escribir'),
    ),
    SearcScreen(
      key: PageStorageKey('Buscar'),
    ),
    CollectionScreen(
      key: PageStorageKey('Colecciones')
    ),
    SupporPage(
      key: PageStorageKey('Soporte')
    )
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;      
    });
  }

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: getdrawer(test),
        appBar: AppBar(
          centerTitle: true,
          title: getLogoImg(),
        ),
        body: PageStorage(bucket: _bucket, child: _pages[_selectedIndex],),
        bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.create),
                  label: 'Escribir'
                ),
                 BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Buscar'
                ),
                 BottomNavigationBarItem(
                  icon: Icon(Icons.collections_bookmark_outlined),
                  label: 'Colecciones'
                )

              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).accentColor,
              onTap: _onItemTapped,
         
          ),
          
    );

    
  }

  Widget getdrawer(Author author){
    final prefs = new Preferences();
    final _contentProvider = Provider.of<ContentProvider>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[

            UserAccountsDrawerHeader(
              accountName: Text(author.name),
              accountEmail: Text(author.mail),
              currentAccountPicture: CircleAvatar(
                                     backgroundImage: NetworkImage(author.avatarimgurl),
                                     backgroundColor: Colors.transparent,
                                    ),
            ),
            
            
            ListTile(
              leading: new Icon(Icons.account_circle_outlined),
              title: new Text("Perfil"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
              },
            ),
            Divider(),
            ListTile(
              leading: new Icon(Icons.map),
              title: new Text("Mapas"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MapsPage()));
              },
            ),
            Divider(),
            ListTile(
              leading: new Icon(Icons.support),
              title: new Text("Soporte"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SupporPage()));
              },
            ),
            Divider(),
            ListTile(
              leading: new Icon(Icons.lightbulb),
              title: new Text("Modo nocturno"),
              trailing: Checkbox(
                value: prefs.mode,
                onChanged: (value){
                  prefs.mode = value;
                  _contentProvider.darkMode = prefs.mode;
                  if(prefs.mode){
                    print("Modo nocturno activado");
                  } else {
                    print("Modo nocturno desactivado");
                  }
                  setState(() {});
                },
              ),
            ),
            Divider(),
        ],
      ),
    );
  }

  

}