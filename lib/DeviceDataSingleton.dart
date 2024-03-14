class DeviceDataSingleton {
  static DeviceDataSingleton _instance = new DeviceDataSingleton();
  int batteryStatus = 100;
  bool isSpiking = false;

  static DeviceDataSingleton getInstance() {
    return _instance;
  }
}
