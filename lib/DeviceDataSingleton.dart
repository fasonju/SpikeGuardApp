class DeviceDataSingleton {
  static final DeviceDataSingleton _instance = DeviceDataSingleton();
  int batteryStatus = 100;
  bool isSpiking = false;

  static DeviceDataSingleton getInstance() {
    return _instance;
  }
}
