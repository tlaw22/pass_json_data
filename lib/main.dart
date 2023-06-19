import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Load data from JSON into GUI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Load data from JSON into GUI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _items = [];
  int _counter = 0;

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString("assets/sample.json");
    final data = await jsonDecode(response);
    setState(() {
      _items = data["items"];
      print(".. number of item: ${_items.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemCount: _items.length, itemBuilder: (BuildContext context, int index){
              return Card(
                key: ValueKey(_items[index]["id"]),
                margin: EdgeInsets.all(10),
                color: Colors.indigo,
                child: ListTile(textColor: Colors.white,
                    leading: Text(_items[index]["id"]),
                    title: Text(_items[index]["name"]),
                    subtitle: Text(_items[index]["description"])
                ),
              );
            }),
          ),
        ],
      ),
      bottomSheet:
      Container(
        height: 100,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            readJson();
          },
          child: const Text('Load Json'),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
