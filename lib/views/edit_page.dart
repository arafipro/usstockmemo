import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  List<String> _markets = ["NYSE", "NASDAQ"];
  String dropdownValue = "NYSE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('US Stock Name Edit'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Stock Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Ticker',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '    Market',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),
              ),
              ListTile(
                subtitle: DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    dropdownValue = newValue;
                    print(dropdownValue);
                  },
                  items: _markets.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
