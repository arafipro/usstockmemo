import 'package:flutter/material.dart';
import 'package:usstock_name/views/edit_page.dart';
import 'package:usstock_name/views/list_page.dart';

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditPage()),
                );
              }
            ),
            RaisedButton(
              child: Text('Stock List'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListPage()),
                );
              }
            ),
          ],
        )
      ),
    );
  }
}
