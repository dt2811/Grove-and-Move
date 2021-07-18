

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/CommonWidgets/CommonWidgets.dart';

class LandingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LandingPage();
  }

}
class _LandingPage extends State<LandingPage>{
  @override
  Widget build(BuildContext context) {
   double Height =MediaQuery.of(context).size.height;
   double Width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
            Container(
              margin: EdgeInsets.only(right: Width*0.4,bottom: Height*0.02,top:Height*0.02 ),
              child:Text('Recently Added Songs',style: TextStyle(fontSize: Height*0.05,color: Colors.white),),
            ),
              Container(
                  height: Height*0.28,
                  child:ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>ProductDetailsMachinery(data[KeyConstants.RESULT][index][KeyConstants.ID])) )*/
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Width*0.02,right:Width*0.02 ),
                            child:TopMusicCards(Height,Width,'abc', 'abc', 'abc') ,
                          ),
                        );
                      },
                      itemCount: 10, separatorBuilder: (BuildContext context, int index) {  return SizedBox(height: 10,width: 10,);},)
              ),

              Container(
                margin: EdgeInsets.only(right: Width*0.7,bottom: Height*0.02,top: Height*0.03),
                child:Text('Artists',style: TextStyle(fontSize: Height*0.05,color: Colors.white),),
              ),
              Container(
                  height: Height*0.28,
                  child:ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>ProductDetailsMachinery(data[KeyConstants.RESULT][index][KeyConstants.ID])) )*/
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: Width*0.02,right:Width*0.02 ),
                          child:ArtistCard(Height,Width,'abc', 'abc', 'abc') ,
                        ),
                      );
                    },
                    itemCount: 10, separatorBuilder: (BuildContext context, int index) {  return SizedBox(height: 10,width: 10,);},)
              ),
              Container(
                margin: EdgeInsets.only(right: Width*0.5,bottom: Height*0.02,top: Height*0.03),
                child:Text('Top Playlists',style: TextStyle(fontSize: Height*0.05,color: Colors.white),),
              ),
             Container(
               child:Column(
                 children: [
                   Row(
                     children: [
                       SizedBox(width: Width*0.01,),
                       Expanded(
                         child:GestureDetector(child:TopPlaylist("abc", Height, Width)),
                       ),
                       SizedBox(width: Width*0.01,),
                       Expanded(
                         child:GestureDetector(child:TopPlaylist("abc", Height, Width)),
                       ),
                       SizedBox(width: Width*0.02,),
                     ],
                   ),
                   SizedBox(height: Height*0.01,),
                   Row(
                     children: [
                       SizedBox(width: Width*0.01,),
                       Expanded(
                         child:GestureDetector(child:TopPlaylist("abc", Height, Width)),
                       ),
                       SizedBox(width: Width*0.01,),
                       Expanded(
                         child:GestureDetector(child:TopPlaylist("abc", Height, Width)),
                       ),
                       SizedBox(width: Width*0.02,),
                     ],
                   ),
                   SizedBox(height: Height*0.01,),
                 Row(
                   children: [
                     SizedBox(width: Width*0.01,),
                     Expanded(
                       child:GestureDetector(child:TopPlaylist("abc", Height, Width)),
                     ),
                     SizedBox(width: Width*0.01,),
                     Expanded(
                       child:GestureDetector(child:TopPlaylist("abc", Height, Width)),
                     ),
                     SizedBox(width: Width*0.02,),
                   ],
                 ),
                   SizedBox(height: Height*0.01,),
                 ],
               )
             ),
              Container(
                margin: EdgeInsets.only(right: Width*0.6,bottom: Height*0.02,top: Height*0.03),
                child:Text('TOP 10 ',style: TextStyle(fontSize: Height*0.05,color: Colors.white),),
              ),
              Container(
                  height: Height*0.28,
                  child:ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>ProductDetailsMachinery(data[KeyConstants.RESULT][index][KeyConstants.ID])) )*/
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: Width*0.02,right:Width*0.02 ),
                          child:TopMusicCards(Height,Width,'abc', 'abc', 'abc') ,
                        ),
                      );
                    },
                    itemCount: 10, separatorBuilder: (BuildContext context, int index) {  return SizedBox(height: 10,width: 10,);},)
              ),
            ]
          ),
        ),
      ),
      ),
    );
  }

}