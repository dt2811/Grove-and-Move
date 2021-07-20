import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/utils/MusicPlayer.dart';


class MusicScreen extends StatefulWidget {
  final String songUrl;
  final String songName,movieName,songImage,albumId;
  const MusicScreen({Key? key,this.songUrl="",this.songImage="",this.songName="",this.movieName="",this.albumId=""}) : super(key: key);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {

  IconData btnIcon = Icons.pause_circle_filled_rounded;
  MusicPlayer player=new MusicPlayer();
  bool isPlaying=false;
  Duration duration= Duration(seconds: 328);
  Duration currentPosition =Duration(seconds: 0);
  @override
  void initState()  {
    super.initState();
     playMusic();
  }
  void playMusic() async{
  PlayerState status=await player.getStatus();
    if(status!=PlayerState.STOPPED){
      player.stop();
    }

    isPlaying= await player.playNewSong("https://firebasestorage.googleapis.com/v0/b/partymusic-5d3b8.appspot.com/o/Music%2FAA%20Namo%20Namo.mp3?alt=media&token=c3dd9182-20a2-45d7-9be9-3724426b76ee",new Duration(seconds: 0));
    if(isPlaying){
     changeProgressBarInRealTime();
     onMusicStateChange();
    }
    else{
      print('error');
    }
  }//function to play music.

  void changeProgressBarInRealTime() {
    if(isPlaying){
    MusicPlayer.audioPlayer.onAudioPositionChanged.listen((Duration  p)  {
     progressBarChange(p.inSeconds.toDouble());
    });}
  }// function to progress bar automatically in background.

  void slideToChangeTime (double value) async{
   player.stop();

    bool isChanged=await player.playNewSong("https://firebasestorage.googleapis.com/v0/b/partymusic-5d3b8.appspot.com/o/Music%2FAA%20Namo%20Namo.mp3?alt=media&token=c3dd9182-20a2-45d7-9be9-3724426b76ee",new Duration(seconds: value.toInt()));
    if(isChanged){
      onMusicStateChange();
     progressBarChange(value);
    }
    else{
      print('change');
    }
  }// function to change music time.

  void onMusicStateChange(){
    MusicPlayer.audioPlayer.onPlayerStateChanged.listen((PlayerState s)  {
     if(s==PlayerState.PAUSED||s==PlayerState.STOPPED||s==PlayerState.COMPLETED){
        IconChange(true);
     }
     else if(s==PlayerState.PLAYING){
       IconChange(false);
     }
  });
  }// function to change play and paused button based on music player status.

  void progressBarChange(double value){
    if(this.mounted){
      setState(() {
        currentPosition=Duration(seconds: value.toInt());
      });
    }
  }// function to change progress bar position.
  void IconChange(bool i){
    if(this.mounted){
    if(i){
    setState(() {
      isPlaying = false;
      btnIcon = Icons.play_circle_filled_rounded;
    });}
    else{
      setState(() {
        btnIcon = Icons.pause_circle_filled_rounded;
        isPlaying=true;
      });
    }
    }
  }// function to change icons

  String conversion(Duration p) {
    if(p.inMinutes>0){
      if((p.inSeconds%60)>=10){
        return p.inMinutes.toString() + " : "+(p.inSeconds%60).toString();}
      else{
        return p.inMinutes.toString() +" : 0"+(p.inSeconds%60).toString();
      }
    }
    else {
      if(p.inSeconds>=10){
        return "00"+" : "+(p.inSeconds%60).toString();}
      else{
        return "00" +" : 0"+(p.inSeconds%60).toString();
      }
    }
  } // function to convert seconds to minutes.
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.160,
            ),
            CircleAvatar(
              radius: size.height*0.25,
              backgroundImage: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/partymusic-5d3b8.appspot.com/o/SongCovers%2FnamoNamo.jpg?alt=media&token=125bad06-c5ce-48d6-919a-2154b6afc823"),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            Container(
              child:Text(
              "Namo Namo",
              style:
                  TextStyle(color: Colors.white, fontSize: size.height * 0.026),
            ),),
            Container(child:Text(
              "Singer : Amit Trivedi",
              style:
                  TextStyle(color: Colors.grey, fontSize: size.height * 0.019),
            ),),
            Container(
                padding: EdgeInsets.only(left: size.width*0.04,right: size.width*0.04),
                child: Slider(
                    inactiveColor: Colors.grey[500],
                    activeColor: Colors.white,
                    value: currentPosition.inSeconds.toDouble(),
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      slideToChangeTime(value);
                    }
                ),),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    conversion(currentPosition),
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    conversion(duration),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child:Row(
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
                  onPressed: () async {
                    if (isPlaying) {
                      player.pause();
                    }
                    else {
                      player.resume();
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
            ),),
          ],
        ),
      ),
    );
  }
}
