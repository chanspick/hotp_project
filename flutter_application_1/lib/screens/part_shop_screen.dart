import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore 패키지 import

// Part 클래스 정의 (기존과 동일, createdAt 타입 변경)
class Part {
  final String id; // Firestore 문서 ID
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final int likes;
  final List<double> priceHistory;
  final DateTime createdAt;

  Part({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.likes,
    required this.priceHistory,
    required this.createdAt,
  });

  // Firestore 데이터를 Part 객체로 변환하는 factory 생성자
  factory Part.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return Part(
      id: snapshot.id,
      name: data?['name'] ?? '',
      category: data?['category'] ?? '',
      price: (data?['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: data?['imageUrl'] ?? '',
      likes: (data?['likes'] as num?)?.toInt() ?? 0,
      priceHistory: (data?['priceHistory'] as List<dynamic>?)
          ?.map((item) => (item as num).toDouble())
          .toList() ??
          [],
      createdAt: (data?['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Part 객체를 Firestore 데이터로 변환하는 메소드 (데이터 추가/수정 시 사용)
  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "category": category,
      "price": price,
      "imageUrl": imageUrl,
      "likes": likes,
      "priceHistory": priceHistory,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }
}

class PartShopScreen extends StatefulWidget {
  const PartShopScreen({Key? key}) : super(key: key);

  @override
  _PartShopScreenState createState() => _PartShopScreenState();
}

class _PartShopScreenState extends State<PartShopScreen> {
  String _selectedCategory = 'All';
  String _selectedSort = '인기순';
  // final TextEditingController _searchController = TextEditingController(); // 검색 기능 구현 시 사용

  // Firestore 'parts' 컬렉션에 대한 참조
  final CollectionReference<Part> _partsCollection = FirebaseFirestore.instance
      .collection('parts')
      .withConverter<Part>(
    fromFirestore: Part.fromFirestore,
    toFirestore: (Part part, _) => part.toFirestore(),
  );

  Stream<List<Part>> _getPartsStream() {
    Query<Part> query = _partsCollection;

    // 카테고리 필터링 (Firestore 쿼리에서 직접 처리 가능)
    if (_selectedCategory != 'All') {
      query = query.where('category', isEqualTo: _selectedCategory);
    }

    // 정렬 (Firestore 쿼리에서 직접 처리 가능, 복합 색인 필요할 수 있음)
    // Firestore는 여러 필드에 대해 orderBy를 사용하려면 해당 복합 색인이 필요합니다.
    // 지금은 클라이언트 측 정렬을 유지하고, 추후 Firestore 쿼리로 최적화 가능.
    // 예: query = query.orderBy('likes', descending: true);

    return query.snapshots().map((snapshot) {
      List<Part> parts = snapshot.docs.map((doc) => doc.data()).toList();

      // 클라이언트 측 정렬 (Firestore 쿼리 정렬이 복잡할 경우 임시 사용)
      switch (_selectedSort) {
        case '가격 높은순':
          parts.sort((a, b) => b.price.compareTo(a.price));
          break;
        case '가격 낮은순':
          parts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case '인기순':
          parts.sort((a, b) => b.likes.compareTo(a.likes));
          break;
        case '최신등록순':
          parts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
      }
      return parts;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            child: StreamBuilder<List<Part>>(
              stream: _getPartsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('상품이 없습니다.'));
                }

                final products = snapshot.data!;

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      _buildProductItem(products[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    // DropdownButton UI (기존과 동일)
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
    // 상품 아이템 UI (기존과 동일, 이미지 errorBuilder 유지)
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
                      errorBuilder: (context, error, stackTrace) => Container( // 이미지 에러 시 플레이스홀더
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                        ),
                      ),
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
                        style: const TextStyle(color: Colors.white, fontSize: 12),
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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

// _PriceGraphPainter 클래스 (기존과 동일)
class _PriceGraphPainter extends CustomPainter {
  final List<double> priceHistory;

  _PriceGraphPainter(this.priceHistory);

  @override
  void paint(Canvas canvas, Size size) {
    if (priceHistory.isEmpty) return;
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (priceHistory.length < 2) { // 데이터 포인트가 1개 이하일 경우 점만 찍거나 아무것도 안 그림
      if (priceHistory.isNotEmpty) {
        final x = size.width / 2;
        final y = size.height / 2;
        canvas.drawCircle(Offset(x,y) , 2, paint..style = PaintingStyle.fill);
      }
      return;
    }

    final xStep = size.width / (priceHistory.length - 1);
    final maxPrice = priceHistory.reduce((a, b) => a > b ? a : b);
    final minPrice = priceHistory.reduce((a, b) => a < b ? a : b);
    final priceRange = maxPrice - minPrice == 0 ? 1 : maxPrice - minPrice;

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

