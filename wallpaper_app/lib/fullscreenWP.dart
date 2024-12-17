import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

// ignore: must_be_immutable
class Fullscreenwp extends StatefulWidget {
  String imageurl;
    Fullscreenwp({Key? key  , required this.imageurl}):super(key: key);

  @override
  State<Fullscreenwp> createState() => _FullscreenwpState();
}

class _FullscreenwpState extends State<Fullscreenwp> {

  /*Future<void> setWallpaper() async{
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    String result = await WallpaperManager.setWallpaperFromFile(file.path,location);
  }*/

  /*Future<void> setWallpaper()async{
    int location = WallpaperManagerFlutter.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    await WallpaperManagerFlutter().setwallpaperfromFile(file.path, location);
  }*/
Future<void> setWallpaper()async{
  try{
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
  } on PlatformException {}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 29,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.imageurl),
              )),
              Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: (){
                     setWallpaper();
                  }, 
                  child: Text('Set Wallpaper' , style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),)),
              )
          ],
        ),
      ),
    );
  }
}