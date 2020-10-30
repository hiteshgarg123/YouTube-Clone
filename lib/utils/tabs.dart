import 'package:flutter/material.dart';
import 'package:youtube_clone/screens/dummy_screens/Add.dart';
import 'package:youtube_clone/screens/dummy_screens/Explpre.dart';
import 'package:youtube_clone/screens/dummy_screens/Home.dart';
import 'package:youtube_clone/screens/dummy_screens/Library.dart';
import 'package:youtube_clone/screens/dummy_screens/Subscription.dart';

List<Widget> tabs = [
  Home(),
  Explore(),
  Add(),
  Subscription(),
  Library(),
];
var currentIndex = 0;
