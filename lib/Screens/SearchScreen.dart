import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/CommonWidgets/CommonWidgets.dart';
import 'package:grove_and_move/Constants/KeyConstants.dart';
import 'package:grove_and_move/Screens/MusicScreen.dart';

typedef StringValue = String Function(String);

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }

  bool isSelectable;
  StringValue callback;

  SearchScreen({required this.isSelectable, required this.callback});
}

class _SearchScreen extends State<SearchScreen> {
  String searchQuery = 'Kedarnath';
  String dropdownValue = KeyContsants.SongName;
  Map<String, String> SearchBy = {
    'Song Name': KeyContsants.SongName,
    'Movie Name': KeyContsants.Album,
    'Artist Name': KeyContsants.Artists,
    'Language': KeyContsants.Language
  };
  List Results = [];
  List Data = [];
  var _controller = TextEditingController();
  bool isSearching = false;
  String Message = "Try Searching !!";

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  void fetchAllData() {
    List temp = [];
    FirebaseFirestore.instance
        .collection(KeyContsants.Songs)
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        temp.add(value.docs[i].data());
      }
      setState(() {
        Data.addAll(temp);
      });
    });
  }

  void fetchResults() {
    List temp = [];
    setState(() {
      Results.clear();
      isSearching = true;
    });
    if (dropdownValue == KeyContsants.SongName) {
      for (int i = 0; i < Data.length; i++) {
        if (Data[i][KeyContsants.SongName]
            .toLowerCase()
            .contains(new RegExp(r'' + searchQuery, caseSensitive: false))) {
          temp.add(Data[i]);
          continue;
        }
      }

      setState(() {
        Results.addAll(temp);
        isSearching = false;
        Message = "OOPS TRY AGAIN!";
      });
    } else if (dropdownValue == KeyContsants.Album) {
      for (int i = 0; i < Data.length; i++) {
        for (String name in Data[i][KeyContsants.Album]) {
          if (name
              .toLowerCase()
              .contains(new RegExp(r'' + searchQuery, caseSensitive: false))) {
            temp.add(Data[i]);
            continue;
          }
        }
      }
      setState(() {
        Results.addAll(temp);
        isSearching = false;
        Message = "OOPS TRY AGAIN!";
      });
    } else if (dropdownValue == KeyContsants.Artists) {
      for (int i = 0; i < Data.length; i++) {
        for (String name in Data[i][KeyContsants.Artists]) {
          if (name
              .toLowerCase()
              .contains(new RegExp(r'' + searchQuery, caseSensitive: false))) {
            temp.add(Data[i]);
            continue;
          }
        }
      }
      setState(() {
        Results.addAll(temp);
        isSearching = false;
        Message = "OOPS TRY AGAIN !";
      });
    } else if (dropdownValue == KeyContsants.Language) {
      for (int i = 0; i < Data.length; i++) {
        if (Data[i][KeyContsants.Language]
            .toLowerCase()
            .contains(new RegExp(r'' + searchQuery, caseSensitive: false))) {
          temp.add(Data[i]);
          continue;
        }
      }

      setState(() {
        Results.addAll(temp);
        isSearching = false;
        Message = "OOPS TRY AGAIN!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Data.length > 0 && Data != null
        ? SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: Height,
                color: Colors.black,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Height * 0.1),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                right: Width * 0.6, bottom: Height * 0.04),
                            child: Text("Search",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Height * 0.05)),
                          ),
                          Container(
                              width: Width * 0.8,
                              margin: EdgeInsets.only(left: Width * 0.05),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0) //
                                        ),
                              ),
                              child: TextField(
                                controller: _controller,
                                onChanged: (value) {
                                  searchQuery = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search ',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusColor: Colors.white,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (isSearching) {
                                      } else {
                                        fetchResults();
                                      }
                                      //fetchResults();
                                    },
                                    icon: Icon(Icons.search),
                                  ),
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(right: Width * 0.05),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: Width * 0.1),
                                    child: Text(
                                      'Search By  : ',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: Width * 0.1),
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: const Icon(Icons.arrow_downward),
                                    iconSize: 8,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.green),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.green,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Song Name',
                                      'Movie Name',
                                      'Artist Name',
                                      'Language'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: SearchBy[value],
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*Container(
                    child:ListView.builder(itemBuilder: itemBuilder)
                  ),*/
                          isSearching
                              ? Container(
                                  color: Colors.black,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : Results != null && Results.length > 0
                                  ? Container(
                                      height: 0.56 * Height,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (widget.isSelectable) {
                                                widget.callback(Results[index]
                                                    [KeyContsants.SongName]);
                                              } else
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => MusicScreen(
                                                            Results[index][
                                                                KeyContsants
                                                                    .SongName],
                                                            Results[index][
                                                                KeyContsants
                                                                    .ImageLink],
                                                            Results[index][
                                                                KeyContsants
                                                                    .SongLink],
                                                            Results[index]
                                                                    [KeyContsants.Album]
                                                                [0],
                                                            Results[index][
                                                                KeyContsants
                                                                    .Artists],
                                                            Results[index]
                                                                [KeyContsants.Duration])));
                                            },
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    left: Width * 0.03,
                                                    right: Width * 0.03,
                                                    top: Height * 0.01,
                                                    bottom: Height * 0.02),
                                                child: MusicCards(
                                                    Height,
                                                    Width,
                                                    Results[index][
                                                        KeyContsants.ImageLink],
                                                    Results[index]
                                                        [KeyContsants.SongName],
                                                    Results[index]
                                                        [KeyContsants.Album][0],
                                                    Results[index][KeyContsants
                                                        .Artists]) /*MusicCards2( ImageUrl: Results[index][KeyContsants.ImageLink],Name: Results[index][KeyContsants.SongName] ,MovieName: Results[index][KeyContsants.Album][0]),//,Results[index][KeyContsants.Artists]),//Height, Width*/
                                                ),
                                          );
                                        },
                                        itemCount: Results.length,
                                      ),
                                    )
                                  : Container(
                                      color: Colors.black,
                                      height: Height * 0.56,
                                      child: Center(
                                        child: Text(
                                          Message,
                                          style: TextStyle(
                                              fontSize: Height * 0.03,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container(
            height: Height,
            width: Width,
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
  }
}
