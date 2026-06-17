import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_textfield.dart';
import '../admin/screens/admin_dashboard_screen.dart';
import 'forgot_password_screen.dart'; // Ensure this is imported

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final String demoEmail = "admin@college.edu";
  final String demoPassword = "Admin123";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      if (emailController.text == demoEmail && passwordController.text == demoPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Successful! Redirecting..."), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid credentials"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      height: 80, width: 80,
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
                      child: const Icon(Icons.school_rounded, color: Colors.blue, size: 40),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(child: Text("vSphere ERP", style: AppTextStyles.heading1)),
                  Center(child: Text("Access your institutional dashboard", style: AppTextStyles.bodySmall)),
                  const SizedBox(height: 32),

                  const Text("EMAIL OR USER ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: emailController,
                    hintText: "Enter your email",
                    prefixIcon: Iconsax.sms,
                    focusNode: emailFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(passwordFocus),
                  ),
                  const SizedBox(height: 20),

                  const Text("PASSWORD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    obscureText: obscurePassword,
                    validator: (val) => val!.isEmpty ? "Required" : null,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      prefixIcon: const Icon(Iconsax.lock),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => obscurePassword = !obscurePassword),
                        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                        );
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ),

                  const SizedBox(height: 12),
                  AppButton(text: "Sign In", onPressed: _handleSignIn),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}