import 'package:flutter/material.dart';

class PlayListItem extends StatelessWidget {
  final String name;
  final String singer;
  final String link;
  const PlayListItem(
      {Key? key, this.name = "", this.singer = "", this.link = ""})
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
          name,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Album by:" + singer,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        )
      ],
    );
  }
}
