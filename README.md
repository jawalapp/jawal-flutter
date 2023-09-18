# Jawal Flutter SDK

## Getting Started

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  jawal_flutter: ^1.0.3
```

### Android

The Package adds this permissions to your Android Manifest:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
```

### iOS

Add the following to your Info.plist file:

```xml
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>YOUR_LOCATION_DESCRIPTION</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>YOUR_LOCATION_DESCRIPTION</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>YOUR_LOCATION_DESCRIPTION</string>
```

If you plan to keep tracking while the app is in background, you need to enable the "Background Modes" capability and check these two options:

* Location updates
* Background fetch

## Usage

Initialize the SDK with your API Key:

```dart
JawalConfig config = JawalConfig(
    apiKey: "YOUR_API_KEY",
    userId: "USER_UNIQUE_ID", 
    userDescription: "USER_DESCRIPTION", // Optional
    onInitResult: (InitResultEvent event) {
        if(event.isSuceessful) {
            /// SDK is initialized successfully
        } else {
            /// You can get the error message from event.error
            print(event.error);
        }
    },
);
Jawal.init(config);
```

`USER_UNIQUE_ID`: A unique ID for the user, it can be the user ID in your database
`USER_DESCRIPTION`: A description for the user, it can be the user name

### Location Permissions

You need to request the location permission from the user, the SDK provides a method to request the permission:

```dart
PermissionStatus locationStatus = await Jawal.requestLocationPermission();
if(locationStatus.isGranted){
    /// Optional: Ask for background location permission if you want to keep tracking while the app is in background
    PermissionStatus backgroundStatus = await Jawal.requestBackgroundLocationPermission();
}else if(locationStatus.isPermanentlyDenied) {
    /// Permission is permanently denied, you can ask the user to go to the settings and enable the permission
}
```

### Start Tracking

```dart
Jawal.startTracking();
```

### Stop Tracking

```dart
Jawal.stopTracking();
```

### Listen to Location Updates

```dart
Jawal.onLocationChange((LocationChangeEvent event) {
    ///Do something with the location
});
```
