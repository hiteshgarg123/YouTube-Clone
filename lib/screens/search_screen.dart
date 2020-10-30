import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    dataController.addListener(() => getData());
  }

  @override
  void dispose() {
    super.dispose();
    dataController.dispose();
  }

  Future<void> getData() async {
    var res = await http.get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&q=$searchQuery&type=video&key=$APIkey",
    );
    var jsonData = jsonDecode(res.body);
    setState(() {
      post = Post.fromJson(jsonData);
    });
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
                setState(() {
                  searchQuery = data;
                });
              },
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                searchQuery = dataController.text;
              });
            },
          )
        ],
      ),
      body: searchQuery.length > 3
          ? ListView.builder(
              itemCount: post.items.length,
              itemBuilder: (context, index) => SearchVideoCard(
                channelName: "${post.items[index].snippet.channelTitle}",
                thumbnail: "${post.items[index].snippet.thumbnails.high.url}",
                title: "${post.items[index].snippet.title}",
                uploadTime: "${post.items[index].snippet.publishTime}",
                description: "${post.items[index].snippet.description}",
                videoId: "${post.items[index].id.videoId}",
              ),
            )
          : Container(),
    );
  }
}
