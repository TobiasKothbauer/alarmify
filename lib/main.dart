import 'package:alarmify/views/Spotify_auth_view.dart';
import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'services/spotify_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => HomeScreen(),
        '/spotify-auth': (_) => SpotifyAuthScreen(redirectUri: 'alarmify://callback'),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/spotify-auth',
                arguments: {
                  'redirectUri': 'alarmify://callback',
                }
            );
          },
          child: Text('Authorize with Spotify'),
        ),
      ),
    );
  }
}
