import 'dart:async';

import 'request.dart';

enum Command {
  OPEN_DRIVER_DOORS,
  OPEN_PASSENGER_DOORS,

  OPEN_FRONT_DRIVER_DOOR,
  OPEN_BACK_DRIVER_DOOR,
  OPEN_FRONT_PASSENGER_DOOR,
  OPEN_BACK_PASSENGER_DOOR,

  CLOSE_DRIVER_DOORS,
  CLOSE_PASSENGER_DOORS,

  CLOSE_FRONT_DRIVER_DOOR,
  CLOSE_BACK_DRIVER_DOOR,
  CLOSE_FRONT_PASSENGER_DOOR,
  CLOSE_BACK_PASSENGER_DOOR,

  OPEN_ALL_WINDOWS,
  CLOSE_ALL_WINDOWS,

  TRUNK,
  FRONT_TRUNK
}

const Map<Command, String> commandToInternal = const {
  Command.OPEN_DRIVER_DOORS: 'openDriverDoors',
  Command.OPEN_PASSENGER_DOORS: 'openPassengerDoors',

  Command.OPEN_FRONT_DRIVER_DOOR: 'openFrontDriverDoor',
  Command.OPEN_BACK_DRIVER_DOOR: 'openBackDriverDoor',
  Command.OPEN_FRONT_PASSENGER_DOOR: 'openFrontPassengerDoor',
  Command.OPEN_BACK_PASSENGER_DOOR: 'openBackPassengerDoor',

  Command.CLOSE_DRIVER_DOORS: 'closeDriverDoors',
  Command.CLOSE_PASSENGER_DOORS: 'closePassengerDoors',

  Command.CLOSE_FRONT_DRIVER_DOOR: 'closeFrontDriverDoor',
  Command.CLOSE_BACK_DRIVER_DOOR: 'closeBackDriverDoor',
  Command.CLOSE_FRONT_PASSENGER_DOOR: 'closeFrontPassengerDoor',
  Command.CLOSE_BACK_PASSENGER_DOOR: 'closeBackPassengerDoor',

  Command.OPEN_ALL_WINDOWS: 'openAllWindows',
  Command.CLOSE_ALL_WINDOWS: 'closeAllWindows',

  Command.TRUNK: 'trunk',
  Command.FRONT_TRUNK: 'frunk'
};

const Map<Command, String> commandToReadable = const {
  Command.OPEN_DRIVER_DOORS: 'Open Driver Doors',
  Command.OPEN_PASSENGER_DOORS: 'Open Passenger Doors',

  Command.OPEN_FRONT_DRIVER_DOOR: 'Open Front Driver Door',
  Command.OPEN_BACK_DRIVER_DOOR: 'Open Back Driver Door',
  Command.OPEN_FRONT_PASSENGER_DOOR: 'Open Front Passenger Door',
  Command.OPEN_BACK_PASSENGER_DOOR: 'Open Back Passenger Door',

  Command.CLOSE_DRIVER_DOORS: 'Close Driver Doors',
  Command.CLOSE_PASSENGER_DOORS: 'Close Passenger Doors',

  Command.CLOSE_FRONT_DRIVER_DOOR: 'Close Front Driver Door',
  Command.CLOSE_BACK_DRIVER_DOOR: 'Close Back Driver Door',
  Command.CLOSE_FRONT_PASSENGER_DOOR: 'Close Front Passenger Door',
  Command.CLOSE_BACK_PASSENGER_DOOR: 'Close Back Passenger Door',

  Command.OPEN_ALL_WINDOWS: 'Open All Windows',
  Command.CLOSE_ALL_WINDOWS: 'Close All Windows',

  Command.TRUNK: 'trunk',
  Command.FRONT_TRUNK: 'frunk'
};

class Intrepid {
  Map<Command, bool> _states = new Map();

  Intrepid() {
    for (Command command in Command.values) {
      _states[command] = false;
    }
  }

  bool getState(Command command) {
    return _states[command];
  }

  Future<bool> makeRequest(String command) async {
    try {
      await makeRestRequest("https://hack.frozor.io/api/tesla/$command");
    } catch (e) {
      return false;
    }

    return true;
  }
}