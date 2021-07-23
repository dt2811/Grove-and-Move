import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/CommonWidgets/CommonWidgets.dart';
import 'package:grove_and_move/Constants/KeyConstants.dart';
import 'package:grove_and_move/FirebaseHelper/firebaseHelper.dart';
import 'package:grove_and_move/Screens/MusicScreen.dart';
import 'package:grove_and_move/Screens/PlayList.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingPage();
  }
}

class _LandingPage extends State<LandingPage> {
  List Results = [];

  @override
  void initState() {
    super.initState();

      fetchTopMusic();

  }

  fetchTopMusic() {
    List Temp = [];
    FirebaseFirestore.instance
        .collection(KeyContsants.Songs)
        .limit(10)
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        Temp.add(value.docs[i].data());
      }
      setState(() {
        Results = Temp;
        print("done");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              (Results != null && Results.length > 0)
                  ? Container(
                      margin: EdgeInsets.only(
                          right: Width * 0.4,
                          bottom: Height * 0.02,
                          top: Height * 0.02),
                      child: Text(
                        'Recently Added Songs',
                        style: TextStyle(
                            fontSize: Height * 0.05, color: Colors.white),
                      ),
                    )
                  : Container(),
              (Results != null && Results.length > 0)
                  ? Container(
                      height: Height * 0.3,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MusicScreen(
                                          Results[index][KeyContsants.SongName],
                                          Results[index]
                                              [KeyContsants.ImageLink],
                                          Results[index][KeyContsants.SongLink],
                                          Results[index][KeyContsants.Album][0],
                                          Results[index]
                                              [KeyContsants.Artists],"328")));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: Width * 0.02, right: Width * 0.02),
                              child: TopMusicCards(
                                  Height,
                                  Width,
                                  Results[index][KeyContsants.ImageLink],
                                  Results[index][KeyContsants.SongName],
                                  Results[index][KeyContsants.Artists][0]),
                            ),
                          );
                        },
                        itemCount: Results.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10,
                            width: 10,
                          );
                        },
                      ))
                  : Container(),
              Container(
                margin: EdgeInsets.only(
                    right: Width * 0.7,
                    bottom: Height * 0.02,
                    top: Height * 0.03),
                child: Text(
                  'Artists',
                  style:
                      TextStyle(fontSize: Height * 0.05, color: Colors.white),
                ),
              ),
              Container(
                height: Height * 0.28,
                child: ListView.separated(
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
                        margin: EdgeInsets.only(
                            left: Width * 0.02, right: Width * 0.02),
                        child: ArtistCard(Height, Width, 'abc', 'abc', 'abc'),
                      ),
                    );
                  },
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                      width: 10,
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: Width * 0.5,
                    bottom: Height * 0.02,
                    top: Height * 0.03),
                child: Text(
                  'Top Playlists',
                  style:
                      TextStyle(fontSize: Height * 0.05, color: Colors.white),
                ),
              ),
              Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: Width * 0.01,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>PlayList()) );
                        
                          },
                            child: TopPlaylist("abc", Height, Width)),
                      ),
                      SizedBox(
                        width: Width * 0.01,
                      ),
                      Expanded(
                        child: GestureDetector(
                            child: TopPlaylist("abc", Height, Width)),
                      ),
                      SizedBox(
                        width: Width * 0.02,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Height * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Width * 0.01,
                      ),
                      Expanded(
                        child: GestureDetector(
                            child: TopPlaylist("abc", Height, Width)),
                      ),
                      SizedBox(
                        width: Width * 0.01,
                      ),
                      Expanded(
                        child: GestureDetector(
                            child: TopPlaylist("abc", Height, Width)),
                      ),
                      SizedBox(
                        width: Width * 0.02,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Height * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Width * 0.01,
                      ),
                      Expanded(
                        child: GestureDetector(
                            child: TopPlaylist("abc", Height, Width)),
                      ),
                      SizedBox(
                        width: Width * 0.01,
                      ),
                      Expanded(
                        child: GestureDetector(
                            child: TopPlaylist("abc", Height, Width)),
                      ),
                      SizedBox(
                        width: Width * 0.02,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Height * 0.01,
                  ),
                ],
              )),
              /*Container(
                margin: EdgeInsets.only(
                    right: Width * 0.6,
                    bottom: Height * 0.02,
                    top: Height * 0.03),
                child: Text(
                  'TOP 10 ',
                  style:
                      TextStyle(fontSize: Height * 0.05, color: Colors.white),
                ),
              ),
              Container(
                  height: Height * 0.28,
                  child: ListView.separated(
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
                          margin: EdgeInsets.only(
                              left: Width * 0.02, right: Width * 0.02),
                          child:
                              TopMusicCards(Height, Width, 'abc', 'abc', 'abc'),
                        ),
                      );
                    },
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                        width: 10,
                      );
                    },
                  ))*/
            ]),
          ),
        ),
      ),
    );
  }
}
