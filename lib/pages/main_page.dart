import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/pages/profile_page.dart';
import 'package:code_munnity/pages/support_PAGE.dart';
import 'package:code_munnity/screens/collection_screen.dart';
import 'package:code_munnity/screens/home_screen.dart';
import 'package:code_munnity/screens/search_screen.dart';
import 'package:code_munnity/screens/write_article_screen.dart';
import 'package:flutter/material.dart';


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
    Author test = new Author(
      name: "Mayuko", 
      mail: "mayuko@mail.com",
      avatarimgurl: "https://yt3.ggpht.com/ytc/AAUvwnivjbUJ86-ZYW6puGnhv0Rey-osg2TL00CF-sEXXw=s900-c-k-c0x00ffffff-no-rj"
      );
    return Scaffold(
        drawer: getdrawer(test),
        appBar: AppBar(
          centerTitle: true,
          title: Text('CodeMmunity'),
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
                  label: 'Write'
                ),
                 BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search'
                ),
                 BottomNavigationBarItem(
                  icon: Icon(Icons.collections_bookmark_outlined),
                  label: 'Collections'
                )

              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber,
              onTap: _onItemTapped,
         
          ),
          
    );

    
  }

  Widget getdrawer(Author author){
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
              title: new Text("Soporte"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SupporPage()));
              },
            ),
            Divider(),
            
            ListTile(
              leading: new Icon(Icons.home),
              title: new Text("Profile"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
              },
            ),
            Divider(),
            
            
        ],
      ),
    );
  }

  

}