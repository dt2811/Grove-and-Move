import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';

class MusicScreen extends StatefulWidget {
  final String songUrl;
  final String songName,movieName,songImage,albumId;
  // final String[] artist;
  const MusicScreen({Key? key,this.songUrl="",this.songImage="",this.songName="",this.movieName="",this.albumId=""}) : super(key: key);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  Duration position = new Duration();
  String currentCover = "";
  String currentTitle = "";
  String currentSinger = "";
  String du = "0:00";
  String pos = "0:00";
  bool isPlaying = false;
  IconData btnIcon = Icons.pause_circle_filled_rounded;
  AudioPlayer audio = new AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playMusic(widget.songUrl );
    setState(() {
      isPlaying=true;
    position = Duration(minutes: 0);

    });
  }
  void setDuration() {
    setState(() {
      if ((audio.duration.inSeconds % 60) <= 9) {
        du = ((audio.duration.inSeconds / 60).floor().toString() +
            ":0" +
            (audio.duration.inSeconds % 60).toString());
      } else {
        du = ((audio.duration.inSeconds / 60).floor().toString() +
            ":" +
            (audio.duration.inSeconds % 60).toString());
      }
    });
  }

  void setPosition() {
    setState(() {
      if ((position.inSeconds % 60) <= 9) {
        pos = ((position.inSeconds / 60).floor().toString() +
            ":0" +
            (position.inSeconds % 60).toString());
      } else {
        pos = ((position.inSeconds / 60).floor().toString() +
            ":" +
            (position.inSeconds % 60).toString());
      }
    });
  }

  // void playNextSong(int index) {
  //   setState(() {
  //     if (index <= (data.length - 1)) {
  //       //currSong=data[index]["url"];
  //       currentCover = data[index]["cover_url"];
  //       currentSinger = data[index]["singer"];
  //       currentTitle = data[index]["title"];
  //       playMusic(data[index]["url"], index);
  //     } else if (data.length > 0) {
  //       currentCover = data[0]["cover_url"];
  //       currentSinger = data[0]["singer"];
  //       currentTitle = data[0]["title"];
  //       playMusic(data[0]["url"], 0);
  //     }
  //   });
  // }

  // void playPreviousSong(int index) {
  //   setState(() {
  //     if (index >= 0) {
  //       //currSong=data[index]["url"];
  //       currentCover = data[index]["cover_url"];
  //       currentSinger = data[index]["singer"];
  //       currentTitle = data[index]["title"];
  //       playMusic(data[index]["url"], index);
  //     } else if (data.length > 0) {
  //       currentCover = data[data.length - 1]["cover_url"];
  //       currentSinger = data[data.length - 1]["singer"];
  //       currentTitle = data[data.length - 1]["title"];
  //       playMusic(data[data.length - 1]["url"], data.length - 1);
  //     }
  //   });
  // }

    void playMusic(String url)async{   //, int index) async {
    if (isPlaying){ //&& currSong != url) {
      audio.stop();
      setState(() {
        isPlaying = false;
        position = Duration(seconds: 0);
      });
      await audio.play(url);

      setState(() {
        //indexPlaying = index;
        setDuration();
        isPlaying = true;
        btnIcon = Icons.pause;
        //currSong = url;
      });
    } else if (!isPlaying) {
      await audio.play(url);
      setDuration();
      setState(() {
        isPlaying = true;
      });
    }
    audio.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
        setPosition();
        setDuration();
        if (du == pos && du != "0:00") {
          //playNextSong(index + 1);
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Music",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.black,
      // ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.black87,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.160,
            ),
            CircleAvatar(
              radius: (size.width * 0.797) / 2,
              backgroundImage: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/partymusic-5d3b8.appspot.com/o/SongCovers%2FnamoNamo.jpg?alt=media&token=125bad06-c5ce-48d6-919a-2154b6afc823"),
              backgroundColor: Colors.purple,
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            Text(
              "Namo Namo",
              style:
                  TextStyle(color: Colors.white, fontSize: size.height * 0.026),
            ),
            Text(
              "Singer : Amit Trivedi",
              style:
                  TextStyle(color: Colors.grey, fontSize: size.height * 0.019),
            ),
            // Slider(value: 0, onChanged: (value){},inactiveColor: Colors.white,activeColor: Colors.amber,),//position.inSeconds.toDouble()
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
                padding: EdgeInsets.only(left: size.width*0.04,right: size.width*0.04),
                child: Slider(
                    inactiveColor: Colors.grey[500],
                    activeColor: Colors.white,
                    value: position.inSeconds.toDouble(),
                    min: 0.0,
                    max: audio.duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      audio.seek(value);
                    })),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pos,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    du,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: size.width*0.12,),
                IconButton(
                  onPressed: () {
                    // playPreviousSong(indexPlaying - 1);
                  },
                  icon: Icon(Icons.skip_previous_rounded),
                  iconSize: size.height*0.06,color: Colors.white,
                ),
                IconButton(
                  iconSize: size.height*0.1,
                  icon: Icon(btnIcon),
                  color: Colors.white,
                  onPressed: () {
                    if (isPlaying) {
                      audio.pause();
                      setState(() {
                        isPlaying = false;
                        btnIcon = Icons.play_circle_filled_rounded;
                      });
                    } else {
                      audio.play(widget.songUrl);
                      btnIcon = Icons.pause_circle_filled_rounded;
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                ),
                IconButton(
                  onPressed: () {
                    // playNextSong(indexPlaying + 1);
                  },
                  color: Colors.white,
                  icon: Icon(Icons.skip_next_rounded),
                  iconSize: size.height*0.06,
                ),
                SizedBox(width: size.width*0.12,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
