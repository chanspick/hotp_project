import 'package:flutter/material.dart';
import 'search_screen.dart';  // SearchScreen을 import

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 만약 하단 탭바가 있으니 AppBar만 있으면 됨
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // 검색 화면으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            );
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
            tooltip: '알림',
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            tooltip: '장바구니',
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          _BannerSection(),
          SizedBox(height: 16),
          _CategoryTabSection(),
          SizedBox(height: 16),
          _CircleMenuSection(),
          SizedBox(height: 16),
          _ProductListSection(),
        ],
      ),
    );
  }
}

// 1) 상단 배너
class _BannerSection extends StatelessWidget {
  const _BannerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView(
        children: const [
          _BannerItem(imageUrl: 'https://example.com/banner1.png'),
          _BannerItem(imageUrl: 'https://example.com/banner2.png'),
          _BannerItem(imageUrl: 'https://example.com/banner3.png'),
        ],
      ),
    );
  }
}

// 2) 카테고리 탭
class _CategoryTabSection extends StatelessWidget {
  const _CategoryTabSection({Key? key}) : super(key: key);

  final List<String> categories = const [
    '추천', '발매정보', '랭킹', '럭셔리', '남성', '여성'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (ctx, i) => Center(
          child: Text(
            categories[i],
            style: const TextStyle(fontSize: 16),
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: categories.length,
      ),
    );
  }
}

// 3) 원형 아이콘 메뉴
class _CircleMenuSection extends StatelessWidget {
  const _CircleMenuSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': 'https://example.com/draw.png', 'label': 'KREAM DRAW'},
      {'icon': 'https://example.com/recommend.png', 'label': '추천'},
      {'icon': 'https://example.com/price.png', 'label': '정가 아래'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: items.length,
        itemBuilder: (ctx, i) => _CircleCategory(
          iconUrl: items[i]['icon']!,
          label: items[i]['label']!,
        ),
      ),
    );
  }
}

// 4) 상품 리스트
class _ProductListSection extends StatelessWidget {
  const _ProductListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      {'img': 'https://example.com/product1.png', 'name': 'Nike XYZ', 'price': 299000},
      {'img': 'https://example.com/product2.png', 'name': 'Adidas ABC', 'price': 199000},
    ];

    return Column(
      children: products.map((p) {
        return _ProductCard(
          imageUrl: p['img'] as String,
          name: p['name'] as String,
          price: p['price'] as int,
        );
      }).toList(),
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
      leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(name),
      subtitle: Text('₩${price.toString()}'),
      onTap: () {
        // TODO: 상품 상세 화면으로 이동
      },
    );
  }
}
