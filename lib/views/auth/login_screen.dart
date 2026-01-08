// import 'package:backup_ticket/provider/auth/login_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'signup_screen.dart';
// import 'forgot_password_screen.dart';
// import '../navbar/navbar_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   // PHONE VALIDATION
//   String? _validatePhone(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your mobile number';
//     }
//     if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
//       return 'Please enter a valid 10-digit mobile number';
//     }
//     return null;
//   }

//   // PASSWORD VALIDATION
//   String? _validatePassword(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your password';
//     }
//     return null;
//   }

//   void _onLoginPressed() async {
//     if (_formKey.currentState!.validate()) {
//       final authProvider = Provider.of<LoginProvider>(context, listen: false);

//       // Clear any previous errors
//       authProvider.clearError();

//       final success = await authProvider.login(
//         phoneNumber: _phoneController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

//       if (success && mounted) {
//         // Navigate to home screen on successful login
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => NavbarScreen()),
//         );
//       } else if (mounted && authProvider.errorMessage != null) {
//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(authProvider.errorMessage!),
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Consumer<LoginProvider>(
//         builder: (context, authProvider, child) {
//           return Stack(
//             children: [
//               SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Image.asset('assets/logintopimage.png'),

//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 40),

//                             const Text(
//                               'Welcome Back',
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             const Text(
//                               'Hey! Good to see you again',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                               ),
//                             ),

//                             const SizedBox(height: 50),

//                             const Text(
//                               'Login',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),

//                             const SizedBox(height: 30),

//                             // MOBILE NUMBER FIELD
//                             const Text(
//                               'Mobile Number',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: TextFormField(
//                                 controller: _phoneController,
//                                 validator: _validatePhone,
//                                 keyboardType: TextInputType.phone,
//                                 enabled: !authProvider.isLoading,
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter your Mobile Number',
//                                   hintStyle: TextStyle(
//                                     color: Colors.grey.shade500,
//                                     fontSize: 16,
//                                   ),
//                                   prefixIcon: Icon(
//                                     Icons.phone,
//                                     color: Colors.grey.shade500,
//                                   ),
//                                   border: InputBorder.none,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                     vertical: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 20),

//                             // PASSWORD FIELD
//                             const Text(
//                               'Password',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: TextFormField(
//                                 controller: _passwordController,
//                                 validator: _validatePassword,
//                                 obscureText: !_isPasswordVisible,
//                                 enabled: !authProvider.isLoading,
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter your password',
//                                   hintStyle: TextStyle(
//                                     color: Colors.grey.shade500,
//                                     fontSize: 16,
//                                   ),
//                                   prefixIcon: Icon(
//                                     Icons.lock,
//                                     color: Colors.grey.shade500,
//                                   ),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       _isPasswordVisible
//                                           ? Icons.visibility
//                                           : Icons.visibility_off,
//                                       color: Colors.grey.shade500,
//                                     ),
//                                     onPressed: authProvider.isLoading
//                                         ? null
//                                         : () {
//                                             setState(() {
//                                               _isPasswordVisible =
//                                                   !_isPasswordVisible;
//                                             });
//                                           },
//                                   ),
//                                   border: InputBorder.none,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                     vertical: 16,
//                                   ),
//                                 ),
//                               ),
//                               // child: TextFormField(
//                               //   controller: _passwordController,
//                               //   validator: _validatePassword,
//                               //   obscureText: true,
//                               //   enabled: !authProvider.isLoading,
//                               //   decoration: InputDecoration(
//                               //     hintText: 'Enter your password',
//                               //     hintStyle: TextStyle(
//                               //       color: Colors.grey.shade500,
//                               //       fontSize: 16,
//                               //     ),
//                               //     prefixIcon: Icon(
//                               //       Icons.lock,
//                               //       color: Colors.grey.shade500,
//                               //     ),
//                               //     border: InputBorder.none,
//                               //     contentPadding: const EdgeInsets.symmetric(
//                               //       horizontal: 16,
//                               //       vertical: 16,
//                               //     ),
//                               //   ),
//                               // ),
//                             ),

//                             SizedBox(height: 16),

//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 GestureDetector(
//                                   onTap: authProvider.isLoading
//                                       ? null
//                                       : () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const ForgotPasswordScreen(),
//                                             ),
//                                           );
//                                         },
//                                   child: Text(
//                                     'Forgot Password?',
//                                     style: TextStyle(
//                                       color: authProvider.isLoading
//                                           ? Colors.grey
//                                           : const Color(0xFF4A6CF7),
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(height: 30),

//                             // LOGIN BUTTON
//                             SizedBox(
//                               width: double.infinity,
//                               height: 56,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   gradient: const LinearGradient(
//                                     colors: [
//                                       Color(0xFF214194),
//                                       Color(0xFF3F7EF3),
//                                     ],
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                   ),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: ElevatedButton(
//                                   onPressed: authProvider.isLoading
//                                       ? null
//                                       : _onLoginPressed,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.transparent,
//                                     shadowColor: Colors.transparent,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     elevation: 0,
//                                     disabledBackgroundColor: Colors.transparent,
//                                   ),
//                                   child: authProvider.isLoading
//                                       ? const SizedBox(
//                                           height: 24,
//                                           width: 24,
//                                           child: CircularProgressIndicator(
//                                             color: Colors.white,
//                                             strokeWidth: 2.5,
//                                           ),
//                                         )
//                                       : const Text(
//                                           'Login',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 30),

//                             // GUEST LOGIN
//                             SizedBox(
//                               width: double.infinity,
//                               height: 56,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   gradient: const LinearGradient(
//                                     colors: [
//                                       Color(0xFF214194),
//                                       Color(0xFF3F7EF3),
//                                     ],
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                   ),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: ElevatedButton(
//                                   onPressed: authProvider.isLoading
//                                       ? null
//                                       : () {
//                                           Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   NavbarScreen(),
//                                             ),
//                                           );
//                                         },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.transparent,
//                                     shadowColor: Colors.transparent,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     elevation: 0,
//                                     disabledBackgroundColor: Colors.transparent,
//                                   ),
//                                   child: const Text(
//                                     'Guest Login',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 30),

//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text("Don't have an account? "),
//                                 GestureDetector(
//                                   onTap: authProvider.isLoading
//                                       ? null
//                                       : () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const SignupScreen(),
//                                             ),
//                                           );
//                                         },
//                                   child: Text(
//                                     'SignUp',
//                                     style: TextStyle(
//                                       color: authProvider.isLoading
//                                           ? Colors.grey
//                                           : const Color(0xFF4A6CF7),
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(height: 20),
//                           ],
//                         ),
//                       ),

//                       Image.asset('assets/loginbottom.png'),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
























  import 'package:backup_ticket/provider/auth/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import '../navbar/navbar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Enter mobile number';
    if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Invalid number';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    return null;
  }

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<LoginProvider>();
    final success = await provider.login(
      phoneNumber: _phoneController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NavbarScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final scale = (h / 800).clamp(0.85, 1.0);

    double sp(double v) => v * scale;
    double bh(double v) => v * scale;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: Consumer<LoginProvider>(
          builder: (context, auth, _) {
            return Column(
              children: [
                /// 🔼 TOP IMAGE
                Image.asset(
                  'assets/logintopimage.png',
                  height: bh(160),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                /// 🔽 CENTER (SCROLLS ONLY WHEN KEYBOARD OPENS)
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: sp(20)),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: sp(24)),

                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: sp(24),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: sp(4)),
                          Text(
                            'Hey! Good to see you again',
                            style: TextStyle(fontSize: sp(14)),
                          ),

                          SizedBox(height: sp(16)),

                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: sp(20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: sp(12)),

                          _label('Mobile Number', sp),
                          _inputBox(
                            height: bh(52),
                            child: TextFormField(
                              controller: _phoneController,
                              focusNode: _phoneFocus,
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              validator: _validatePhone,
                              onChanged: (v) {
                                if (v.length == 10) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocus);
                                }
                              },
                              decoration: const InputDecoration(
                                counterText: '',
                                prefixIcon: Icon(Icons.phone),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          _label('Password', sp),
                          _inputBox(
                            height: bh(52),
                            child: TextFormField(
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              obscureText: !_isPasswordVisible,
                              validator: _validatePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible =
                                          !_isPasswordVisible;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(fontSize: sp(13)),
                              ),
                            ),
                          ),

                          _button(
                            height: bh(50),
                            text: 'Login',
                            onTap: _onLoginPressed,
                          ),

                          _button(
                            height: bh(50),
                            text: 'Guest Login',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NavbarScreen(),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: sp(8)),

                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(fontSize: sp(13)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: sp(13),
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF4A6CF7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: sp(24)),
                        ],
                      ),
                    ),
                  ),
                ),

                /// 🔽 BOTTOM IMAGE
                Image.asset(
                  'assets/loginbottom.png',
                  height: bh(120),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _label(String text, double Function(double) sp) => Padding(
        padding: EdgeInsets.only(bottom: sp(4)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: sp(13),
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  Widget _inputBox({required double height, required Widget child}) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _button({
    required double height,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
