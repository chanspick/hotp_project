// home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 만약 하단 탭 바가 있으니 AppBar만 있으면 됨
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // 검색 화면으로 이동 혹은 다른 동작
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  "브랜드, 상품, 프로필, 태그 등",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1) 상단 배너 (가로 슬라이드)
            SizedBox(
              height: 200,
              child: PageView(
                children: [
                  _BannerItem(imageUrl: 'https://example.com/banner1.png'),
                  _BannerItem(imageUrl: 'https://example.com/banner2.png'),
                  _BannerItem(imageUrl: 'https://example.com/banner3.png'),
                ],
              ),
            ),

            // 2) 카테고리 탭 (가로 스크롤)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: Text('추천', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(child: Text('발매정보')),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(child: Text('랭킹')),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(child: Text('럭셔리')),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(child: Text('남성')),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(child: Text('여성')),
                  ),
                  // 등등...
                ],
              ),
            ),

            // 3) 원형 아이콘 메뉴(가로 스크롤) - KREAM DRAW, etc.
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _CircleCategory(
                    iconUrl: 'https://example.com/draw.png',
                    label: 'KREAM DRAW',
                  ),
                  _CircleCategory(
                    iconUrl: 'https://example.com/recommend.png',
                    label: '추천',
                  ),
                  _CircleCategory(
                    iconUrl: 'https://example.com/price.png',
                    label: '정가 아래',
                  ),
                  // ...
                ],
              ),
            ),

            // 4) 상품 목록 (예시)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  _ProductCard(
                    imageUrl: 'https://example.com/product1.png',
                    name: 'Nike XYZ',
                    price: 299000,
                  ),
                  _ProductCard(
                    imageUrl: 'https://example.com/product2.png',
                    name: 'Adidas ABC',
                    price: 199000,
                  ),
                  // ...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 아래는 임시 예시용 위젯들
class _BannerItem extends StatelessWidget {
  final String imageUrl;
  const _BannerItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl, fit: BoxFit.cover);
  }
}

class _CircleCategory extends StatelessWidget {
  final String iconUrl;
  final String label;
  const _CircleCategory({Key? key, required this.iconUrl, required this.label})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(iconUrl)),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int price;
  const _ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl, width: 50, height: 50),
      title: Text(name),
      subtitle: Text('₩$price'),
      onTap: () {
        // 상품 상세로 이동
      },
    );
  }
}
