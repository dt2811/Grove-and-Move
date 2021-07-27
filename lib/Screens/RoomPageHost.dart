import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/FirebaseHelper/firebaseHelper.dart';
import 'package:grove_and_move/Screens/ChooseSong.dart';
import 'package:grove_and_move/Screens/Home.dart';
import 'package:grove_and_move/Screens/RoomPageAttendee.dart';
import 'package:grove_and_move/Screens/SearchScreen.dart';
import 'package:grove_and_move/utils/MusicPlayer.dart';

class RoomPageHost extends StatefulWidget {
  String code;

  RoomPageHost({required this.code});

  @override
  _RoomPageHostState createState() => _RoomPageHostState();
}

class _RoomPageHostState extends State<RoomPageHost> {
  String songLink = "",
      songName = "",
      songImage = "",
      movieName = "",
      duration = "0",
      songId="";
  List artist = [];
  FireBaseHelper fireBaseHelper = new FireBaseHelper();
  bool _isDeleting = false;
  bool _viewParticipants = false;
  IconData btnIcon = Icons.pause_circle_filled_rounded;
  MusicPlayer player = new MusicPlayer();
  bool isPlaying = false;
  bool initialPlay=false;
  Duration currentPosition = Duration(seconds: 0);
  List names= [];
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
            if (names.length < participants.length) {
              for (int i = names.length; i < participants.length; i++) {
                getNameFromId(participants[i]);
              }
            }
            if (songId != snapshot.data!.get('currentSong')) {
              fetchSongDetails(snapshot.data!.get('currentSong'));
            }

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right: Width * 0.4,
                                  bottom: Height * 0.02,
                                  top: Height * 0.02),
                              child: Text(
                                'Room Code: ' + snapshot.data!.get("code"),
                                style: TextStyle(
                                    fontSize: Height * 0.04,
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
                                          print("Changes");
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
                                        IconButton(
                                          onPressed: () {
                                            // playPreviousSong(indexPlaying - 1);
                                          },
                                          icon:
                                              Icon(Icons.skip_previous_rounded),
                                          iconSize: size.height * 0.06,
                                          color: Colors.white,
                                        ),
                                        IconButton(
                                          iconSize: size.height * 0.1,
                                          icon: Icon(btnIcon),
                                          color: Colors.white,
                                          onPressed: () async {
                                            if(!initialPlay){
                                              playMusic();
                                              initialPlay=true;
                                              IconChange(false);
                                            } else {
                                              if (isPlaying) {
                                                player.pause();
                                              } else {
                                                player.resume();
                                              }
                                            }
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // playNextSong(indexPlaying + 1);
                                          },
                                          color: Colors.white,
                                          icon: Icon(Icons.skip_next_rounded),
                                          iconSize: size.height * 0.06,
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
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8, top: 8),
                                padding: EdgeInsets.all(14),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Search Song",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChooseSong(
                                      callback: (value) {
                                        fireBaseHelper.firestore.collection("rooms").doc(widget.code).update(
                                            {'currentSong':value}).then((value) => print("added")).catchError((error) => print("Failed: $error"));
                                        currentPosition=Duration(seconds: 0);
                                        player.stop();
                                        IconChange(true);
                                        initialPlay=false;
                                        return "";
                                      },

                                    ),
                                  ),
                                );
                              },
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white54,
                                ),
                                margin: EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8, top: 8),
                                padding: EdgeInsets.all(14),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Participants (" +
                                          participants.length.toString() +
                                          ")",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    _viewParticipants
                                        ? Icon(
                                            Icons.arrow_drop_up,
                                          )
                                        : Icon(
                                            Icons.arrow_drop_down,
                                          )
                                  ],
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  _viewParticipants = !_viewParticipants;
                                });
                              },
                            ),
                            Visibility(
                              child: Container(
                                height: (participants.length * 70 > 300)
                                    ? 300
                                    : participants.length * 70,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              bottom: 5,
                                              top: 5),
                                          padding: EdgeInsets.all(14),
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                (names[index]!=null)
                                                    ? names[index]
                                                    : "Loading",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              PopupMenuButton<int>(
                                                padding:
                                                    EdgeInsets.only(bottom: 20),
                                                icon: Icon(
                                                  Icons.more_horiz,
                                                  color: Colors.white,
                                                ),
                                                color: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem<int>(
                                                      value: 0,
                                                      child: Text(
                                                        "Make Host",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                  PopupMenuItem<int>(
                                                      value: 1,
                                                      child: Text("Kick",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                ],
                                                onSelected: (item) =>
                                                    SelectedItem(
                                                        context,
                                                        item,
                                                        widget.code,
                                                        participants[index]),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                  itemCount: participants.length,
                                ),
                              ),
                              visible: _viewParticipants,
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
                                      "End Room",
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
                                fireBaseHelper.deleteRoom(widget.code);
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

  Future<void> getNameFromId(String id) async {

    await fireBaseHelper.firestore
        .collection('users')
        .doc(id)
        .get()
        .then((value) { names.add(value.get('name'));});
  }

  Future<void> updateIsPaused(bool isPaused) async {
    Map<String,dynamic> map= new HashMap();
    map['isPaused']=isPaused;
    if(isPaused) map['timestamp']=currentPosition.inSeconds;
    await fireBaseHelper.firestore.collection("rooms").doc(widget.code).update(
        map).then((value) => print("pausechange")).catchError((error) => print("Failed: $error"));

  }

  void SelectedItem(BuildContext context, item, String code, String id) async {
    switch (item) {
      case 0:
        print("Host Clicked");
        await fireBaseHelper.changeHost(code, id);
        await fireBaseHelper.joinRoom(code);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RoomPageAttendee(code: code),
          ),
        );

        break;
      case 1:
        print("Kick Clicked");
        await fireBaseHelper.removeFromRoom(code, id);
        break;
    }
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

  void playMusic() async {
    PlayerState status = await player.getStatus();
    if (status != PlayerState.STOPPED) {
      player.stop();
    }

    isPlaying = await player.playNewSong(songLink, new Duration(seconds: 0));
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
      player.pause();
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
        updateIsPaused(true);
        IconChange(true);

      } else if (s == PlayerState.PLAYING) {
        updateIsPaused(false);
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
