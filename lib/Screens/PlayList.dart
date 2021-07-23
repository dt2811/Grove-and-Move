import 'package:flutter/material.dart';
import 'package:grove_and_move/CommonWidgets/CommonWidgets.dart';
class PlayList extends StatefulWidget {
  final String playListLink,name;
  const PlayList({ Key? key ,this.playListLink="",this.name=""}) : super(key: key);

  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String playListLink = widget.playListLink;
    String name = widget.name;
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        child:Column(
          children: [
            SizedBox(height: 79,),
            playListLink!=null?CircleAvatar(
              radius: size.height*0.15,
              backgroundImage: NetworkImage(playListLink),
            ):Container(),
            Text(name,style: TextStyle(color: Colors.white,fontSize: size.height*0.03),),
            Container(
                    height: size.height*0.5,
                    child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>MusicScreen(Results[index][KeyContsants.SongName], Results[index][KeyContsants.ImageLink], Results[index][KeyContsants.SongLink],Results[index][KeyContsants.Album][0],Results[index][KeyContsants.Artists],"308")) );
                        // },
                        child: Container(
                          // margin: EdgeInsets.only(
                              // left: Width * 0.03, right: Width * 0.03,top: Height*0.01,bottom: Height*0.02),
                          child:MusicCards(Name: "ABD",ImageUrl: "https://via.placeholder.com/150",MovieName: "ABCD"), //MusicCards( ImageUrl: Results[index][KeyContsants.ImageLink],Name: Results[index][KeyContsants.SongName] ,MovieName: Results[index][KeyContsants.Album][0]),//,Results[index][KeyContsants.Artists]),//Height, Width
            
                        ),
                      );
                    },
                    itemCount: 4//Results.length,

                  ),)
            // MusicCards(Name: "ABD",ImageUrl: "https://via.placeholder.com/150",MovieName: "ABCD"),
          ],
        ),
      ),
    );
  }
}