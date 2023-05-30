import 'package:spotify/spotify.dart';
import 'package:http/http.dart' as http;

class SpotifyService {
  static const clientId = '1595f911487941ef98bba77a8e0e8a66';
  static const clientSecret = '0dea55f05fbd4d4a83d440419f5f767f';

  final SpotifyApi _spotify;

  SpotifyService()
      : _spotify = SpotifyApi(SpotifyApiCredentials(clientId, clientSecret));

  Future getArtist(String id) async {
    try {
      final artist = await _spotify.artists.get(id);
      return artist;
    } catch (e) {
// Handle any errors that occur during the API call
      print('Error getting artist: $e');
      return null;
    }
  }

  Future getPlaylist() async {
    const playlistID = '37i9dQZF1DX1WhyP6stXXl?si=86731543ade7418e&nd=1';
    try {
      final playlist = await _spotify.playlists.get(playlistID);

      return playlist;
    } catch (e) {
// Handle any errors that occur during the API call
      print('Error getting artist: $e');
      return null;
    }
  }




  Future<void> playSong(String accessToken, String songUri) async {
    final url = Uri.parse('https://api.spotify.com/v1/me/player/play');
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final body = '{"uris": ["$songUri"]}';

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 204) {
      print('Song played successfully');
    } else {
      print('Failed to play song. Status code: ${response.statusCode}');
    }
  }

  Future getTracksByAlbum() async {
    const albumID = '5duyQokC4FMcWPYTV9Gpf9';
    final accessToken = '0dea55f05fbd4d4a83d440419f5f767f';
    try {
      final album = await _spotify.albums.getTracks(albumID).all();
      album.forEach((element) {
        if (element.uri != null) {
          playSong(accessToken, element.uri!);
          print(element.uri);
        }
      });

      return album;
    } catch (e) {
// Handle any errors that occur during the API call
      print('Error getting artist: $e');
      return null;
    }
  }

  Future<Iterable<Track>> getPlaylistTrackURIs() async {
    const playlistID = '37i9dQZF1DX1WhyP6stXXl?si=86731543ade7418e&nd=1';
    try {
      var playlist =
          await _spotify.playlists.getTracksByPlaylistId(playlistID).all();
      print(playlist);
      if (playlist != null) return playlist;
      return [];
    } catch (e) {
      print('Error getting playlist track URIs: $e');
      return [];
    }
  }
}
