import 'package:code_munnity/theme/constants.dart';
import 'package:flutter/material.dart';

class WriteArticleScreen extends StatefulWidget {
  WriteArticleScreen({Key key}) : super(key: key);

  @override
  _WriteArticleScreenState createState() => _WriteArticleScreenState();
}

class _WriteArticleScreenState extends State<WriteArticleScreen> {
  static List<Widget> _references = <Widget>[
   
  ];
  static List<String> _referencesNames = <String>[
    
  ];
  final _formKey = GlobalKey<FormState>();
  var _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size.width;

    return Container(
       padding: colElementsPadding(),
       child: Form(
         key: _formKey,
         child: _getFormContent()
                ),
              );
            }

  _onTapAddRef(){
    final arrayLength = _referencesNames.length;
      final String newTitle = "Referencia "+(arrayLength+1).toString(); 
      _referencesNames.add(newTitle);
   setState(() {
      _references.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0),
        child: TextFormField(
                 decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: _referencesNames[arrayLength],
                   alignLabelWithHint: true 
                  ),
               ),
      )
    );
   });
  }
  _onTapDeleteRef(){
   setState(() {
      _referencesNames.removeLast();
      
      _references.removeLast();
      
   });
  }

  Widget _getFormContent(){
    return ListView(
           children: <Widget>[
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10),
             child: Container(child: Text("Nueva Publicación" ,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 10.0),
             child: TextFormField(
               decoration: InputDecoration(
                 helperText: "Dale un nombre a tus ideas",
                 border: OutlineInputBorder(),
                 labelText: "Titulo",
                 alignLabelWithHint: true 
                ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 10.0),
             child: TextFormField(
             decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: "Contenido",
                 alignLabelWithHint: true,
                 
                ),
                maxLines: 10,
             ),
           ),
           
           Container(
             decoration: BoxDecoration(
               
               border: Border.all(
                 color: Colors.black12,
                 width: 1
               ),
               borderRadius: BorderRadius.circular(5)
             ),
             child: Column(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.all(4),
                   child: Text("Referencias"),
                 ),
                 Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.circular(5)
                            ),
                            
                            child: IconButton(onPressed: _onTapAddRef, icon: Icon(Icons.add, color: Theme.of(context).accentColor,),)
                          ),
                          Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
                                    child: Text("Agregar referencia"),
                                  ),
                        ],
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)
                        ),
                        
                        child: Column(
                          children: _references,
                        ),
                      ),
                    ),

                
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)
                            ),
                            
                            child: TextButton(onPressed: _onTapDeleteRef, child: Icon(Icons.remove, color: Theme.of(context).accentColor))
                          ),
                        ],
                      )
                    ),
                        ],
                      )
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.0
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("Subir una imágen"),
                            ),
                            GestureDetector(
                              onTap: (){
                                print("Event on tap to upload an image");
                              },
                              child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Icon(Icons.upload_file),

                            ) 
                            )
                          ],
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: _size*.7,
                          
                            child: TextButton(onPressed: _onTapAddRef, child: Container(
                              decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(5)
                            ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Publicar"),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.send),
                                  ),
                                  
                                ],
                              ),
                            ))
                          ),
                          
                        ],
                      )
                    )
                    
                  ],
                  );
  }

}