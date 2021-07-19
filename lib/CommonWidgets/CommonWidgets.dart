
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grove_and_move/Constants/Text_Styles.dart';

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
            style:headingTextStyle
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
Widget TopMusicCards(double Height,double Width,String Url,String Name,String Artist){
  return Container(

    width: Width*0.4,
      decoration:BoxDecoration(
          border: Border.all(
              width: 1.0
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0) //
          )
      ),
    child:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height:0.18*Height,
          width: 0.4*Width,
          decoration:BoxDecoration(
              border: Border.all(
                  width: 1.0
              ),
              borderRadius: BorderRadius.only(
                 topLeft:  Radius.circular(10.0) ,
                topRight:  Radius.circular(10.0),
              )
          ),
          child:Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',fit: BoxFit.fill,),
        ),
        Container(
         margin:EdgeInsets.only(top: Height*0.01),
          child: Text('SONG name',style: TextStyle(fontSize:Height*0.03,color: Colors.white),),
        ),
        Container(
          margin:EdgeInsets.only(top: Height*0.004),
          child: Text('artist name',style: TextStyle(fontSize:Height*0.02,color: Colors.white)),
        ),
      ],
    )
  );
}
Widget TopPlaylist(String Playlist,double Height,double Width){
  return Container(
    alignment: Alignment.center,
    height:0.2*Height,
    width: 0.4*Width,
      padding: EdgeInsets.only(top:Height*0.15),
      decoration: BoxDecoration(
      image: DecorationImage(
      image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
       fit: BoxFit.cover,
  ),),
   child:Text(Playlist,style: TextStyle(fontSize: Height*0.05,color: Colors.white,),textAlign: TextAlign.center,) ,
  );
}
/*Widget MusicCards(double Height,double Width,String Url,String Name,String Artist){
  return Container(
      decoration:BoxDecoration(

          border: Border.all(
              width: 1.0
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0) //
          )
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height:0.2*Height,
            width: 0.2*Width,
            child:Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',fit: BoxFit.fill,),
          ),
          Container(
            margin:EdgeInsets.only(top: Height*0.01),
            child: Text('SONG name',style: TextStyle(fontSize:Height*0.03,color: Colors.white),),
          ),
          Container(
            margin:EdgeInsets.only(top: Height*0.003),
            child: Text('artist name',style: TextStyle(fontSize:Height*0.02,color: Colors.white)),
          ),
        ],
      )
  );
}*/

Widget ArtistCard(double Height,double Width,String Url,String Name,String Artist){
  return Container(

      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Container(
            margin: EdgeInsets.only(top: 0.01 * Height),
            child: CircleAvatar(
              radius: Height * 0.1,
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
            ),
          ),
          Container(
            margin:EdgeInsets.only(top: Height*0.005),
            child: Text('artist name',style: TextStyle(fontSize:Height*0.03,color:  Colors.white)),
          ),
        ],
      )
  );
}
