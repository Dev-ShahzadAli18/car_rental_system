import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/custom_button.dart';
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

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  bool _inputsAreValid() {
    if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
      showMessage("Please fill all required fields");
      return false;
    }

    if (isLogin) {
      return true;
    }

    if (name.text.trim().isEmpty) {
      showMessage("Please enter your name");
      return false;
    }

    if (password.text != confirmPassword.text) {
      showMessage("Passwords do not match");
      return false;
    }

    if (!terms) {
      showMessage("Please accept Terms & Conditions");
      return false;
    }

    return true;
  }

  Future<void> signInOrSignUp() async {
    if (!_inputsAreValid()) {
      return;
    }

    setState(() => loading = true);

    String? errorMessage;
    if (isLogin) {
      errorMessage = await AuthService.signIn(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } else {
      errorMessage = await AuthService.signUp(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      if (errorMessage == null) {
        showMessage("Account created successfully");
      }
    }

    if (errorMessage != null) {
      showMessage(errorMessage);
    } else if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavWrapper()),
      );
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: AppColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ResponsiveContentWrapper(
          maxWidth: Responsive.maxFormWidth,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Branded App Logo
                Container(
                  height: 76,
                  width: 76,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.directions_car_filled_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Heading & Subtitle
                Text(
                  isLogin ? "Welcome Back!" : "Create Account",
                  style: AppTextStyles.headingMedium.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isLogin
                      ? "Login and start your journey"
                      : "Join us and rent your dream car",
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 26),

                // Modern Segmented Tab Switcher
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF1F4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CustomTabButton(
                        text: "Login",
                        selected: isLogin,
                        selectedColor: AppColors.primaryDark,
                        selectedTextColor: Colors.white,
                        textColor: AppColors.textSecondary,
                        radius: 12,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        onTap: () {
                          setState(() {
                            isLogin = true;
                          });
                        },
                      ),
                      CustomTabButton(
                        text: "Sign Up",
                        selected: !isLogin,
                        selectedColor: AppColors.primaryDark,
                        selectedTextColor: Colors.white,
                        textColor: AppColors.textSecondary,
                        radius: 12,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        onTap: () {
                          setState(() {
                            isLogin = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // Form Fields
                if (!isLogin) ...[
                  AppInputField(
                    controller: name,
                    hint: "Full Name",
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 14),
                ],

                AppInputField(
                  controller: email,
                  hint: "Email Address",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),

                if (!isLogin) ...[
                  AppInputField(
                    controller: phone,
                    hint: "Phone Number",
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 14),
                ],

                AppInputField(
                  controller: password,
                  hint: "Password",
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: hidePassword,
                  suffixWidget: GestureDetector(
                    onTap: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    child: Icon(
                      hidePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                ),

                if (!isLogin) ...[
                  const SizedBox(height: 14),
                  AppInputField(
                    controller: confirmPassword,
                    hint: "Confirm Password",
                    prefixIcon: Icons.lock_outline_rounded,
                    obscureText: hideConfirm,
                    suffixWidget: GestureDetector(
                      onTap: () {
                        setState(() {
                          hideConfirm = !hideConfirm;
                        });
                      },
                      child: Icon(
                        hideConfirm
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                // Forgot Password link (Login mode)
                if (isLogin)
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        showMessage("Reset password link sent to your email");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Forgot Password?",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Terms & Conditions checkbox (Sign Up mode)
                if (!isLogin)
                  Row(
                    children: [
                      Checkbox(
                        value: terms,
                        activeColor: AppColors.primaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (value) {
                          setState(() {
                            terms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          "I agree to the Terms & Conditions",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 20),

                // Primary Submit Button
                CustomElevatedButton(
                  text: isLogin ? "LOGIN" : "CREATE ACCOUNT",
                  onTap: loading ? null : signInOrSignUp,
                  loading: loading,
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  width: double.infinity,
                  height: 54,
                  radius: 27,
                ),
                const SizedBox(height: 20),

                // Divider ("OR")
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.cardBorder, thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "OR",
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.cardBorder, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),

                // Continue with Google Button
                CustomOutlinedButton(
                  text: "Continue with Google",
                  icon: Icons.g_mobiledata_rounded,
                  onTap: () {
                    showMessage("Google sign in is currently in demo mode");
                  },
                  width: double.infinity,
                  height: 52,
                  radius: 26,
                  backgroundColor: Colors.white,
                  borderColor: AppColors.cardBorder,
                  foregroundColor: AppColors.textPrimary,
                  textStyle: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),

                // Switch Mode Prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin
                          ? "Don't have an account? "
                          : "Already have an account? ",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin ? "Sign Up" : "Login",
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Explore App (Skip)
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainNavWrapper()),
                    );
                  },
                  icon: const Icon(
                    Icons.explore_outlined,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  label: Text(
                    'Explore App (Skip)',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
