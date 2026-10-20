import 'package:car_rental_system/widgets/custom_button.dart';
import 'package:car_rental_system/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main_nav_wrapper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool hidePassword = true;
  bool hideConfirm = true;
  bool terms = false;
  bool loading = false;

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  Future auth() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      message("Please fill all required fields");
      return;
    }

    if (!isLogin && name.text.isEmpty) {
      message("Please enter your name");
      return;
    }

    if (!isLogin && password.text != confirmPassword.text) {
      message("Passwords do not match");
      return;
    }

    if (!isLogin && !terms) {
      message("Please accept Terms & Conditions");
      return;
    }

    setState(() => loading = true);

    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );

        message("Account created successfully");
      }
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavWrapper()),
        );
      }
    } on FirebaseAuthException catch (e) {
      message(e.message ?? "Something went wrong");
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff080808),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(22),
          child: Column(
            children: [
              SizedBox(height: 25),
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: Color(0xffffc107),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.directions_car_filled_rounded,
                  size: 42,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 18),
              Text(
                isLogin ? "Welcome Back!" : "Create Account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 7),
              Text(
                isLogin
                    ? "Login and start your journey"
                    : "Join us and rent your dream car",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xff171717),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    CustomTabButton(
                      text: "Login",
                      selected: isLogin,
                      onTap: () {
                        setState(() {
                          isLogin = true;
                        });
                      },
                    ),
                    CustomTabButton(
                      text: "Sign Up",
                      selected: !isLogin,
                      onTap: () {
                        setState(() {
                          isLogin = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              if (!isLogin)
                CustomTextField(
                  controller: name,
                  hintText: "Full Name",
                  prefixIcon: Icons.person_outline,
                ),
              if (!isLogin) SizedBox(height: 14),
              CustomTextField(
                controller: email,
                hintText: "Email Address",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              if (!isLogin) SizedBox(height: 14),
              if (!isLogin)
                CustomTextField(
                  controller: phone,
                  hintText: "Phone Number",
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

              SizedBox(height: 14),

              CustomTextField(
                controller: password,
                hintText: "Password",
                prefixIcon: Icons.lock_outline,
                obscureText: hidePassword,
                suffixIcon: CustomIconButton(
                  icon: hidePassword ? Icons.visibility_off : Icons.visibility,
                  iconColor: Colors.grey,
                  size: 40,
                  iconSize: 20,
                  onTap: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),
              if (!isLogin) SizedBox(height: 14),
              if (!isLogin)
                CustomTextField(
                  controller: confirmPassword,
                  hintText: "Confirm Password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: hideConfirm,
                  suffixIcon: CustomIconButton(
                    icon: hideConfirm ? Icons.visibility_off : Icons.visibility,
                    iconColor: Colors.grey,
                    size: 40,
                    iconSize: 20,
                    onTap: () {
                      setState(() {
                        hideConfirm = !hideConfirm;
                      });
                    },
                  ),
                ),
              if (isLogin)
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    text: "Forgot Password?",
                    textColor: Color(0xffffc107),
                    onTap: () {
                      message("Forgot password clicked");
                    },
                  ),
                ),
              if (!isLogin)
                Row(
                  children: [
                    Checkbox(
                      value: terms,
                      activeColor: Color(0xffffc107),
                      onChanged: (value) {
                        setState(() {
                          terms = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "I agree to the Terms & Conditions",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 10),
              CustomElevatedButton(
                text: isLogin ? "LOGIN" : "CREATE ACCOUNT",
                onTap: loading ? null : auth,
                loading: loading,
                width: double.infinity,
                height: 55,
                radius: 15,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("OR", style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 18),
              CustomOutlinedButton(
                text: "Continue with Google",
                icon: Icons.g_mobiledata,
                onTap: () {
                  message("Google login clicked");
                },
                width: double.infinity,
                height: 52,
                radius: 14,
                borderColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              CustomTextButton(
                text: isLogin
                    ? "Don't have an account? Sign Up"
                    : "Already have an account? Login",
                textColor: Color(0xffffc107),
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainNavWrapper()),
                  );
                },
                icon: const Icon(Icons.explore_outlined, color: Colors.white70, size: 18),
                label: const Text(
                  'Explore App (Skip)',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
