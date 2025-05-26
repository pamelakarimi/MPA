import 'package:flutter/material.dart';
import '../themes/app_colors.dart'; // Importing your custom color theme
import 'home_page.dart'; // Page to go after login
import 'sign_up_page.dart'; // Page to go if user taps "Sign up"

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Key to identify the form and access form validation methods
  final _formKey = GlobalKey<FormState>();

  // Controllers to get the input from the fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            // Form holds all the fields that need validation
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  // Logo above the text fields
                  Image.asset('assets/images/logo.png', height: 100),
                  const SizedBox(height: 40),

                  // Email input field with validation
                  _buildTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required'; // If field is empty
                      }
                      // Check if email matches pattern
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null; // Valid input
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password input field with validation
                  _buildTextField(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: true, // Hides text for password
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Login button
                  ElevatedButton(
                    onPressed: () {
                      // If form is valid (passes all validator checks)
                      if (_formKey.currentState!.validate()) {
                        // Navigate to home page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkColor, // Custom dark color
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "Don't have an account?" with link to sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: greyColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to sign up page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignUpPage()),
                          );
                        },
                        child: const Text(
                          "Sign up here",
                          style: TextStyle(
                            color: darkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// A custom reusable text field builder with validator and controller
  Widget _buildTextField({
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller, // Handles text input
      obscureText: obscureText, // Obscures password if needed
      keyboardType: keyboardType, // Determines keyboard type
      validator: validator, // Validation logic passed from above
      style: const TextStyle(color: darkColor), // Text color inside input
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: greyColor), // Label color
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: darkColor, width: 2.0),
        ),
      ),
    );
  }
}
