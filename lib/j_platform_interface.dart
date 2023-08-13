import 'package:jawal_flutter/events/location_change_event.dart';
import 'package:jawal_flutter/jawal_config.dart';
import 'package:jawal_flutter/models/permission_status.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'j_method_channel.dart';

abstract class JPlatformInterface extends PlatformInterface {

  JPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static JPlatformInterface _instance = JMethodChannel();

  static JPlatformInterface get instance => _instance;

  static set instance(JPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init(JawalConfig config) {
    return JPlatformInterface.instance.init(config);
  }

  Future<void> startTracking() {
    return JPlatformInterface.instance.startTracking();
  }

  Future<void> stopTracking() {
    return JPlatformInterface.instance.stopTracking();
  }

  Future<bool> isTracking() {
    return JPlatformInterface.instance.isTracking();
  }

  Future<PermissionStatus> requestBackgroundLocationPermission() {
    return JPlatformInterface.instance.requestBackgroundLocationPermission();
  }

  Future<PermissionStatus> requestForegroundLocationPermission() {
    return JPlatformInterface.instance.requestForegroundLocationPermission();
  }

  Future<PermissionStatus> backgroundLocationPermissionStatus() {
    return JPlatformInterface.instance.backgroundLocationPermissionStatus();
  }

  Future<PermissionStatus> foregroundLocationPermissionStatus() {
    return JPlatformInterface.instance.foregroundLocationPermissionStatus();
  }

  void onLocationChange(Function(LocationChangeEvent p1) callback) {
    return JPlatformInterface.instance.onLocationChange(callback);
  }
}
