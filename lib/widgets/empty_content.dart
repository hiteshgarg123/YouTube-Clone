import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Nothing Here',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 45.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'To be implemented',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}
