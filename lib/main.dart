import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scout/pages/chat_screen.dart';
import 'package:scout/pages/home_page.dart';
import 'package:scout/pages/login_screen.dart';
import 'package:scout/pages/match_form.dart';
import 'package:scout/pages/registration_screen.dart';
import 'package:scout/pages/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scout",
      theme: ThemeData(
        // brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        primaryColorLight: Color(0xFFC5CAE9),
        accentColor: Colors.orange,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
            color: Color(0xFF212121),
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
            color: Color(0xFF757575),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: ScoutHome.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        ScoutHome.id: (context) => ScoutHome(),
        MatchForm.id: (context) => MatchForm(),
      },
    );
  }
}
