import 'dart:math'; // Import thư viện math để dùng pi
import 'package:flutter/material.dart';
import 'package:buoi8/constants.dart';
import 'package:buoi8/widgets/login_form.dart';
import 'package:buoi8/widgets/sign_up_form.dart';
import 'package:buoi8/widgets/socal_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

// Thêm SingleTickerProviderStateMixin để sử dụng vsync cho AnimationController
class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false; // Biến trạng thái để biết đang hiển thị form nào

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate; // Animation cho việc xoay chữ

  void setUpAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: defaultDuration, // Sử dụng hằng số thời gian đã định nghĩa
    );

    // Tạo animation cho việc xoay chữ từ 0 độ đến 90 độ (hoặc ngược lại)
    // CurvedAnimation giúp hiệu ứng mượt hơn (ví dụ: easeInOut)
    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    // .animate(_animationController); // Hoặc không dùng Curve
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp; // Đảo trạng thái hiển thị
    });
    // Chạy animation tương ứng
    _isShowSignUp ? _animationController.forward() : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation(); // Khởi tạo animation controller
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Hủy controller khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size; // Lấy kích thước màn hình

    return Scaffold(
      // Sử dụng AnimatedBuilder để lắng nghe thay đổi của animation controller
      // và rebuild các widget phụ thuộc vào animation (ở đây là các Text xoay)
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              // ---- LOGIN FORM ----
              AnimatedPositioned(
                duration: defaultDuration, // Thời gian animation
                width: _size.width * 0.88, // Chiếm 88% chiều rộng
                height: _size.height,
                // Vị trí left thay đổi dựa trên trạng thái _isShowSignUp
                left: _isShowSignUp ? -_size.width * 0.76 : 0,
                child: Container(
                  color: login_bg, // Màu nền xanh lá
                  child: LoginForm(), // Widget form đăng nhập
                ),
              ),
              // ---- SIGNUP FORM ----
              AnimatedPositioned(
                duration: defaultDuration,
                height: _size.height,
                width: _size.width * 0.88,
                // Vị trí left thay đổi dựa trên trạng thái _isShowSignUp
                left: _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                child: Container(
                  color: signup_bg, // Màu nền xanh đậm
                  child: SignUpForm(), // Widget form đăng ký
                ),
              ),
              // ---- LOGO ----
              // Logo cũng di chuyển theo animation
              AnimatedPositioned(
                duration: defaultDuration,
                top: _size.height * 0.1, // Cách top 10%
                // Vị trí left thay đổi để giữ logo ở giữa phần form hiển thị
                left: 0,
                right: _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                // right: _isShowSignUp ? _size.width * 0.06 : _size.width * 0.06, // Vị trí right thay đổi
                child: AnimatedSwitcher( // Hiệu ứng chuyển đổi giữa 2 màu logo
                  duration: defaultDuration,
                  child: _isShowSignUp
                      ? SvgPicture.asset(
                    "assets/animation_logo.svg",
                    key: const ValueKey("signup"), // Key để AnimatedSwitcher biết widget nào thay đổi
                    height: 50, // Kích thước logo
                    color: signup_bg, // Màu logo theo form signup
                  )
                      : SvgPicture.asset(
                    "assets/animation_logo.svg",
                    key: const ValueKey("login"),
                    height: 50,
                    color: login_bg, // Màu logo theo form login
                  ),
                ),
              ),
              // ---- SOCIAL BUTTONS ----
              // Các nút social cũng di chuyển
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: _size.height * 0.1, // Cách bottom 10%
                width: _size.width,
                // Vị trí right thay đổi
                right: _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                child: SocalButtns(),
              ),
              // ---- LOGIN TEXT (XOAY) ----
              AnimatedPositioned(
                duration: defaultDuration,
                // Vị trí bottom và left thay đổi
                bottom: _isShowSignUp ? _size.height / 2 - 80 : _size.height * 0.3, // 80 = 160/2
                left: _isShowSignUp ? 0 : _size.width * 0.44, // 44% = (88/2)%
                child: AnimatedDefaultTextStyle( // Hiệu ứng thay đổi style chữ
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _isShowSignUp ? 20 : 32, // Thay đổi kích thước chữ
                    fontWeight: FontWeight.bold,
                    color: _isShowSignUp ? Colors.white : Colors.white.withOpacity(0.7), // Thay đổi màu/độ trong suốt
                  ),
                  child: Transform.rotate( // Widget để xoay chữ
                    angle: -_animationTextRotate.value * pi / 180, // Góc xoay dựa trên animation
                    alignment: Alignment.topLeft, // Điểm neo để xoay
                    child: InkWell( // Cho phép nhấn vào chữ
                      onTap: () {
                        if (_isShowSignUp) {
                          updateView(); // Chỉ gọi khi đang ở màn hình signup
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                        width: 160, // Chiều rộng cố định để căn giữa khi xoay
                        // color: Colors.red, // Bỏ màu debug
                        child: Text(
                          "Log In".toUpperCase(), // Chữ in hoa
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // ---- SIGN UP TEXT (XOAY) ----
              AnimatedPositioned(
                duration: defaultDuration,
                // Vị trí bottom và right thay đổi
                bottom: !_isShowSignUp ? _size.height / 2 - 80 : _size.height * 0.3,
                right: !_isShowSignUp ? 0 : _size.width * 0.44,
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: !_isShowSignUp ? 20 : 32,
                    fontWeight: FontWeight.bold,
                    color: !_isShowSignUp ? Colors.white : Colors.white.withOpacity(0.7),
                  ),
                  child: Transform.rotate(
                    angle: (90 - _animationTextRotate.value) * pi / 180, // Góc xoay ngược lại
                    alignment: Alignment.topRight, // Điểm neo để xoay
                    child: InkWell(
                      onTap: () {
                        if (!_isShowSignUp) {
                          updateView(); // Chỉ gọi khi đang ở màn hình login
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                        width: 160,
                        // color: Colors.red, // Bỏ màu debug
                        child: Text(
                          "Sign Up".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}