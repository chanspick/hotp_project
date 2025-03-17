// app.dart
import 'package:flutter/material.dart';
import 'screens/main_page.dart'; // 메인 탭 화면

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KREAM-like App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // 다른 테마 설정 (폰트, 색상, TextTheme 등) 추가 가능
      ),
      home: const MainPage(), // 앱 시작 시 표시할 화면
      // 만약 Named Route를 사용할 예정이라면, 아래와 같이 routes 추가 가능:
      // routes: {
      //   '/detail': (context) => const SomeDetailScreen(),
      //   '/login': (context) => const LoginScreen(),
      // },
    );
  }
}
