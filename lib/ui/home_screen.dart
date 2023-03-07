import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_tv/bloc/iptv_bloc.dart';
import 'package:live_tv/models/channel.dart';
import 'package:live_tv/models/country.dart';
import 'package:live_tv/models/streams.dart';
import 'package:live_tv/ui/channel_list_screen.dart';
import 'package:rxdart/rxdart.dart';

class IPTVScreen extends StatefulWidget {
  @override
  _IPTVScreenState createState() => _IPTVScreenState();
}

class _IPTVScreenState extends State<IPTVScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController = TextEditingController();
    ipTvBloc.fetchCountries();
    ipTvBloc.fetchChannels();
    ipTvBloc.fetchLanguages();
    ipTvBloc.fetchCategories();
    ipTvBloc.fetchStreams();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    ipTvBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IPTV'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Country'),
            Tab(text: 'Language'),
            Tab(text: 'Category'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCountryTab(),
          _buildLanguageTab(),
          _buildCategoryTab(),
        ],
      ),
    );
  }

  Widget _buildCountryTab() {
    return StreamBuilder<List<Country>>(
      stream: ipTvBloc.countries,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error.toString()}'),
          );
        } else if (snapshot.hasData) {
          final List<Country>? countries = snapshot.data;
          final filteredCountries = countries!
              .where((country) => country.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
              .toList();

          // Filter channels by search keyword
          final List<Channel> channels = ipTvBloc.getChannelsForCountry(
              filteredCountries.first.code, _searchController.text);

          return Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCountries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(filteredCountries[index].name),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        final List<Channel> channels = ipTvBloc
                            .getChannelsForCountry(filteredCountries[index].code , _searchController.text);

                        _openChannelsScreen(channels);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }


  Widget _buildLanguageTab() {
    return StreamBuilder<List<dynamic>>(
        stream: ipTvBloc.languages,
        builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error.toString()}'),
        );
      } else if (snapshot.hasData) {
        final List<dynamic>? languages = snapshot.data;
        return ListView.builder(
          itemCount: languages!.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(languages[index]['name']),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                final List<Channel> channels =
                ipTvBloc.getChannelsForLanguage(languages[index]['code'], "");
                _openChannelsScreen(channels);
              },
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
        },
    );
  }
  Widget _buildCategoryTab() {
    return StreamBuilder<List<dynamic>>(
      stream: ipTvBloc.categories,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error.toString()}'),
          );
        } else if (snapshot.hasData) {
          final List<dynamic>? categories = snapshot.data;
          return ListView.builder(
            itemCount: categories!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(categories[index]['name']),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  final List<Channel> channels =
                  ipTvBloc.getChannelsForCategory(categories[index]['id'], "");
                  _openChannelsScreen(channels);
                },
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _openChannelsScreen(List<Channel> channels) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChannelsScreen(channels: channels),
      ),
    );
  }
}