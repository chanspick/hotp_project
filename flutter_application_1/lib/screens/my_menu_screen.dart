import 'package:flutter/material.dart';

class MyMenuScreen extends StatelessWidget {
  const MyMenuScreen({Key? key}) : super(key: key);

  // 예시: 로그인 여부 (실제 앱에서는 Provider 등 상태관리 사용)
  final bool isLoggedIn = true; // 임시로 true로 설정

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MY')),
      body: isLoggedIn ? _buildLoggedInMenu(context) : _buildLoggedOutMenu(context),
    );
  }

  // 로그인된 경우 메뉴
  Widget _buildLoggedInMenu(BuildContext context) {
    return ListView(
      children: [
        _buildUserHeader(),
        const Divider(),
        _buildMenuItem(
          icon: Icons.shopping_bag,
          title: '내 매물',
          onTap: () {
            // 내 매물 화면 이동
          },
        ),
        _buildMenuItem(
          icon: Icons.favorite,
          title: '관심 상품',
          onTap: () {
            // 관심 상품 화면 이동
          },
        ),
        _buildMenuItem(
          icon: Icons.settings,
          title: '설정',
          onTap: () {
            // 설정 화면 이동
          },
        ),
        _buildMenuItem(
          icon: Icons.logout,
          title: '로그아웃',
          onTap: () {
            // 로그아웃 처리
          },
        ),
      ],
    );
  }

  // 로그인 안된 경우
  Widget _buildLoggedOutMenu(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.login),
        label: const Text('로그인 하러가기'),
        onPressed: () {
          // 로그인 화면 이동
        },
      ),
    );
  }

  // 사용자 정보 헤더 (예시)
  Widget _buildUserHeader() {
    return UserAccountsDrawerHeader(
      accountName: const Text('홍길동'),
      accountEmail: const Text('hong@sample.com'),
      currentAccountPicture: const CircleAvatar(
        backgroundImage: AssetImage('assets/profile.png'), // 예시 이미지
      ),
    );
  }

  // 메뉴 아이템 생성 함수
  Widget _buildMenuItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
