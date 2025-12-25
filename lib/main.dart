import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

// Trigger

class _MainAppState extends State<MainApp> {
  String _version = "";
  String _buildNumber = "";
  String _runningMode = "checking...";

  @override
  initState() {
    super.initState();
    _getPackageInfo();
  }

  Future<void> _getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    _buildNumber = buildNumber;
    _version = version;
    if (kDebugMode) {
      _runningMode = "debug";
    } else if (kReleaseMode) {
      _runningMode = "release";
    } else if (kProfileMode) {
      _runningMode = "profile";
    } else {
      _runningMode = "Unknown";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              const Text(
                'This is a demo app for CI/CD workflow',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              SizedBox(height: 4),
              Text("version: $_version"),
              Text("build number: $_buildNumber"),
              Text("running mode: $_runningMode"),
            ],
          ),
        ),
      ),
    );
  }
}
