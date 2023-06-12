import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'dart:async';

class SpotifyAuthScreen extends StatefulWidget {
  final String redirectUri;

  const SpotifyAuthScreen({required this.redirectUri});

  @override
  _SpotifyAuthScreenState createState() => _SpotifyAuthScreenState();
}

class _SpotifyAuthScreenState extends State<SpotifyAuthScreen> {
  StreamSubscription? _sub;
  final random = Random();
  final chars = 'abcdefghijklmnopqrstuvwxyz0123456789';

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> initUniLinks() async {
    try {
      await initPlatformState();
    } catch (e) {
      print('Error initializing UniLinks: $e');
    }
  }

  Future<void> initPlatformState() async {
    // Check if the app was opened with a UniLink
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      handleAuthorizationRedirect(initialLink);
    }

    // Listen for subsequent UniLinks
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleAuthorizationRedirect(uri.toString());
      }
    });
  }

  Future<void> handleAuthorizationRedirect(String url) async {
    // Extract the authorization code or access token from the URL
    // and proceed with the authentication flow or API requests
    // based on your app's requirements
    print('Authorization Redirect: $url');
  }

  String generateRandomString(int length) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
            (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  Future<void> launchSpotifyAuthorization() async {
    final clientId = '1595f911487941ef98bba77a8e0e8a66';
    final scope = 'user-read-private user-read-email';
    final state = generateRandomString(16);

    final authorizationUrl = Uri.https(
      'accounts.spotify.com',
      '/authorize',
      {
        'response_type': 'code',
        'client_id': clientId,
        'scope': scope,
        'redirect_uri': widget.redirectUri,
      },
    );

    if (await canLaunch(authorizationUrl.toString())) {
      await launch(authorizationUrl.toString());
    } else {
      print('Unable to launch authorization URL.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify Authorization'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: launchSpotifyAuthorization,
          child: Text('Authorize with Spotify'),
        ),
      ),
    );
  }
}
