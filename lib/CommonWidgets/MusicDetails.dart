import 'package:flutter/material.dart';

class MusicDetails extends StatelessWidget {
  final String songName;
  final String singer;
  final String link;
  const MusicDetails(
      {Key? key, this.songName = "", this.singer = "", this.link = ""})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: size.height * 0.177,
          height: size.height * 0.177,
          margin: EdgeInsets.only(right: 3, left: 14),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(link), fit: BoxFit.cover)),
        ),
        Text(
          "Song Name: "+songName,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Singer: "+singer,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        )
      ],
    );
  }
}
