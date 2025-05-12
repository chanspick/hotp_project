import 'package:flutter/material.dart';

class Part {
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final int likes;
  final List<double> priceHistory;

  Part({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.likes,
    required this.priceHistory,
  });
}

class PartShopScreen extends StatefulWidget {
  const PartShopScreen({Key? key}) : super(key: key);

  @override
  _PartShopScreenState createState() => _PartShopScreenState();
}

class _PartShopScreenState extends State<PartShopScreen> {
  String _selectedCategory = 'All';
  String _selectedSort = '인기순';
  final TextEditingController _searchController = TextEditingController();

  final List<Part> _products = [
    Part(
      name: 'RTX 4090 Founders Edition',
      category: 'GPU',
      price: 2090000,
      imageUrl: 'https://example.com/gpu1.jpg',
      likes: 142,
      priceHistory: [2100000, 2080000, 2090000],
    ),
    Part(
      name: 'Ryzen 9 7950X',
      category: 'CPU',
      price: 789000,
      imageUrl: 'https://example.com/cpu1.jpg',
      likes: 89,
      priceHistory: [800000, 790000, 789000],
    ),
    // 추가 제품 데이터...
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _products
        .where((product) => _selectedCategory == 'All' ||
        product.category == _selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('부품 Shop'),
        actions: [
          IconButton(icon: const Icon(Icons.tune), onPressed: _showAdvancedFilter),
        ],
      ),
      body: Column(
        children: [
          _buildFilterRow(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) => _buildProductItem(filteredProducts[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                items: ['All', 'CPU', 'GPU', 'RAM', 'SSD', 'Cooler']
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value!),
              ),
            ),
          ),
          const VerticalDivider(width: 20),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSort,
                items: ['인기순', '가격 높은순', '가격 낮은순', '최신등록순']
                    .map((sort) => DropdownMenuItem(
                  value: sort,
                  child: Text(sort),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedSort = value!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(Part product) {
    return GestureDetector(
      onTap: () => _showProductDetail(product),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        product.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(0)}원',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.favorite_border, size: 16),
                          const SizedBox(width: 4),
                          Text('${product.likes}'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: CustomPaint(
                      painter: _PriceGraphPainter(product.priceHistory),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAdvancedFilter() {
    // 고급 필터링 다이얼로그 구현
  }

  void _showProductDetail(Part product) {
    // 상세 페이지 네비게이션 구현
  }
}

class _PriceGraphPainter extends CustomPainter {
  final List<double> priceHistory;

  _PriceGraphPainter(this.priceHistory);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final xStep = size.width / (priceHistory.length - 1);
    final maxPrice = priceHistory.reduce((a, b) => a > b ? a : b);
    final minPrice = priceHistory.reduce((a, b) => a < b ? a : b);
    final priceRange = maxPrice - minPrice;

    for (var i = 0; i < priceHistory.length; i++) {
      final x = xStep * i;
      final y = size.height - ((priceHistory[i] - minPrice) / priceRange) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
