import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:flutter_getx_boilerplate/shared/utils/size_config.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() {
  runApp(MaterialApp(
    home: RegisterScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = false;
  bool isPasswordWrong = false;
  bool isEmailValid = true;

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void handleLogin() {
    setState(() {
      isEmailValid = validateEmail(emailController.text);
      if (!isEmailValid) return;

      if (passwordController.text != "123456") {
        isPasswordWrong = true;
      } else {
        isPasswordWrong = false;
      }
      // Dummy validation
      if (passwordController.text != "123456") {
        isPasswordWrong = true;
      } else {
        isPasswordWrong = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
    resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 56.h),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                controller: emailController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.withValues(alpha: 0.2),
                  filled: true,
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  ),
                  suffixIcon: isEmailValid
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.error, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: isEmailValid
                        ? const BorderSide(color: Colors.grey)
                        : const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              if (!isEmailValid)
                Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: Text(
                    '*Please enter a valid email',
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
              SizedBox(height: 16.h),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: passwordController,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  fillColor: Colors.grey.withValues(alpha: 0.2),
                  filled: true,
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    child: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: isPasswordWrong
                        ? const BorderSide(color: Colors.red)
                        : const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              if (isPasswordWrong)
                Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: Text(
                    '*The password you entered is wrong',
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.h),
                    child: const Text(
                      "OR",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20.h),
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 8.h),
              SignInButton(
                Buttons.AppleDark,
                text: "Sign in with Apple",
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 8.h),
              SignInButton(
                Buttons.Facebook,
                text: "Sign in with Facebook",
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
