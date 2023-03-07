import 'package:flutter/material.dart';
import 'package:live_tv/bloc/iptv_bloc.dart';
import 'package:live_tv/models/channel.dart';
import 'package:live_tv/models/streams.dart';
import 'package:live_tv/ui/channel_player_screen.dart';

class ChannelsScreen extends StatefulWidget {
  final List<Channel> channels;

  const ChannelsScreen({Key? key, required this.channels,})
      : super(key: key);

  @override
  _ChannelsScreenState createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
  late List<Channel> _filteredChannels;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredChannels = widget.channels;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openPlayerScreen(Channel channel, StreamS stream, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChannelPlayerScreen(channel: channel, url: stream.url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Channels'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: _ChannelSearchDelegate(widget.channels));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: _filteredChannels.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          final Channel channel = _filteredChannels[index];
          return GestureDetector(
            onTap: () async {
              final stream = ipTvBloc.getStreamForChannel(channel);
              var s = await stream;
              _openPlayerScreen(channel, s, context);
            },
            child: Card(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    channel.logo,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          channel.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ChannelSearchDelegate extends SearchDelegate<Channel> {
  final List<Channel> channels;

  _ChannelSearchDelegate(this.channels);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        // close(context, null);
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredChannels = channels.where((channel) => channel.name.toLowerCase().contains(query.toLowerCase())).toList();
    return GridView.builder(
        itemCount: filteredChannels.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemBuilder: (BuildContext context, int index) {
    final Channel channel = filteredChannels[index];
    return GestureDetector(
      onTap: () async {
        final stream = ipTvBloc.getStreamForChannel(channel);
        var s = await stream;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChannelPlayerScreen(channel: channel, url: s.url),
          ),
        );
      },
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              channel.logo,
              fit: BoxFit.contain,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    channel.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredChannels = channels.where((channel) => channel.name.toLowerCase().contains(query.toLowerCase())).toList();
    return GridView.builder(
      itemCount: filteredChannels.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        final Channel channel = filteredChannels[index];
        print("channel = $channel &&& ${channel.name}");
        return GestureDetector(
          onTap: () async {
            final stream = ipTvBloc.getStreamForChannel(channel);
            var s = stream;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChannelPlayerScreen(channel: channel, url: s.url),
              ),
            );
          },
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  channel.logo,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        channel.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}