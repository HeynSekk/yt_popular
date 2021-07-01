// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yt_popular/models/videosList.dart';
import 'package:yt_popular/ui/home.dart';

//sci and tech 28, musicc 10, Howto & Style=26,Education=27,Documentary=35,Family=37

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
        ChangeNotifierProvider(create: (context) => VideosList()),
      ],
      child: MaterialApp(
        //theme: ThemeData(accentColor: Colors.white),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
        },
      ),
    );
  }
}
