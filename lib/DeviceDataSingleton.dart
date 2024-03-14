import 'dart:async';

class DeviceDataSingleton {
  static final DeviceDataSingleton _instance = DeviceDataSingleton();
  int batteryStatus = 100;
  bool isSpiking = false;
  StreamController<int> batteryStatusStream = StreamController<int>.broadcast();
  StreamController<bool> isSpikingStream = StreamController<bool>.broadcast();
  bool faultyDevice = false;

  static DeviceDataSingleton getInstance() {
    return _instance;
  }
}
