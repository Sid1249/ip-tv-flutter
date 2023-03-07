import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:live_tv/models/channel.dart';
import 'package:live_tv/models/country.dart';
import 'package:live_tv/models/streams.dart';
import 'package:rxdart/rxdart.dart';

class IptvBloc {
  final _countries = BehaviorSubject<List<Country>>.seeded([]);
  final _channels = BehaviorSubject<List<Channel>>.seeded([]);
  final _languages = BehaviorSubject<List<dynamic>>.seeded([]);
  final _categories = BehaviorSubject<List<dynamic>>.seeded([]);
  final _streams = BehaviorSubject<List<StreamS>>.seeded([]);

  Stream<List<Country>> get countries => _countries.stream;
  Stream<List<Channel>> get channels => _channels.stream;
  Stream<List<dynamic>> get languages => _languages.stream;
  Stream<List<dynamic>> get categories => _categories.stream;
  Stream<List<StreamS>> get streams => _streams.stream;

  Future<void> fetchCountries() async {
    final response =
    await http.get(Uri.parse('https://iptv-org.github.io/api/countries.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      data.sort((a, b) => a['name'].compareTo(b['name']));
      final List<Country> countries =
      data.map((country) => Country.fromJson(country)).toList();
      _countries.add(countries);
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<void> fetchChannels() async {
    final response =
    await http.get(Uri.parse('https://iptv-org.github.io/api/channels.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Channel> channels =
      data.map((channel) => Channel.fromJson(channel)).toList();
      _channels.add(channels);
    } else {
      throw Exception('Failed to load channels');
    }
  }

  Future<void> fetchLanguages() async {
    final response =
    await http.get(Uri.parse('https://iptv-org.github.io/api/languages.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      data.sort((a, b) => a['name'].compareTo(b['name']));
      _languages.add(data);
    } else {
      throw Exception('Failed to load languages');
    }
  }

  Future<void> fetchCategories() async {
    final response =
    await http.get(Uri.parse('https://iptv-org.github.io/api/categories.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      data.sort((a, b) => a['name'].compareTo(b['name']));
      _categories.add(data);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> fetchStreams() async {
    final response =
    await http.get(Uri.parse('https://iptv-org.github.io/api/streams.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<StreamS> streams =
      data.map((stream) => StreamS.fromJson(stream)).toList();
      _streams.add(streams);
    } else {
      throw Exception('Failed to load streams');
    }
  }

  List<Channel> getChannelsForCountry(String countryName, String? searchKeyword) {
    List<Channel> channels = _channels.value ?? [];
    List<StreamS> streams = _streams.value ?? [];

    // Filter channels by country
    List<Channel> filteredChannels =
    channels.where((channel) => channel.country == countryName).toList();
    filteredChannels.retainWhere(
            (channel) => streams.any((stream) => stream.channel == channel.id));

    // Filter channels by search keyword
    if (searchKeyword != null && searchKeyword.isNotEmpty) {
      filteredChannels = filteredChannels.where((channel) =>
          channel.name.toLowerCase().contains(searchKeyword.toLowerCase())).toList();
    }

    return filteredChannels;
  }

  List<Channel> getChannelsForLanguage(String languageName, String? searchKeyword) {
    List<Channel> channels = _channels.value ?? [];
    List<StreamS> streams = _streams.value ?? [];

    // Filter channels by language
    List<Channel> filteredChannels =
    channels.where((channel) => channel.languages.contains(languageName)).toList();

    // Filter channels by stream
    filteredChannels.retainWhere(
            (channel) => streams.any((stream) => stream.channel == channel.id));

    // Filter channels by search keyword
    if (searchKeyword != null && searchKeyword.isNotEmpty) {
      filteredChannels = filteredChannels.where((channel) =>
          channel.name.toLowerCase().contains(searchKeyword.toLowerCase())).toList();
    }

    return filteredChannels;
  }

  List<Channel> getChannelsForCategory(String categoryName, String? searchKeyword) {
    List<Channel> channels = _channels.value ?? [];
    List<StreamS> streams = _streams.value ?? [];

    // Filter channels by category
    List<Channel> filteredChannels =
    channels.where((channel) => channel.categories.contains(categoryName)).toList();

    // Filter channels by stream
    filteredChannels.retainWhere(
            (channel) => streams.any((stream) => stream.channel == channel.id));

    // Filter channels by search keyword
    if (searchKeyword != null && searchKeyword.isNotEmpty) {
      filteredChannels = filteredChannels.where((channel) =>
          channel.name.toLowerCase().contains(searchKeyword.toLowerCase())).toList();
    }

    return filteredChannels;
  }


  StreamS getStreamForChannel(Channel channel) {
    List<StreamS> streams = _streams.value ?? [];
    return streams.firstWhere((stream) => stream.channel == channel.id);
  }

  void dispose() {
    _countries.close();
    _channels.close();
    _languages.close();
    _categories.close();
    _streams.close();
  }
}

final ipTvBloc = IptvBloc();
