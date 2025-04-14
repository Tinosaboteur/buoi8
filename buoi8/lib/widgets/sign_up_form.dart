import 'package:flutter/material.dart';
import 'package:buoi8/constants.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bọc toàn bộ nội dung bằng Scaffold riêng
    return Scaffold(
      backgroundColor: Colors.transparent, // Quan trọng: Để nền trong suốt
      body: SingleChildScrollView( // Cho phép cuộn
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.13),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung theo chiều dọc
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2), // Điều chỉnh khoảng trống nếu cần
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2), // Điều chỉnh khoảng trống nếu cần
              ],
            ),
          ),
        ),
      ),
    );
  }
}