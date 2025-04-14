import 'package:flutter/material.dart';
// Import các file cần thiết khác, ví dụ màn hình chính của bạn
import 'package:buoi8/auth_screen.dart'; // Thay 'buoi8' bằng tên package của bạn nếu khác
import 'package:buoi8/constants.dart';

// Đây là điểm khởi đầu BẮT BUỘC
void main() {
  // Hàm runApp() dùng để khởi chạy Widget gốc của ứng dụng
  runApp(MyApp()); // MyApp là widget gốc chứa MaterialApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          // Cấu hình theme cho TextField ở đây
          filled: true,
          fillColor: Colors.white38,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          contentPadding: EdgeInsets.symmetric(
              vertical: defaultPadding * 1.2, horizontal: defaultPadding),
        ),
      ),
      home: AuthScreen(), // AuthScreen là màn hình chứa Stack và các form của bạn
    );
  }
}