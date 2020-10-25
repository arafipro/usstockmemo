import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('US Stock Name'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('New'),
              onPressed: () {}
            ),
            RaisedButton(
              child: Text('Stock List'),
              onPressed: () {}
            ),
          ],
        )
      ),
    );
  }
}
