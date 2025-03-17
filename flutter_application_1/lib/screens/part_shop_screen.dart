// part_shop_screen.dart
import 'package:flutter/material.dart';

class PartShopScreen extends StatelessWidget {
  const PartShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('부품 Shop')),
      body: Center(child: Text("부품 매물 / 가격 그래프 / 필터 등 구현 예정")),
    );
  }
}
