import 'package:flutter/material.dart';

// my_menu_screen.dart
class MyMenuScreen extends StatelessWidget {
  const MyMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 추후 로그인 여부에 따라 다르게 표시
    return Scaffold(
      appBar: AppBar(title: const Text('MY')),
      body: Center(child: Text("로그인 계정 정보 / 내 매물 / 관심 상품 / 설정 등")),
    );
  }
}
