import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_clone/models/Post.dart';
import 'package:youtube_clone/utils/api_key.dart';
import 'package:youtube_clone/widgets/search_videos_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';
  TextEditingController dataController = TextEditingController();
  Post post;
  ConnectivityResult connectivityResult;

  @override
  void initState() {
    super.initState();
    dataController.addListener(() => getData());
    checkConnectivityStatus();
  }

  @override
  void dispose() {
    super.dispose();
    dataController.dispose();
  }

  checkConnectivityStatus() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  Future<void> getData() async {
    checkConnectivityStatus();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var res = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&q=$searchQuery&type=video&key=$APIkey",
      );
      var jsonData = jsonDecode(res.body);
      if (mounted) {
        setState(() {
          post = Post.fromJson(jsonData);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.8,
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Builder(
            builder: (context) => TextField(
                controller: dataController,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                onSubmitted: (data) {
                  if (mounted) {
                    setState(() {
                      searchQuery = data;
                    });
                  }
                },
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                }),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (mounted) {
                setState(() {
                  searchQuery = dataController.text;
                });
              }
            },
          )
        ],
      ),
      body: searchQuery.length > 3
          ? connectivityResult == ConnectivityResult.none
              ? Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    child: Text(
                      'Internet connection not available',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: post.items.length,
                  itemBuilder: (context, index) => SearchVideoCard(
                    channelName: "${post.items[index].snippet.channelTitle}",
                    thumbnail:
                        "${post.items[index].snippet.thumbnails.high.url}",
                    title: "${post.items[index].snippet.title}",
                    uploadTime: "${post.items[index].snippet.publishTime}",
                    description: "${post.items[index].snippet.description}",
                    videoId: "${post.items[index].id.videoId}",
                  ),
                )
          : Container(
              //margin: EdgeInsets.only(left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height * 0.1,
              margin: EdgeInsets.only(left: 30.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/logos/YouTube-logo.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                  SizedBox(
                    width: 7.0,
                  ),
                  Text('Type to search YouTube'),
                ],
              ),
            ),
    );
  }
}
