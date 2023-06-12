import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/spotify_auth.dart';

class SpotifyAuthView extends StatelessWidget {
  final String redirectUri;

  const SpotifyAuthView({required this.redirectUri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify Authorization'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SpotifyAuthScreen(
                  redirectUri: redirectUri,
                ),
              ),
            );
          },
          child: Text('Authorize with Spotify'),
        ),
      ),
    );
  }
}
