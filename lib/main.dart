import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    EditPage(),
    //PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.create),
            title: Text('Edit balance'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('Statistic'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text('Profile'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

class EditPage extends StatelessWidget {
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2030));

    if (picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      //setState((){
      _date = picked;
      //});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Scaffold(
            body: new Column(
              children: <Widget>[
                new Text('Date selected: ${_date.toString()}'),
                new RaisedButton(onPressed: (){_selectedDate(context);})

              ],
            ),
          ),
        ),
        Expanded(
          child: Scaffold(
            body: new GridView.count(
              crossAxisCount: 3,
              children: new List<Widget>.generate(6, (index) {
                return new GridTile(child: new Card());
              }),
            ),
          ),
        )


      ],
    );
  }
}

class Card extends StatelessWidget {
  String name;
  double amount = 0;

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.lightBlue[200],
      bottomNavigationBar: BottomAppBar(
          color: Colors.lightBlue[800],
          child: IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Edit amount',
            onPressed: () {},
          )),
    );
  }
}
