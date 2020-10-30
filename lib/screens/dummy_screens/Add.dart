import 'package:flutter/material.dart';
import 'package:youtube_clone/widgets/empty_content.dart';

class Add extends StatefulWidget {
  Add({Key key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return EmptyContent();
  }
}
