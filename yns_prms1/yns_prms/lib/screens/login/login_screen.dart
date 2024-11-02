import 'package:flutter/material.dart';
import 'package:yns_prms/screens/login/app_colors.dart';
import 'package:yns_prms/screens/login/app_styles.dart';
import 'package:yns_prms/screens/login/app_icons.dart';
import 'package:yns_prms/screens/login/responsive_widget.dart';
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
    // get input values
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // create user instance
    User user = User.loginCons(username: username, password: password);

    // Call login method and display result
    String result = await userController.login(user);

    // Show a snackbar with the result
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
        duration: const Duration(seconds: 3),
      ),
    );
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
                            // Email input
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
                                  prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(AppIcons.emailIcon),
                                  ),
                                  contentPadding: const EdgeInsets.only(top: 16.0),
                                  hintText: 'Enter Username',
                                  hintStyle: GoogleFonts.raleway(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkBrownColor.withOpacity(0.5),
                                    fontSize: 12.0,
                                  ),
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
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(AppIcons.eyeIcon),
                                  ),
                                  prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(AppIcons.lockIcon),
                                  ),
                                  contentPadding: const EdgeInsets.only(top: 16.0),
                                  hintText: 'Enter Password',
                                  hintStyle: GoogleFonts.raleway(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkBrownColor.withOpacity(0.5),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.raleway(
                                    fontSize: 12.0,
                                    color: Colors.lightGreen,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12.0),
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
