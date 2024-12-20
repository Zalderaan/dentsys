import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:dentsys_client/screens/login/app_colors.dart';
//import 'package:dentsys_client/screens/login/app_styles.dart';
//import 'package:dentsys_client/screens/login/app_icons.dart';
import 'package:dentsys_client/screens/login/responsive_widget.dart';
import 'package:google_fonts/google_fonts.dart';
// users imports
import '../../controllers/user_controller.dart'; 
import '../../models/user_model.dart';
import '../../services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final UserController userController;
  bool _isPasswordVisible = false;
  String? _usernameError; // Error message for username
  String? _passwordError; // Error message for password

  @override
  void initState() {
    super.initState();
    final userService = UserService();
    userController = UserController(userService);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _usernameError = null;
      _passwordError = null;
    });

    if (username.isEmpty) {
      setState(() {
        _usernameError = "Username cannot be empty.";
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = "Password cannot be empty.";
      });
      return;
    }

    User user = User.loginCons(username: username, password: password);
    String result = await userController.login(user);

    try {
      if (result == 'User logged in: $username') {
        Navigator.pushNamed(context, '/dashboard');
        
        AnimatedSnackBar.material(
          'Welcome, $username! You have logged in successfully.',
          type: AnimatedSnackBarType.success,
          duration: const Duration(seconds: 3),
        ).show(context);
      } else {
        setState(() {
          _usernameError = "Invalid username or password.";
          _passwordError = "Invalid username or password.";
        });

        AnimatedSnackBar.material(
          'Login failed: Invalid username or password.',
          type: AnimatedSnackBarType.error,
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    } catch (error) {
      AnimatedSnackBar.material(
        'An unexpected error occurred: $error',
        type: AnimatedSnackBarType.error,
        duration: const Duration(seconds: 5),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResponsiveWidget.isSmallScreen(context) ? const SizedBox() : Expanded(
              child: Container(
                height: height,
                color: AppColors.mainBrownColor,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'YNS Dental Care',
                        style: GoogleFonts.raleway(
                          fontSize: 48.0,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Image.asset(
                        'assets/images/YNS Logo1.png',
                        width: 400.0,
                        height: 400.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: AppColors.darkBrownColor,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  width: width * 0.4, // Adjust width as necessary
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Outer Container with text and header
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Let’s Log In',
                            style: GoogleFonts.raleway(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Enter your details to log in to your account.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.goldColor,
                            ),
                          ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                      // Inner container with input fields
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.backColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Username input
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Username',
                                style: GoogleFonts.raleway(
                                  fontSize: 16.0,
                                  color: AppColors.darkBrownColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Container(
                              height: 50.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: AppColors.whiteColor,
                              ),
                              child: TextFormField(
                                controller: _usernameController, // set controller
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.darkBrownColor,
                                  fontSize: 12.0,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.person, color: AppColors.darkBrownColor),
                                  contentPadding: const EdgeInsets.only(top: 16.0),
                                  hintText: 'Enter Username',
                                  hintStyle: GoogleFonts.raleway(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkBrownColor.withOpacity(0.5),
                                    fontSize: 12.0,
                                  ),
                                 // errorText: _usernameError, // Show error if any
                                ),
                              ),
                            ),
                            if (_usernameError != null) // Display error message below field
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                child: Text(
                                  _usernameError!,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16.0),
                            // Password input
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Password',
                                style: GoogleFonts.raleway(
                                  fontSize: 16.0,
                                  color: AppColors.darkBrownColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Container(
                              height: 50.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: AppColors.whiteColor,
                              ),
                              child: TextFormField(
                                controller: _passwordController, // set controller
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.darkBrownColor,
                                  fontSize: 12.0,
                                ),
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.lock, color: AppColors.darkBrownColor),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.darkBrownColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.only(top: 16.0),
                                  hintText: 'Enter Password',
                                  hintStyle: GoogleFonts.raleway(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkBrownColor.withOpacity(0.5),
                                    fontSize: 12.0,
                                  ),
                                  // errorText: _passwordError, // Show error if any
                                ),
                              ),
                            ),
                            if (_passwordError != null) // Display error message below field
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                child: Text(
                                  _passwordError!,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 24.0),
                          
                            // Sign In button
                            Center(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _handleLogin,
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Ink(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 12.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: AppColors.goldColor,
                                    ),
                                    child: Text(
                                      'Log In',
                                      style: GoogleFonts.raleway(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.whiteColor,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                    'Don"t Have Account?',
                                    style: GoogleFonts.raleway(
                                      fontSize: 12.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: Text(
                                    'Register',
                                    style: GoogleFonts.raleway(
                                      fontSize: 12.0,
                                      color: Colors.red[300],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
