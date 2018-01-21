import 'package:flutter/material.dart';
import 'package:tesla_controller/api/Identifiers.dart';
import 'package:tesla_controller/api/intrepid.dart';

class HomePage extends StatefulWidget {
  final String name;

  HomePage(this.name);

  @override
  State<StatefulWidget> createState() => new HomePageState();
}

enum ToggleableState {
  OPEN, CLOSED
}

class HomePageState extends State<HomePage> {
  final Map<String, bool> _collapseStates = {
    'driverDoors': true,
    'passengerDoors': true
  };

  final Map<String, Map<String, bool>> _doorStates = {
    Identifiers.DRIVER: { 'Front': false, 'Back': false },
    Identifiers.PASSENGER: { 'Front': false, 'Back': false },
  };

  Intrepid _intrepid;

  HomePageState() {
    _intrepid = new Intrepid();
  }

  Widget paddify(Widget widget) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: widget,
    );
  }

  Widget buildTitle(IconData iconData, String title, String stateName) {
    return new ListTile(
      leading: new Icon(iconData, color: Colors.black87),
      title: new Text(title),
      onTap: () {
        setState(() {
          _collapseStates[stateName] = !_collapseStates[stateName];
        });
      },
      subtitle: new Text('Tap to ${_collapseStates[stateName] ? 'collapse' : 'expand'}'),
    );
  }
  
  Widget buildChild(IconData iconData, String title) {
    return new Container(
      padding: const EdgeInsets.only(left: 12.0),
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

  FlatButton buildGreyedButton(String text) {
    return new FlatButton(onPressed: null, child: new Text(text));
  }

  String getOpenString(bool open, String side, String location, [bool plural = false]) {
    return '${open ? 'open' : 'close'}$location${side}Door${plural ? 's' : ''}';
  }

  Map<String, bool> getDoorState(String type) {
    return _doorStates[type.toLowerCase() + 'Doors'];
  }

  Widget buildDoorRow(String type, String location, {bool plural = false, onTap(bool open)}) {
    String open = getOpenString(true, type, location, plural);
    String close = getOpenString(false, type, location, plural);

    return new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[ (!plural && _doorStates[type][location]) ? buildGreyedButton('Open') : buildGoodButton('Open', () async {
            _intrepid.makeRequest(open);

            if (onTap != null) {
              onTap(true);
            } else {
              setState(() {
                _doorStates[type][location] = true;
              });
            }
          }), (!plural && !_doorStates[type][location]) ? buildGreyedButton('Close') : buildBadButton('Close', () async {
            _intrepid.makeRequest(close);

            if (onTap != null) {
              onTap(false);
            } else {
              setState(() {
                _doorStates[type][location] = false;
              });
            }
          }) ]
        )
    );
  }
  
  Widget buildDoorDisplay(String type, IconData iconData) {
    List<Widget> children = new List();
    
    children.add(buildTitle(iconData, '$type Side Door Controls', '${type.toLowerCase()}Doors'));
    
    if (_collapseStates[type.toLowerCase() + 'Doors']) {
      children.add(buildChild(Icons.arrow_upward, 'Front Door'));
      children.add(buildDoorRow(type, 'Front'));

      children.add(buildChild(Icons.arrow_downward, 'Back Door'));
      children.add(buildDoorRow(type, 'Back'));

      children.add(buildChild(Icons.compare_arrows, 'All Doors'));
      children.add(buildDoorRow(type, '', plural: true, onTap: (bool open) async {
        setState(() {
          _doorStates[type]['Front'] = open;
          _doorStates[type]['Back'] = open;
        });
      }));
    }

    return new Column(children: children);
  }

  List<Widget> buildBodyChildren() {
    List<Widget> children = new List();

    children.add(paddify(buildDoorDisplay('Driver', Icons.drive_eta)));
    children.add(paddify(buildDoorDisplay('Passenger', Icons.accessibility)));

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text(widget.name),
      ),
      body: new ListView(
        scrollDirection: Axis.vertical,
        children: buildBodyChildren(),
      )
    );
  }
}