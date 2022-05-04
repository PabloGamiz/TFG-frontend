import 'package:flutter/material.dart';

class APIResponse extends StatefulWidget {
  String response = '';
  APIResponse({required this.response});

  @override
  _APIResponse createState() => _APIResponse(response);
}

class _APIResponse extends State<APIResponse> {
  String resp = '';
  void initState() {
    super.initState();
  }

  _APIResponse(String response) {
    resp = response;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Container(
            alignment: Alignment.topCenter,
            child: Text(''),
          ),
        ],
      ),
    );
  }
}
