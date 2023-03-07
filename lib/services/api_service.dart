// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:live_tv/models/channel.dart';
// import 'package:live_tv/models/country.dart';
// import 'package:live_tv/models/streams.dart';
// import 'package:rxdart/rxdart.dart';
//
// class ApiService {
//   final _countries = BehaviorSubject<List<Country>>();
//   final _channels = BehaviorSubject<List<Channel>>();
//   final _languages = BehaviorSubject<List<dynamic>>();
//   final _categories = BehaviorSubject<List<dynamic>>();
//   final _streams = BehaviorSubject<List<StreamS>>();
//
//   Stream<List<Country>> get countries => _countries.stream;
//   Stream<List<Channel>> get channels => _channels.stream;
//   Stream<List<dynamic>> get languages => _languages.stream;
//   Stream<List<dynamic>> get categories => _categories.stream;
//   Stream<List<StreamS>> get streams => _streams.stream;
//
//   ApiService() {
//     fetchCountries();
//     fetchChannels();
//     fetchLanguages();
//     fetchCategories();
//     fetchStreams();
//   }
//
//   Future<void> fetchCountries() async {
//     final response =
//     await http.get(Uri.parse('https://iptv-org.github.io/api/countries.json'));
//     if (response.statusCode == 200) {
//       final countries = List<Country>.from(
//           json.decode(response.body).map((x) => Country.fromJson(x)));
//       _countries.add(countries);
//     } else {
//       throw Exception('Failed to load countries');
//     }
//   }
//
//   Future<void> fetchChannels() async {
//     final response =
//     await http.get(Uri.parse('https://iptv-org.github.io/api/channels.json'));
//     if (response.statusCode == 200) {
//       final channels = List<Channel>.from(
//           json.decode(response.body).map((x) => Channel.fromJson(x)));
//       _channels.add(channels);
//     } else {
//       throw Exception('Failed to load channels');
//     }
//   }
//
//   Future<void> fetchLanguages() async {
//     final response =
//     await http.get(Uri.parse('https://iptv-org.github.io/api/languages.json'));
//     if (response.statusCode == 200) {
//       _languages.add(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load languages');
//     }
//   }
//
//   Future<void> fetchCategories() async {
//     final response =
//     await http.get(Uri.parse('https://iptv-org.github.io/api/categories.json'));
//     if (response.statusCode == 200) {
//       _categories.add(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }
//
//   Future<void> fetchStreams() async {
//     final response =
//     await http.get(Uri.parse('https://iptv-org.github.io/api/streams.json'));
//     if (response.statusCode == 200) {
//       final streams = List<StreamS>.from(
//           json.decode(response.body).map((x) => StreamS.fromJson(x)));
//       _streams.add(streams);
//
