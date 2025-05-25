import 'package:flutter/material.dart';
import 'search_screen.dart';  // SearchScreen을 import

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
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
            // Row overflow 방지: Expanded로 텍스트 감싸기
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "브랜드, 상품, 프로필, 태그 등",
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
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

class _BannerSection extends StatelessWidget {
  const _BannerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 실제 존재하는 이미지 URL로 대체하거나, 에러 핸들러 추가
    return SizedBox(
      height: 200,
      child: PageView(
        children: const [
          _BannerItem(imageUrl: 'https://via.placeholder.com/400x200?text=Banner1'),
          _BannerItem(imageUrl: 'https://via.placeholder.com/400x200?text=Banner2'),
          _BannerItem(imageUrl: 'https://via.placeholder.com/400x200?text=Banner3'),
        ],
      ),
    );
  }
}

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

class _CircleMenuSection extends StatelessWidget {
  const _CircleMenuSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': 'https://via.placeholder.com/48?text=Draw', 'label': 'KREAM DRAW'},
      {'icon': 'https://via.placeholder.com/48?text=추천', 'label': '추천'},
      {'icon': 'https://via.placeholder.com/48?text=정가', 'label': '정가 아래'},
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

class _ProductListSection extends StatelessWidget {
  const _ProductListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      {'img': 'https://via.placeholder.com/50?text=NK', 'name': 'Nike XYZ', 'price': 299000},
      {'img': 'https://via.placeholder.com/50?text=AD', 'name': 'Adidas ABC', 'price': 199000},
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

class _BannerItem extends StatelessWidget {
  final String imageUrl;
  const _BannerItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[300],
        alignment: Alignment.center,
        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
      ),
    );
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
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(iconUrl),
            backgroundColor: Colors.grey[200],
            onBackgroundImageError: (_, __) {},
          ),
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
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 50,
            height: 50,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image, color: Colors.grey),
          ),
        ),
      ),
      title: Text(name),
      subtitle: Text('₩${price.toString()}'),
      onTap: () {
        // TODO: 상품 상세 화면으로 이동
      },
    );
  }
}
