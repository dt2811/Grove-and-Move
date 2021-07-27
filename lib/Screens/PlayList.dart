import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/CommonWidgets/CommonWidgets.dart';
import 'package:grove_and_move/Constants/KeyConstants.dart';

import 'MusicScreen.dart';
class PlayList extends StatefulWidget {
  int SearchBy;
  String name;
  String Url;
  PlayList(this.SearchBy,this.name,this.Url);

  @override
  _PlayListState createState() => _PlayListState(this.SearchBy,this.name,this.Url);
}

class _PlayListState extends State<PlayList> {
  int searchBy;
  String name;
  String Url;
  String searchQuery = 'Kedarnath';
  List<String> SearchBy = [
    KeyContsants.Album,
    KeyContsants.Artists,
    KeyContsants.Language,
    KeyContsants.Genre,
  ];
  List Results = [];
  bool isSearching=true;

   _PlayListState(this.searchBy,this.name,this.Url);

   @override
  void initState() {
     super.initState();
     if(searchBy!=null&&name!=null && Url!=null){
       searchQuery=name;
       fetchResults();
     }
  }

  void fetchResults() {
    List temp=[];
    setState(() {
      Results.clear();
      isSearching=true;

    });
    FirebaseFirestore.instance
        .collection(KeyContsants.Songs)
        .where(SearchBy[searchBy].toString(), arrayContainsAny: [searchQuery])
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        temp.add(value.docs[i].data());
      }
      setState(() {
        Results.addAll(temp);
        isSearching=false;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child:Column(
          children: [
            SizedBox(height: size.height*0.08,),
            Url!=null?Container(
                 height: size.height*0.3,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image:NetworkImage(Url))
              ),
            ):Container(),/*CircleAvatar(
              radius: size.height*0.15,
              backgroundImage: NetworkImage(Url),
            ):Container()*/
            name!=null?Container(margin:EdgeInsets.only(top:size.height*0.02,bottom:size.height*0.02 ),child:Text(name.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: size.height*0.03),)):Container(),
            isSearching?Container(
              color:Colors.black,child: Center(child:CircularProgressIndicator()),):Results!=null&&Results.length>0?Container(
                    height: size.height*0.52,
                    child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                         onTap: () {
                         Navigator.push(
                           context,
                         MaterialPageRoute(
                                  builder: (context) =>MusicScreen(Results[index][KeyContsants.SongName], Results[index][KeyContsants.ImageLink], Results[index][KeyContsants.SongLink],Results[index][KeyContsants.Album][0],Results[index][KeyContsants.Artists],Results[index][KeyContsants.Duration])) );
                         },
                        child: Container(
                          margin: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03,top: size.height*0.01,bottom: size.height*0.02),
                          child:MusicCards(size.height, size.width, Results[index][KeyContsants.ImageLink],Results[index][KeyContsants.SongName] ,Results[index][KeyContsants.Album][0],Results[index][KeyContsants.Artists]),/*MusicCards2(Name: "ABD",ImageUrl: "https://via.placeholder.com/150",MovieName: "ABCD"), //MusicCards( ImageUrl: Results[index][KeyContsants.ImageLink],Name: Results[index][KeyContsants.SongName] ,MovieName: Results[index][KeyContsants.Album][0]),//,Results[index][KeyContsants.Artists]),//Height, Width*/
            
                        ),
                      );
                    },
                    itemCount: Results.length,

                  ),):Container(child:Text("SORRY COULDNT FIND THE SONGS",style:TextStyle(color:Colors.white))),

          ],
        ),
      ),
    );
  }
}