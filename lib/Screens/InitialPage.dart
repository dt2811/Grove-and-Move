import 'package:flutter/material.dart';
import 'package:grove_and_move/CommonWidgets/ArtistList.dart';
import 'package:grove_and_move/CommonWidgets/MusicDetails.dart';
import 'package:grove_and_move/CommonWidgets/PlayListItem.dart';

// ignore: non_constant_identifier_names
class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int itemCount = 5;//random value
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Recommended for today",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                height: size.height*0.24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (context, item) => MusicDetails(
                      link: "https://via.placeholder.com/150",
                      singer: "Arijit Singh",
                      songName: "Shayad",
                    )),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Top Artist",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: size.height*0.24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (context, item) => ArtistList(
                      link: 'https://via.placeholder.com/150',
                      name: "Sonu Nigam",
                    )),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Recommended Playlist",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                height: size.height*0.237,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (context, item) => PlayListItem(
                      name: "Bandish Bandit",
                      singer: "Shankar-Esaan",
                      link:"https://via.placeholder.com/150",
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
