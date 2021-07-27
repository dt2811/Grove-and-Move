import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grove_and_move/FirebaseHelper/firebaseHelper.dart';
import 'package:grove_and_move/utils/MusicPlayer.dart';

import 'Home.dart';
import 'RoomPageHost.dart';

class RoomPageAttendee extends StatefulWidget {
  String code;

  RoomPageAttendee({required this.code});

  @override
  _RoomPageAttendeeState createState() => _RoomPageAttendeeState();
}

class _RoomPageAttendeeState extends State<RoomPageAttendee> {
  String songLink = "",
      songName = "",
      songImage = "",
      movieName = "",
      duration = "5000",
      songId="";
  List artist = [];
  FireBaseHelper fireBaseHelper = new FireBaseHelper();
  bool _isDeleting = false;
  bool _isChanging = false;
  IconData btnIcon = Icons.play_circle_filled_rounded;
  MusicPlayer player = new MusicPlayer();
  bool isPlaying = false;
  bool initialPlay = false;
  Duration currentPosition = Duration(seconds: 0);
  User? mUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return StreamBuilder<DocumentSnapshot>(
      stream: fireBaseHelper.roomDetails(widget.code),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          List participants = [];
          if (!_isDeleting) {
            participants = snapshot.data!.get('people');
            if (songId != snapshot.data!.get('currentSong')) {
              fetchSongDetails(snapshot.data!.get('currentSong'));
            }
            if (snapshot.data!.get('isPaused') && songLink.isNotEmpty) {
              if (!initialPlay) {
                currentPosition =
                    Duration(seconds: snapshot.data!.get('timestamp'));
                playMusic(currentPosition.inSeconds.toDouble());
                player.pause();
                initialPlay = true;
              } else {
                if (isPlaying) player.pause();
              }
            } else if (!snapshot.data!.get('isPaused') && songLink.isNotEmpty) {
              if (initialPlay && !isPlaying) {
                print("CALLED");
                player.resume();
              }
            }
          }

          if (snapshot.data!.get('admin') == mUser!.uid && !_isChanging) {
            _isChanging = true;
            fireBaseHelper.leaveRoom(widget.code);
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomPageHost(
                    code: widget.code,
                  ),
                ),
              );
            });
          }
          if (!participants.contains(mUser!.uid) &&
              !_isChanging &&
              !_isDeleting) {
            _isDeleting = true;
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          }
          return _isDeleting
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    right: 16.0,
                  ),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.green,
                    ),
                    strokeWidth: 3,
                  ),
                )
              : Scaffold(
                  body: SafeArea(
                    child: Container(
                      height: double.infinity,
                      color: Colors.black,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right: Width * 0.4,
                                  bottom: Height * 0.02,
                                  top: Height * 0.02),
                              child: Text(
                                'Room Code: ' + snapshot.data!.get("code"),
                                style: TextStyle(
                                    fontSize: Height * 0.05,
                                    color: Colors.white),
                              ),
                            ),
                            Visibility(
                              child: Text(
                                'No Song Selected',
                                style: TextStyle(
                                    fontSize: Height * 0.03,
                                    color: Colors.white),
                              ),
                              visible: songLink.isEmpty,
                            ),
                            Visibility(
                              visible: songLink.isNotEmpty,
                              child: Column(
                                children: [
                                  songImage.isNotEmpty
                                      ? CircleAvatar(
                                          radius: size.height * 0.25,
                                          backgroundImage:
                                              NetworkImage(songImage),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: size.height * 0.027,
                                  ),
                                  songName.isNotEmpty
                                      ? Container(
                                          child: Text(
                                            songName,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.height * 0.026),
                                          ),
                                        )
                                      : Container(),
                                  movieName.isNotEmpty
                                      ? Container(
                                          child: Text(
                                            "Movie Name: ${movieName}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: size.height * 0.019),
                                          ),
                                        )
                                      : Container(),
                                  artist.isNotEmpty
                                      ? Container(
                                          child: Text(
                                            "Singer : ${artist.toString()}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: size.height * 0.019),
                                          ),
                                        )
                                      : Container(),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.04,
                                        right: size.width * 0.04),
                                    child: Slider(
                                        inactiveColor: Colors.grey[500],
                                        activeColor: Colors.white,
                                        value: currentPosition.inSeconds
                                            .toDouble(),
                                        min: 0.0,
                                        max: double.parse(duration),
                                        onChanged: (value) {
                                          slideToChangeTime(value);
                                        }),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 40, right: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.12,
                                        ),
                                        Icon(
                                          (btnIcon),
                                          size: size.height * 0.1,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red,
                                ),
                                margin: EdgeInsets.only(
                                    left: 8, right: 8, bottom: 12, top: 8),
                                padding: EdgeInsets.all(14),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Leave Room",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  _isDeleting = true;
                                });
                                player.stop();
                                FireBaseHelper fireBaseHelper =
                                    new FireBaseHelper();
                                fireBaseHelper.leaveRoom(widget.code);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.green,
            ),
          ),
        );
      },
    );
  }

  Future<void> fetchSongDetails(String name) async {
    if (name != songName && name.isNotEmpty)
      await fireBaseHelper.firestore
          .collection('Songs')
          .doc(name)
          .get()
          .then((value) {
        songName = value.get('song_name');
        songId=value.get('song_id');
        movieName = value.get('album')[0];
        artist = value.get('artists');
        songImage = value.get('image_link');
        songLink = value.get('song_link');
        duration = '328';
      });
  }

  void playMusic(double value) async {
    PlayerState status = await player.getStatus();
    if (status != PlayerState.STOPPED) {
      player.stop();
    }

    isPlaying = await player.playNewSong(songLink, new Duration(seconds: value.toInt()));
    if (isPlaying) {
      changeProgressBarInRealTime();
      onMusicStateChange();
    } else {
      print('error');
    }
  } //function to play music.

  void changeProgressBarInRealTime() {
    if (isPlaying) {
      MusicPlayer.audioPlayer.onAudioPositionChanged.listen((Duration p) {
        progressBarChange(p.inSeconds.toDouble());
      });
    }
  } // function to progress bar automatically in background.

  void slideToChangeTime(double value) async {
    player.stop();

    bool isChanged = await player.playNewSong(
        songLink, new Duration(seconds: value.toInt()));
    if (isChanged) {
      //player.pause();
      onMusicStateChange();
      progressBarChange(value);
    } else {
      print('change');
    }
  } // function to change music time.

  void onMusicStateChange() {
    MusicPlayer.audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (s == PlayerState.PAUSED ||
          s == PlayerState.STOPPED ||
          s == PlayerState.COMPLETED) {
        IconChange(true);

      } else if (s == PlayerState.PLAYING) {
        IconChange(false);
      }
    });
  } // function to change play and paused button based on music player status.

  void progressBarChange(double value) {
    if (this.mounted) {
      setState(() {
        currentPosition = Duration(seconds: value.toInt());
      });
    }
  } // function to change progress bar position.

  void IconChange(bool i) {
    if (this.mounted) {
      if (i) {
        setState(() {
          isPlaying = false;
          btnIcon = Icons.play_circle_filled_rounded;
        });
      } else {
        setState(() {
          btnIcon = Icons.pause_circle_filled_rounded;
          isPlaying = true;
        });
      }
    }
  } // function to change icons

  String conversion(Duration p) {
    if (p.inMinutes > 0) {
      if ((p.inSeconds % 60) >= 10) {
        return p.inMinutes.toString() + " : " + (p.inSeconds % 60).toString();
      } else {
        return p.inMinutes.toString() + " : 0" + (p.inSeconds % 60).toString();
      }
    } else {
      if (p.inSeconds >= 10) {
        return "00" + " : " + (p.inSeconds % 60).toString();
      } else {
        return "00" + " : 0" + (p.inSeconds % 60).toString();
      }
    }
  } // function to convert seconds to minutes.
  /*@override
  void dispose() {
    super.dispose();
    player.stop();
  }*/

  String convertStringDuration(String Duration) {
    int d = int.parse(Duration);
    if (d / 60 > 0) {
      if (d % 60 >= 10) {
        return (d / 60).floor().toString() + " : " + (d % 60).toString();
      } else {
        return (d / 60).floor().toString() + " : 0" + (d % 60).toString();
      }
    } else {
      if (d >= 10) {
        return "00" + " : " + (d % 60).toString();
      } else {
        return "00" + " : 0" + (d % 60).toString();
      }
    }
  }
}
