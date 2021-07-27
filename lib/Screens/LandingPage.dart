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
  List Artist=["Sonu Nigam","Alka Yagnik","Arijit Singh","Amit Trivedi","Kumar Sanu","Neha Kakkar","Mika Singh"];
  List ArtistImages=["https://s01.sgp1.digitaloceanspaces.com/large/834934-14908-sxnxngdmqb-1492509161.jpg","https://www.bizasialive.com/wp/wp-content/uploads/2021/03/Alka-Yagnik-1200x-696x464.jpg","https://www.bollywoodhungama.com/wp-content/uploads/2021/03/WhatsApp-Image-2021-03-12-at-1.06.08-PM.jpeg","https://static.toiimg.com/thumb/msid-69281268,imgsize-177004,width-800,height-600,resizemode-75/69281268.jpg","https://static.toiimg.com/thumb/msid-83686358,width-1200,height-900,resizemode-4/.jpg","https://upload.wikimedia.org/wikipedia/commons/5/53/Neha_Kakkar_Birthday_Bash.jpg","https://pbs.twimg.com/profile_images/1307987611873468416/6JYIN0F0.jpg"];
  List Genre=["bollywood","party","romance","rock","chill","pop"];
  List  GenreImages=["https://miro.medium.com/max/1024/1*WlEgaw6OMVpsgukTuhjggA.jpeg","https://www.newsilike.in/wp-content/uploads/Mumbai-New-Year-parties.jpg","https://assets.classicfm.com/2019/04/50-greatest-classical-love-songs-1548690655-list-handheld-0.jpg","https://www.roadiemusic.com/blog/wp-content/uploads/2020/02/Is-Rock-Music-Dead.png","https://m.media-amazon.com/images/I/51rOR5HJpWL._SS500_.jpg","https://image.shutterstock.com/image-vector/pop-music-vintage-3d-vector-600w-1427685572.jpg"];
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
                      height: Height * 0.4,
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
                                              [KeyContsants.Artists], Results[index][KeyContsants.Duration])));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>PlayList(1,Artist[index],ArtistImages[index])) );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Width * 0.02, right: Width * 0.02),
                        child: ArtistCard(Height, Width, ArtistImages[index],Artist[index]),
                      ),
                    );
                  },
                  itemCount: Artist.length,
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
                                  builder: (context) =>PlayList(3,Genre[0],GenreImages[0])) );
                        
                          },
                            child: TopPlaylist(GenreImages[0],Genre[0], Height, Width)),
                      ),
                      SizedBox(
                        width: Width * 0.01,
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>PlayList(3,Genre[1],GenreImages[1])) );

                            },
                            child: TopPlaylist(GenreImages[1],Genre[1], Height, Width)),
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
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>PlayList(3,Genre[2],GenreImages[2])) );

                            },
                            child: TopPlaylist(GenreImages[2],Genre[2], Height, Width)),
                      ),
                      SizedBox(
                        width: Width * 0.01,
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>PlayList(3,Genre[3],GenreImages[3])) );

                            },
                            child: TopPlaylist(GenreImages[3],Genre[3], Height, Width)),
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
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>PlayList(3,Genre[4],GenreImages[4])) );

                            },
                            child: TopPlaylist(GenreImages[4],Genre[4], Height, Width)),
                      ),
                      SizedBox(
                        width: Width * 0.01,
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>PlayList(3,Genre[5],GenreImages[5])) );

                            },
                            child: TopPlaylist(GenreImages[5],Genre[5], Height, Width)),
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
