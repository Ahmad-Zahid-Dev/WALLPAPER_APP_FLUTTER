import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/fullscreenWP.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
@override
 void initState() {
  super.initState();
  fetchApi();
 }

  List image = [];
  int page = 1;
// API INTEGRATION
fetchApi() async{
   await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
  headers: {'Authorization' : 'MY9KRG4S7g2ePoWHzB0ZggNocM6aNhO5lEdPsLoaAks4lJO5FkG4kabk'}
  ).then((value) {
    Map result = jsonDecode(value.body);
    setState(() {
      image = result['photos'];
      //image.addAll(result['photos']);
    });
    print(image[0]);
    
  });
}

loadMore() async{
 setState(() {
   page = page + 1;
 });

   await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString()),
  headers: {'Authorization' : 'MY9KRG4S7g2ePoWHzB0ZggNocM6aNhO5lEdPsLoaAks4lJO5FkG4kabk'}
  ).then((value) {
    Map result = jsonDecode(value.body);
   setState(() {
     image.addAll(result['photos']);
   });
    
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child:GridView.builder(
                itemCount: image.length,
                
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 2/3
                  ) ,
                
                itemBuilder:(context , index){
                  return InkWell(
                    onTap: (){
                     Navigator.push(context,
                     MaterialPageRoute(builder: (context)=> Fullscreenwp(
                      imageurl: image[index]['src']['large2x'],
                     )));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(image[index]['src']['tiny'],
                      fit: BoxFit.cover,
                      ),
                      ),
                  );
                }
                
                )
               ),

               Container(
                width: double.infinity,
                height: 60,
                
                 child: ElevatedButton(
                 
                  
                  onPressed: (){
                  loadMore();
                  }, 
                  
                  child: Text('Load More' , style: TextStyle(fontSize: 20),)),
               )
          ],
        ),
      ),
    );
  }
}