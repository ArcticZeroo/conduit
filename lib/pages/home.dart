import 'package:flutter/material.dart';
import 'package:tesla_controller/api/intrepid.dart';

class HomePage extends StatefulWidget {
  final String name;

  HomePage(this.name);

  @override
  State<StatefulWidget> createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Intrepid _intrepid;

  HomePageState() {
    _intrepid = new Intrepid();
  }

  Widget buildTitle(IconData iconData, String title) {
    return new ListTile(
      leading: new Icon(iconData, color: Colors.black87),
      title: new Text(title)
    );
  }
  
  Widget buildChild(IconData iconData, String title) {
    return new Container(
      padding: const EdgeInsets.only(left: 8.0),
      child: new ListTile(
          leading: new Icon(iconData),
          title: new Text(title)
      )
    );
  }
  
  FlatButton buildGoodButton(String text, VoidCallback onTap) {
    return new FlatButton(onPressed: onTap, child: new Text(text), color: Colors.green);
  }

  FlatButton buildBadButton(String text, VoidCallback onTap) {
    return new FlatButton(onPressed: onTap, child: new Text(text), color: Colors.red);
  }

  Widget buildDoorRow(String type, String location, [bool plural = false]) {
    return new Center(
        child: new Row(
          children: <Widget>[ buildGoodButton('Open', () {
            _intrepid.makeRequest('open${location}${type}Door${plural ? 's' : ''}');
          }), buildBadButton('Close', () {
            _intrepid.makeRequest('close${location}${type}Door${plural ? 's' : ''}');
          }) ],
        )
    )
  }
  
  Widget buildDoorDisplay(String type) {
    List<Widget> children = new List();
    
    children.add(buildTitle(Icons.drive_eta, '$type Side Door Controls'));
    
    children.add(buildChild(Icons.arrow_upward, 'Front Door'));
    children.add(buildDoorRow(type, 'Front'));

    children.add(buildChild(Icons.arrow_downward, 'Back Door'));
    children.add(buildDoorRow(type, 'Back'));

    children.add(buildChild(Icons.compare_arrows, 'All Doors'));
    children.add(buildDoorRow(type, '', true));

    return new Column(children: children);
  }

  List<Widget> buildBodyChildren() {
    List<Widget> children = new List();

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.name),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new ListView(
          scrollDirection: Axis.vertical,
          children: buildBodyChildren(),
        ),
      )
    );
  }
}