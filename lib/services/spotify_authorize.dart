import 'package:spotify/spotify.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotifyAuthorization {
  final clientId = '1595f911487941ef98bba77a8e0e8a66';
  final clientSecret = '0dea55f05fbd4d4a83d440419f5f767f';

  getAuthorization() async {
    final credentials = SpotifyApiCredentials(clientId, clientSecret);
    final grant = SpotifyApi.authorizationCodeGrant(credentials);

    // The URI to redirect to after the user grants or denies permission. It must
// be in your Spotify application's Redirect URI whitelist. This URI can
// either be a web address pointing to an authorization server or a fabricated
// URI that allows the client device to function as an authorization server.
    final redirectUri = 'https://example.com/auth';

// See https://developer.spotify.com/documentation/general/guides/scopes/
// for a complete list of these Spotify authorization permissions. If no
// scopes are specified, only public Spotify information will be available.
    final scopes = ['user-read-email', 'user-library-read'];

    final authUri = grant.getAuthorizationUrl(
      Uri.parse(redirectUri),
      scopes: scopes, // scopes are optional
    );

// `redirect` is an imaginary function that redirects the resource owner's
// browser to the `authUri` on the authorization server. Once the resource
// owner has authorized, they'll be redirected to the `redirectUri` with an
// authorization code. The exact implementation varies across platforms.
    await redirect(authUri);

// `listen` is another imaginary function that listens for a request to
// `redirectUri` after the user grants or denies permission. Again, the
// exact implementation varies across platforms.
    //final responseUri = await listen(redirectUri);
    final responseUri = '';

    final spotify = SpotifyApi.fromAuthCodeGrant(grant, responseUri);
  }

  redirect(authUri) async{
    if (await canLaunchUrl(authUri)) {
    await launch(authUri);
    }
  }

  listen(){

  }
}
