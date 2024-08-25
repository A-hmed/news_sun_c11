import 'package:flutter/material.dart';
import 'package:news_sun_c11/ui/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Home.routeName: (_) => Home()
      },
      initialRoute: Home.routeName,
    );
  }
}
///Http Requests
///Request type (get - post - delete - etc ...)
/// Get Requests (BaseUrl + ApiName + "?" + arguments) Bodyxx
/// Post Requests(BaseUrl + ApiName + "?" + arguments (optional))
/// Args are mostly placed in post request body (json)
/// Headers() ignore for now
/// ------------------------
/// Response:
/// Body -> html || Json(Java script object notation){key(string): dynamic} || xml
/// Headers
/// status code(int) 40x -> Client errors , 50x -> server error , 20x successfull