import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/providers/UserInfo.dart';
import 'package:beats_ft/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => ServerInfo()),
        Provider(
          builder: (context) => UserInfo(),
        ),
        Provider(
          builder: (context) => ServerInfo(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
