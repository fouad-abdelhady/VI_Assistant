import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jarvis000/providers/languages.dart';
import 'package:jarvis000/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import './config/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Languages(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.white,
              secondary: Color.fromARGB(255, 48, 47, 47)),
          textTheme: const TextTheme().copyWith(
              headline2: const TextStyle(
                fontFamily: 'dosis',
              ),
              headline6: const TextStyle(
                  fontFamily: 'dosis', color: Color.fromARGB(255, 43, 43, 43))),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 94, 16, 16),
            titleTextStyle: ThemeData()
                .copyWith()
                .textTheme
                .headline2!
                .copyWith(
                    color: Colors.white, fontSize: 25, fontFamily: 'playfair'),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        home: SplashScreen(),
        onGenerateRoute: (settings) =>
            Routes.ON_GENERATE_ROUTE(settings: settings),
      ),
    );
  }
}
