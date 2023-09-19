import 'package:flutter/material.dart';
import 'package:jawal_flutter/events/init_result_event.dart';
import 'package:jawal_flutter/events/location_change_event.dart';
import 'package:jawal_flutter/jawal_config.dart';
import 'package:jawal_flutter/models/permission_status.dart';
import 'package:jawal_flutter/jawal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _tracking = false;

  @override
  void initState() {
    super.initState();
    bootstrap();
  }

  void bootstrap() async {
    initJawalFlutter();
    final PermissionStatus locationStatus =
        await Jawal.requestLocationPermission();
    if (locationStatus.isGranted) {
      ///Ask for the background location permission
      ///Optional: You can skip this step if you don't need background location
      await Jawal.requestBackgroundLocationPermission();
    } else if (locationStatus.isPermanentlyDenied) {
      ///We can alert the user that the location permission is needed
      ///and redirect him to the app settings
    }
  }

  void initJawalFlutter() async {
    JawalConfig config = JawalConfig(
      apiKey: "YOUR_API_KEY",
      userId: "USER_UNIQUE_ID",
      userDescription: "USER_DESCRIPTION", //Optional
      onInitResult: (InitResultEvent event) {
        setState(() {
          _initialized = event.isSuccessful;
        });
      },
    );
    await Jawal.init(config);
    Jawal.onLocationChange((LocationChangeEvent event) {
      ///Do something with the location
    });

    final isTracking = await Jawal.isTracking();
    setState(() {
      _tracking = isTracking;
    });
  }

  void toggleTracking() async {
    Jawal.isTracking().then((value) => {
          if (value) {Jawal.stopTracking()} else {Jawal.startTracking("YOUR_SESSION_ID")}
        });
    setState(() {
      _tracking = !_tracking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Jawal Flutter Demo App'),
        ),
        body: Center(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                _initialized
                    ? "Jawal Flutter is initialized"
                    : "Jawal Flutter is not initialized",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
                onPressed: (_initialized) ? toggleTracking : null,
                child: Text((_tracking) ? "Stop Tracking" : "Start Tracking")),
          ],
        )),
      ),
    );
  }
}
