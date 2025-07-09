import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pos/core/components/components.dart';
import 'package:pos/core/components/custom_text_field.dart';
import 'package:pos/pages/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width * 0.9; // 80% dari lebar layar
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LoginViewmodel(),
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFB3E5FC), // biru muda
                    Color(0xFFE1F5FE), // lebih terang
                  ],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/component/blob-haikei1.png',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "LOGIN",
                                style: GoogleFonts.raleway(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 5,
                                ),
                              ),
                              SizedBox(height: 20),
                              _buildInputField(
                                hintText: 'Username',
                                icon: Icons.person,
                              ),
                              const SizedBox(height: 20),
                              _buildInputField(
                                hintText: 'Password',
                                icon: Icons.lock,
                                obscureText: true,
                              ),
                              const SizedBox(height: 30),
                              _buildLoginButton(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildInputField({
  required String hintText,
  required IconData icon,
  bool obscureText = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    ),
  );
}

Widget _buildLoginButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        // aksi login nanti taruh di sini
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login clicked")));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4A90E2), // biru soft
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );
}
