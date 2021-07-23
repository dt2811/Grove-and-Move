import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/utils/MusicPlayer.dart';


class MusicScreen extends StatefulWidget {
 String songLink,songName,songImage,movieName,duration;
 
 List artist=[];
 MusicScreen(this.songName,this.songImage,this.songLink,this.movieName,this.artist,this.duration);

  @override
  _MusicScreenState createState() => _MusicScreenState(this.songName,this.songImage,this.songLink,this.movieName,this.artist,this.duration);
}

class _MusicScreenState extends State<MusicScreen> {
  String songLink,songName,songImage,movieName,duration;
  List artist=[];

  _MusicScreenState(this.songName,this.songImage,this.songLink,this.movieName,this.artist,this.duration);

  IconData btnIcon = Icons.pause_circle_filled_rounded;
  MusicPlayer player=new MusicPlayer();
  bool isPlaying=false;
  Duration currentPosition =Duration(seconds: 0);
  @override
  void initState()  {
    super.initState();
    if(songLink!=null){
     playMusic();
    }
  }
  void playMusic() async{
  PlayerState status=await player.getStatus();
    if(status!=PlayerState.STOPPED){
      player.stop();
    }

    isPlaying= await player.playNewSong(songLink,new Duration(seconds: 0));
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

    bool isChanged=await player.playNewSong(songLink,new Duration(seconds: value.toInt()));
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
        return p.inMinutes.toString() + ":"+(p.inSeconds%60).toString();}
      else{
        return p.inMinutes.toString() +":0"+(p.inSeconds%60).toString();
      }
    }
    else {
      if(p.inSeconds>=10){
        return "0"+":"+(p.inSeconds%60).toString();}
      else{
        return "0" +":0"+(p.inSeconds%60).toString();
      }
    }
  } // function to convert seconds to minutes.
  /*@override
  void dispose() {
    super.dispose();
    player.stop();
  }*/

  String convertStringDuration(String Duration){
    int d=int.parse(Duration);
    if(d/60>0){
      if(d%60>=10){
        return (d/60).floor().toString() + ":"+(d%60).toString();}
      else{
        return (d/60).floor().toString() +":0"+(d%60).toString();
      }
    }
    else {
      if(d>=10){
        return "0"+":"+(d%60).toString();}
      else{
        return "0" +":0"+(d%60).toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child:Container(
          padding:EdgeInsets.only(top:size.height*0.05),
        color: Colors.black87,
        child: Column(
          children: [
            songImage!=null?CircleAvatar(
              radius: size.height*0.25,
              backgroundImage: NetworkImage(songImage),
            ):Container(),
            SizedBox(
              height: size.height * 0.027,
            ),
            songName!=null?Container(
              child:Text(
              songName,
              style:
                  TextStyle(color: Colors.white, fontSize: size.height * 0.026),
            ),):Container(),
            movieName!=null?Container(child:Text(
              "Movie Name: ${movieName}",
              style:
              TextStyle(color: Colors.grey, fontSize: size.height * 0.019),
            ),):Container(),
            artist!=null?Container(child:Text(
              "Singer : ${artist.toString()}",
              style:
                  TextStyle(color: Colors.grey, fontSize: size.height * 0.019),
            ),):Container(),

            Container(
                padding: EdgeInsets.only(left: size.width*0.04,right: size.width*0.04),
                child: Slider(
                    inactiveColor: Colors.grey[500],
                    activeColor: Colors.white,
                    value: currentPosition.inSeconds.toDouble(),
                    min: 0.0,
                    max: double.parse(duration),
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
                    convertStringDuration(duration),
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
    )
    );
  }
}
