import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:jawal_flutter/events/init_result_event.dart';
import 'package:jawal_flutter/events/location_change_event.dart';
import 'package:jawal_flutter/jawal_config.dart';
import 'package:jawal_flutter/models/permission_status.dart';
import 'j_platform_interface.dart';


class JMethodChannel extends JPlatformInterface {

  @visibleForTesting
  final methodChannel = const MethodChannel('jawal_flutter');
  Function(LocationChangeEvent)? _onLocationChange;
  Completer<PermissionStatus>? _foregroundLocationPermissionCompleter;
  Completer<PermissionStatus>? _backgroundLocationPermissionCompleter;

  @override
  Future<void> init(JawalConfig config) async {
    try{
      final configMap = <String, dynamic>{
        'sdkKey': config.apiKey,
        'userId': config.userId,
        'userDescription': config.userDescription
      };
      await methodChannel.invokeMethod<bool>("init", configMap);
      methodChannel.setMethodCallHandler((call) async {
        handlePlatformCalls(call, config);
      });
    }catch(e){
      config.onInitResult!(InitResultEvent(isSuccessful: false, error: e.toString()));
    }
  }



  void handlePlatformCalls(MethodCall call, JawalConfig config) async {
    switch (call.method) {
      case "onInitResult":
        if (config.onInitResult != null) {
          InitResultEvent event = InitResultEvent.fromJson(jsonDecode(call.arguments));
          config.onInitResult!(event);
        }
        break;
      case "onLocationChange":
        if (_onLocationChange != null) {
          _onLocationChange!(LocationChangeEvent.fromJson(jsonDecode(call.arguments)));
        }
        break;
      case "onLocationPermissionResult":
        _foregroundLocationPermissionCompleter?.complete(PermissionStatus.fromJson(jsonDecode(call.arguments)));
        break;
      case "onBackgroundLocationPermissionResult":
        _backgroundLocationPermissionCompleter?.complete(PermissionStatus.fromJson(jsonDecode(call.arguments)));
        break;
      default:
        throw MissingPluginException();
    }
  }

  @override
  void onLocationChange(Function(LocationChangeEvent) callback) {
    _onLocationChange = callback;
  }

  @override
  Future<bool> isTracking() async {
    final isTracking = await methodChannel.invokeMethod<bool>("isTracking");
    return isTracking ?? false;
  }

  @override
  Future<void> startTracking() async {
    await methodChannel.invokeMethod<void>("startTracking");
  }

  @override
  Future<void> stopTracking() async {
    await methodChannel.invokeMethod<void>("stopTracking");
  }

  @override
  Future<PermissionStatus> requestForegroundLocationPermission() async {
    _foregroundLocationPermissionCompleter = Completer<PermissionStatus>();
    await methodChannel.invokeMethod("askForLocationPermission");
    return _foregroundLocationPermissionCompleter!.future;
  }

  @override
  Future<PermissionStatus> requestBackgroundLocationPermission() async {
    _backgroundLocationPermissionCompleter = Completer<PermissionStatus>();
    await methodChannel.invokeMethod("askForBackgroundLocationPermission");
    return _backgroundLocationPermissionCompleter!.future;
  }

  @override
  Future<PermissionStatus> backgroundLocationPermissionStatus() async {
    final String status = await methodChannel.invokeMethod("getBackgroundLocationPermissionStatus");
    return PermissionStatus.fromJson(jsonDecode(status));
  }

  @override
  Future<PermissionStatus> foregroundLocationPermissionStatus() async {
    final String status = await methodChannel.invokeMethod("getLocationPermissionStatus");
    return PermissionStatus.fromJson(jsonDecode(status));
  }

}
