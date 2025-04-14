import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Cần import SVG nếu dùng SVG

class SocalButtns extends StatelessWidget { // Đổi tên class cho đúng chuẩn Dart
  const SocalButtns({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          // Sử dụng Image.asset nếu bạn có file PNG
          icon: Image.asset("assets/fb.png", height: 40),
          // Hoặc SvgPicture.asset nếu bạn có file SVG
          // icon: SvgPicture.asset("assets/facebook.svg", height: 40),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset("assets/linkedin.png", height: 40),
          // icon: SvgPicture.asset("assets/linkedin.svg", height: 40),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset("assets/twitter.png", height: 40),
          // icon: SvgPicture.asset("assets/twitter.svg", height: 40),
        ),
      ],
    );
  }
}