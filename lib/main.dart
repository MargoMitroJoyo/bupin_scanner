import 'dart:developer';


import 'package:Bupin/Navigation/navigation.dart';
import 'package:Bupin/camera/camera_provider.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  return runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavigationProvider(),
        ), ChangeNotifierProvider(
          create: (context) => CameraProvider(),
        ),
       
      ],
      child: const MyApp(),
    ),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
     
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.Debug.setAlertLevel(OSLogLevel.none);

    OneSignal.initialize("fdfd9caf-329f-4c83-973c-726d73fb6169");
    OneSignal.Notifications.requestPermission(true);
    // OneSignal.Notifications.clearAll();

    OneSignal.User.pushSubscription.addObserver((state) {
      log(OneSignal.User.pushSubscription.optedIn.toString());
      log(OneSignal.User.pushSubscription.id.toString());
      log(OneSignal.User.pushSubscription.token.toString());
      log(state.current.jsonRepresentation());
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      log("Has permission $state");
    });

    OneSignal.Notifications.addClickListener((event) {
      log("nitifikasi opende");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                actionsIconTheme: IconThemeData(color: Colors.white)),
            fontFamily: 'Nunito',
            textTheme:
                const TextTheme(titleMedium: TextStyle(fontFamily: "Nunito")),
            scaffoldBackgroundColor:    Color.fromRGBO(106, 90, 224, 1,),
            colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: const Color.fromRGBO(124, 120, 209, 1),
                primary: const Color.fromRGBO(106, 90, 224, 1))),
        home: const Navigation());
  }
}
