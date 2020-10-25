import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('US Stock Name'),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              title: Text('list 1'),
            ),
            ListTile(
              title: Text('list 2'),
            ),
            ListTile(
              title: Text('list 3'),
            ),
          ]
        ),
      ),
    );
  }
}
