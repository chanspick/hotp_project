import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('검색')),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: '검색어를 입력하세요'),
            onChanged: (val) {
              setState(() {
                keyword = val;
              });
            },
          ),
          Expanded(child: Container(child: Text("검색 결과: $keyword"))),
        ],
      ),
    );
  }
}
