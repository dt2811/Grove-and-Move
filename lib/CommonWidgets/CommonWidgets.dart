import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

Widget gridItem(String image, double height, double width, String text) {
  return Container(
    height: 0.2 * height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
          height: 0.13 * height,
          width: 0.35 * width,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
              text,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget TopMusicCards(double Height, double Width, String Url, String Name,
    String Artist) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 1.0
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0) //
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Url != null ? Container(
            height: 0.3 * Height,
            width: 0.5*Width,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.0
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                )
            ),
            child: Image.network(Url, fit: BoxFit.fill,),
          ) : Container(),
          Name != null ? Container(
            margin: EdgeInsets.only(top: Height * 0.01),
            child: Text(Name,
              style: TextStyle(fontSize: Height * 0.03, color: Colors.white,),
              maxLines: 1,),
          ) : Container(),
          Artist != null ? Container(
            margin: EdgeInsets.only(top: Height * 0.004),
            child: Text('By ${Artist}',
                style: TextStyle(fontSize: Height * 0.02, color: Colors.white),
                maxLines: 1),
          ) : Container(),
        ],
      )
  );
}

Widget TopPlaylist(String Url,String Playlist, double Height, double Width) {
  return Url!=null?Container(
    alignment: Alignment.center,
    height: 0.2 * Height,
    width: 0.4 * Width,
    padding: EdgeInsets.only(top: Height * 0.15),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            Url),
        fit: BoxFit.cover,
      ),),
    child: Text(
      Playlist.toUpperCase(), style: TextStyle(fontSize: Height * 0.05, color: Colors.white,),
      textAlign: TextAlign.center,),
  ):Container();
}

// Widget MusicCards(double Height,double Width,String ImageUrl,String Name,String MovieName,List Artist, ){

Widget MusicCards2(
    {String Name = "", String MovieName = "", String ImageUrl = ""}) {
  //List Artist
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 23,
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                image: DecorationImage(image: NetworkImage(ImageUrl)),
              ),
            ),
            SizedBox(
              width: 13,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Name,
                  style:
                  TextStyle(fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Arijit Singh",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        // playList == "My Playlist"
        //     ? RemoveFromPlaylistPopUpButton(title,elementRemove)
        //     : SongPopUpMenuButton(title),
      ],
    ),
  );
}


Widget MusicCards(double Height, double Width, String ImageUrl, String Name,
    String MovieName, List Artist,) {
  return Container(
      /*decoration: BoxDecoration(
          border: Border.all(
              width: 1.0,
              color: Colors.white
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0) //
          )
      ),*/
    color: HexColor("FF211F1F"),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageUrl != null ? Container(
            margin: EdgeInsets.only(top:Height*0.01, bottom: Height * 0.01,left:Width*0.04,right:Width*0.02 ),
              padding: EdgeInsets.all(20),
              height: Height*0.1,
              width: Width*0.15 ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image:NetworkImage(ImageUrl, scale: 0.5,)),
              ),
              ):Container(),
          Container(
            child: Column(
              children: [
                Name != null ? Container(
                  child:
                      Text(Name, style: TextStyle(
                          fontSize: Height * 0.02, color: Colors.white)),
                ) : Container(),
                MovieName != null ? Container(
                    margin: EdgeInsets.only(top: Height * 0.01),
                    child:Text(MovieName, style: TextStyle(
                            fontSize: Height * 0.02, color: Colors.white)),
                ) : Container(),
                Artist != null ? Container(
                  margin: EdgeInsets.only(top: Height * 0.01),
                  child: Text(Artist[0], style: TextStyle(
                        fontSize: Height * 0.02, color: Colors.white,),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,),

                  ) : Container(),
              ],
            ),
          ),

        ],
      )
  );
}

Widget ArtistCard(double Height, double Width, String Url, String Artist) {
  return Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Url!=null?new Container(
            margin: EdgeInsets.only(top: 0.01 * Height),
            child: CircleAvatar(
              radius: Height * 0.1,
              backgroundImage: NetworkImage(
                  Url),
            ),
          ):Container(),
          Artist!=null?Container(
            margin: EdgeInsets.only(top: Height * 0.005),
            child: Text(Artist.toUpperCase(),
                style: TextStyle(fontSize: Height * 0.03, color: Colors.white)),
          ):Container(),
        ],
      )
  );
}
