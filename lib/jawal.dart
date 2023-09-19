import 'package:jawal_flutter/events/location_change_event.dart';
import 'package:jawal_flutter/jawal_config.dart';
import 'package:jawal_flutter/models/permission_status.dart';

import 'j_platform_interface.dart';

class Jawal {

  /// Listen to location change events
  /// @param callback Function(LocationChangeEvent)
  /// @return void
  static void onLocationChange(Function(LocationChangeEvent) callback) {
    JPlatformInterface.instance.onLocationChange(callback);
  }

  /// Initialize JawalFlutter with the given config
  /// @param config JawalConfig
  /// @return Future<bool> initialized or not
  static Future<void> init(JawalConfig config) async {
    await JPlatformInterface.instance.init(config);
  }

  /// Start tracking the user location
  /// @return Future<void>
  static Future<void> startTracking([String? sessionId]) async {
    await JPlatformInterface.instance.startTracking(sessionId);
  }

  /// Stop tracking the user location
  /// @return Future<void>
  static Future<void> stopTracking() async {
    await JPlatformInterface.instance.stopTracking();
  }

  /// Check if the user is currently being tracked
  /// @return Future<bool>
  static Future<bool> isTracking() async {
    return await JPlatformInterface.instance.isTracking();
  }

  /// Request foreground location permission
  /// @return Future<PermissionStatus>
  static Future<PermissionStatus> requestLocationPermission() async {
    return await JPlatformInterface.instance.requestForegroundLocationPermission();
  }

  /// Request background location permission
  /// @return Future<PermissionStatus>
  static Future<PermissionStatus> requestBackgroundLocationPermission() async {
    return await JPlatformInterface.instance.requestBackgroundLocationPermission();
  }

  /// Get the current foreground location permission status
  /// @return Future<PermissionStatus>
  static Future<PermissionStatus> locationStatus() async {
    return await JPlatformInterface.instance.foregroundLocationPermissionStatus();
  }

  /// Get the current background location permission status
  /// @return Future<PermissionStatus>
  static Future<PermissionStatus> backgroundLocationStatus() async {
    return await JPlatformInterface.instance.backgroundLocationPermissionStatus();
  }

}
