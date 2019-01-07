import 'package:flutter/material.dart';
import 'package:swipe_actions/swipe_actions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Action Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SwipeActionExample(),
    );
  }
}

class SwipeActionExample extends StatefulWidget {
  @override
  _SwipeActionExampleState createState() => _SwipeActionExampleState();
}

class _SwipeActionExampleState extends State<SwipeActionExample> {
  List<int> _counts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Actions Example"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    height: 0,
                    color: Colors.black,
                  ),
              itemCount: _counts.length,
              itemBuilder: (context, i) => Swipe(
                    child: ListTile(
                      title: Text("Counter $i"),
                      trailing: CircleAvatar(
                        child: Text(_counts[i].toString()),
                      ),
                    ),
                    menuItems: <SwipeAction>[
                      SwipeAction(
                        icon: Icons.add,
                        onSelect: () {
                          setState(() {
                            _counts[i]++;
                          });
                        },
                        highlighColor: Colors.green,
                      ),
                      SwipeAction(
                        icon: Icons.remove,
                        onSelect: () {
                          setState(() {
                            _counts[i]--;
                          });
                        },
                        highlighColor: Colors.red,
                      ),
                      SwipeAction(
                        icon: Icons.open_in_new,
                        onSelect: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scaffold(
                                      appBar: AppBar(
                                        title: Text("Counter $i"),
                                      ),
                                      body: Center(
                                          child: Text(
                                        _counts[i].toString(),
                                        style: TextStyle(fontSize: 100),
                                      )),
                                    )),
                          );
                        },
                        highlighColor: Colors.yellow,
                      )
                    ],
                  ),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
