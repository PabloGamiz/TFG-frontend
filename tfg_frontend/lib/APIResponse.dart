import 'package:flutter/material.dart';

class APIResponse extends StatefulWidget {
  String response = '';
  APIResponse({Key? key, required this.response}) : super(key: key);

  @override
  _APIResponse createState() => _APIResponse(response);
}

class _APIResponse extends State<APIResponse> {
  String resp = '';

  _APIResponse(String response) {
    resp = response;
  }

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Container(
            alignment: Alignment.topCenter,
            child: Text(resp),
          ),
        ],
      ),
    );
  }
}
