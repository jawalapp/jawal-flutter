import 'package:flutter_test/flutter_test.dart';
import 'package:jawal_flutter/events/location_change_event.dart';
import 'package:jawal_flutter/j_platform_interface.dart';
import 'package:jawal_flutter/jawal_config.dart';
import 'package:jawal_flutter/models/permission_status.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockJawalFlutterPlatform
    with MockPlatformInterfaceMixin
    implements JPlatformInterface {

  @override
  Future<void> init(JawalConfig config) {
    return Future.value();
  }

  @override
  Future<void> startTracking() {
    return Future.value(null);
  }

  @override
  Future<void> stopTracking() {
    return Future.value(null);
  }


  @override
  Future<PermissionStatus> backgroundLocationPermissionStatus() {
    // TODO: implement backgroundLocationPermissionStatus
    throw UnimplementedError();
  }

  @override
  Future<PermissionStatus> foregroundLocationPermissionStatus() {
    // TODO: implement foregroundLocationPermissionStatus
    throw UnimplementedError();
  }

  @override
  Future<PermissionStatus> requestBackgroundLocationPermission() {
    // TODO: implement requestBackgroundLocationPermission
    throw UnimplementedError();
  }

  @override
  Future<PermissionStatus> requestForegroundLocationPermission() {
    // TODO: implement requestForegroundLocationPermission
    throw UnimplementedError();
  }

  @override
  Future<bool> isTracking() {
    // TODO: implement isTracking
    throw UnimplementedError();
  }

  @override
  void onLocationChange(Function(LocationChangeEvent p1) callback) {
    // TODO: implement onLocationChange
    throw UnimplementedError();
  }
}

void main() {


  test('init', () async {
  });

  test('startTracking', () async {
  });

  test('stopTracking', () async {
  });
}
