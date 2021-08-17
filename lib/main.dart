import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'views/AUTH/profile.dart';
import 'views/AUTH/login.dart';

//PLUGINS
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

// const AUTH0_DOMAIN = 'dev-doyn1xza.us.auth0.com';
// const AUTH0_CLIENT_ID = 'wfRwiG0YcIk3StMI0TMov5HT3zAtezQu';
//
// const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';

// const AUTH0_DOMAIN = 'dev-ac5to4fd.us.auth0.com';
// const AUTH0_CLIENT_ID = 'zdND3zGnHwjCwXYOaKUQzthsafJmvI17';g
//
// const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';

const AUTH0_DOMAIN = 'msales.au.auth0.com';
const AUTH0_CLIENT_ID = 'NUKOCWglGI8DrPrmkFBWJw2b8MM5Om8j';
//const AUTH0_CLIENT_ID = 'B7FNmuveTcdn3ekaqT7yMOeK4K80wQi8';
//live - const AUTH0_CLIENT_ID = 'NUKOCWglGI8DrPrmkFBWJw2b8MM5Om8j';
 //const AUTH0_CLIENT_ID = 'pJl7Pf4IulAsJM6yUP0anPlxI5HGrbDI';

//GZxv8drDMXLPdkc

// LIVE - const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';

const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';

const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

void main(){
  runApp(
    MaterialApp(
        home:splashScreen(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class splashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/logo/moder_logo_white.png', width: 400.0,),
        nextScreen: MyApp(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage;
  String name;
  String picture;


  @override

  Map<String, dynamic> parseIdToken(String idToken) {

    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))
    );
  }

  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = Uri.parse('https://$AUTH0_DOMAIN/userinfo');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    print("1st came here");

    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      final AuthorizationTokenResponse result =await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: 'https://$AUTH0_DOMAIN',
          scopes: ['openid','profile','offline_access',],
          additionalParameters: {
            "audience": "http://public.api.msalesapp.com"
          },
          promptValues: ['login'],
        ),
      );
      //print("came to try section below resutl");
      final idToken = parseIdToken(result.idToken);

      //final idToken = parseIdToken(result.idToken);

      print("idToken: ${idToken['given_name']}");
      print("Token : ${result.idToken}");
      print("ACCESS TOKE : ${result.accessToken}");
      final profile = await getUserDetails(result.accessToken);

      localStorage.setString('USER_TOKEN', result.idToken);
      localStorage.setString('GIVEN_NAME', idToken['given_name']);
      localStorage.setString('PROFILE_IMAGE', idToken['picture']);
      localStorage.setString('ACCESS_TOKEN', result.accessToken);
      //GZxv8drDMXLPdkc

      await secureStorage.write(key: 'refresh_token', value: result.refreshToken);


      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print("Came to catch section");
      print('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  @override

  void initState() {
    initAction();
    super.initState();
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final idToken = parseIdToken(response.idToken);
      final profile = await getUserDetails(response.accessToken);

      secureStorage.write(key: 'refresh_token', value: response.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M-Order',
      home: Scaffold(
        body: Center(
          child: isBusy
              ? CircularProgressIndicator()
              : isLoggedIn
              ? Profile(logoutAction, name, picture)
              : Login(loginAction, errorMessage),
        ),
      ),
    );
  }
}