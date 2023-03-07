// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:live_tv/models/channel.dart';
//
// class ChannelRepository {
//   final String apiUrl =
//       "https://iptv-org.github.io/api/streams.json"; // Free IPTV API endpoint
//
//
//
//
//   Future<void> fetchCountries() async {
//     final response = await http
//         .get(Uri.parse('https://iptv-org.github.io/api/countries.json'));
//     if (response.statusCode == 200) {
//       setState(() {
//         countries = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load countries');
//     }
//   }
//
//   Future<void> fetchChannels() async {
//     final response = await http
//         .get(Uri.parse('https://iptv-org.github.io/api/channels.json'));
//     if (response.statusCode == 200) {
//       setState(() {
//         channels = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load channels');
//     }
//   }
//
//   Future<void> fetchLanguages() async {
//     final response = await http
//         .get(Uri.parse('https://iptv-org.github.io/api/languages.json'));
//     if (response.statusCode == 200) {
//       setState(() {
//         languages = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load languages');
//     }
//   }
//
//   Future<void> fetchCategories() async {
//     final response = await http
//         .get(Uri.parse('https://iptv-org.github.io/api/categories.json'));
//     if (response.statusCode == 200) {
//       setState(() {
//         categories = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }
//
//   Future<void> fetchStreams() async {
//     final response = await http
//         .get(Uri.parse('https://iptv-org.github.io/api/streams.json'));
//     if (response.statusCode == 200) {
//       setState(() {
//         streams = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load streams');
//     }
//   }
//
//   List<dynamic> getStreamsForChannel(String channelName) {
//     return streams.where((stream) => stream['channel'] == channelName).toList();
//   }
//
//
// }
