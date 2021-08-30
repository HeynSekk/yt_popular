import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yt_popular/models/homeVdsList.dart';
import 'package:yt_popular/ui/home.dart';
import 'package:yt_popular/ui/search.dart';

import 'models/vdsSearcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.redAccent,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeVdsList()),
        ChangeNotifierProvider(create: (context) => VdsSearcher()),
      ],
      child: MaterialApp(
        //theme: ThemeData(accentColor: Colors.white),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/search': (context) => SearchUi(),
        },
      ),
    );
  }
}
