import 'package:cosmeto/SplashScreen/splashscreen.dart';
import 'package:cosmeto/loginpage/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator{
  static Route<dynamic>? generateRoute(RouteSettings settings) {

    final arg = settings.arguments;
    switch (settings.name) {


      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      default:
        _onPageNotFound();
    }
  }

  static Route<dynamic> _onPageNotFound() {

    return MaterialPageRoute(

      builder: (_) => const Scaffold(body: Text("Page not found")),

    );
  }
}
