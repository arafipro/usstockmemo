import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('US Stock Name List'),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              title: Text('name 1 (ticker 1)'),
              subtitle: Text('createdAt'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                ],
              ),
            ),
            ListTile(
              title: Text('name 2 (ticker 2)'),
              subtitle: Text('market 2'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                ],
              ),
            ),
            ListTile(
              title: Text('name 3 (ticker 3)'),
              subtitle: Text('market 3'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
