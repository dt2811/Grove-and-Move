import 'package:flutter/material.dart';

class ArtistList extends StatelessWidget {
  final String link;
  final String name;
  // const ArtistList({Key? key}) : super(key: key);
  ArtistList({this.link='https://via.placeholder.com/150',this.name=""});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(width: 19,),
            CircleAvatar(
              radius: (size.height * 0.177) / 2,
              backgroundImage: NetworkImage(link),
              backgroundColor: Colors.purple,
            ),
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
