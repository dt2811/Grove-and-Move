import 'package:audioplayers/audioplayers.dart';

class MusicPlayer{
 static  AudioPlayer audioPlayer = AudioPlayer();

  Future<bool> playNewSong(String url,Duration pos) async {
    audioPlayer.stop();
    int result = await audioPlayer.play(url,position: pos);
    if (result == 1) {
      return true;
    }
    else{
      return false;
    }
  }// function to play new music or move forward to a music

  Future<bool> pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      return true;
    }
    else{
      return false;
    }
  } // function to pause a music

  Future<bool> resume() async {
    int result = await audioPlayer.resume();
    if (result == 1) {
      return true;
    }
    else{
      return false;
    }
  } // function to resume a paused music

 Future<bool> stop() async {
   int result = await audioPlayer.stop();
   if (result == 1) {
     return true;
   }
   else{
     return false;
   }
 } // function to stop a playing music

 Future<PlayerState> getStatus () async{
   PlayerState status=PlayerState.STOPPED;
 await audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
  status=s;
 });
 if(status==null){
   return PlayerState.STOPPED;
 }
 else{
   return status;
 }
}// function to get status of a music player.

Future<Duration> getDuration() async {
    Duration dur=Duration(seconds: 0);
   await  audioPlayer.onAudioPositionChanged.listen((Duration  p) {
      dur=p;
    });
    if(dur.inSeconds!=0) {
      return dur;
    }
    else{
      return dur;
    }
  } //function to get current duration of a music.



}