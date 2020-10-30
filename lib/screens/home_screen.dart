import 'package:flutter/material.dart';
import 'package:youtube_clone/screens/search_screen.dart';
import 'package:youtube_clone/utils/tabs.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.8,
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/logos/YouTube-banner-logo.jpg",
              height: 32,
            ),
            // Your widgets here
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.grey,
            iconSize: 30,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            ),
            color: Colors.grey,
            iconSize: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
          ),
          CircleAvatar(
            maxRadius: 15,
            backgroundColor: Colors.blueAccent,
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
          ),
        ],
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          // print(index);
          setState(() {
            currentIndex = index;
          });
        },
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 44.0,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions), label: "Subscription"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library_rounded), label: "Library"),
        ],
      ),
    );
  }
}
