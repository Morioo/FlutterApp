import 'dart:convert';

import 'package:aplication/model/conversation.dart';
import 'package:aplication/pages/homepage.dart';
import 'package:aplication/provider/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


const dataKey = 'data';

class DataLoadingPage extends StatefulWidget {
  DataLoadingPage({Key? key}) : super(key: key);

  @override
  _DataLoadingPageState createState() => _DataLoadingPageState();
}

class _DataLoadingPageState extends State<DataLoadingPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final serialized = prefs.getStringList(dataKey) ?? [];
    List<Conversation> deserialized = serialized.map((e) => Conversation.fromJson(jsonDecode(e))).toList();
    // ignore: use_build_context_synchronously
    context.read<Data>().loadConversations(deserialized);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => Homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class SharedPreferences {
  static getInstance() {}
}
