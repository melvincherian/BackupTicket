// import 'package:backup_ticket/views/auth/otp_screen.dart';
// import 'package:flutter/material.dart';
// import 'login_screen.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _referralController = TextEditingController();
//   final _passwordController = TextEditingController();

//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _handleSignup() {
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Account created!"),
//           backgroundColor: Colors.green,
//         ),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const OtpScreen()),
//       );
//     }
//   }

//   String? _validateName(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your name';
//     }
//     if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value.trim())) {
//       return 'Name should contain only alphabets';
//     }
//     return null;
//   }

//   String? _validatePhone(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter mobile number';
//     }
//     if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
//       return 'Enter a valid 10-digit number';
//     }
//     return null;
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Enter email';
//     }
//     if (!RegExp(r'^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$')
//         .hasMatch(value.trim())) {
//       return 'Enter valid email';
//     }
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Enter password';
//     }
//     if (value.trim().length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Image.asset('assets/logintopimage.png'),

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 40),

//                     const Text(
//                       'Enter Your Details',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       'One step closer to great details on ticket',
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                     const SizedBox(height: 50),

//                     const Text(
//                       'SignUp',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),

//                     const SizedBox(height: 30),

//                     // NAME
//                     const Text('Name',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 8),
//                     _inputField(
//                       controller: _nameController,
//                       validator: _validateName,
//                       icon: Icons.person,
//                       hint: "Enter your name",
//                     ),
//                     const SizedBox(height: 15),

//                     // PHONE
//                     const Text('Mobile Number',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 8),
//                     _inputField(
//                       controller: _phoneController,
//                       validator: _validatePhone,
//                       icon: Icons.phone,
//                       hint: "Enter your mobile number",
//                       keyboard: TextInputType.phone,
//                     ),
//                     const SizedBox(height: 15),

//                     // EMAIL
//                     const Text('E-mail',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 8),
//                     _inputField(
//                       controller: _emailController,
//                       validator: _validateEmail,
//                       icon: Icons.email,
//                       hint: "Enter your email",
//                       keyboard: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 15),

//                     // REFERRAL
//                     const Text('Referral Code (Optional)',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 8),
//                     _inputField(
//                       controller: _referralController,
//                       icon: Icons.card_giftcard,
//                       hint: "Enter referral code",
//                     ),
//                     const SizedBox(height: 15),

//                     // PASSWORD
//                     const Text('Password',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 8),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade300),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: TextFormField(
//                         controller: _passwordController,
//                         validator: _validatePassword,
//                         obscureText: _obscurePassword,
//                         decoration: InputDecoration(
//                           hintText: "Enter your password",
//                           prefixIcon:
//                               Icon(Icons.lock, color: Colors.grey.shade500),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Colors.grey.shade500,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                           ),
//                           border: InputBorder.none,
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 16),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 30),

//                     // BUTTON
//                     _gradientButton(
//                       title: "Let's Go",
//                       onPressed: _handleSignup,
//                     ),

//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),

//               Image.asset('assets/loginbottom.png'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Reusable input field UI
//   Widget _inputField({
//     required TextEditingController controller,
//     required String hint,
//     IconData? icon,
//     TextInputType? keyboard,
//     String? Function(String?)? validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: TextFormField(
//         controller: controller,
//         validator: validator,
//         keyboardType: keyboard,
//         decoration: InputDecoration(
//           hintText: hint,
//           prefixIcon: Icon(icon, color: Colors.grey.shade500),
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         ),
//       ),
//     );
//   }

//   // Gradient Button
//   Widget _gradientButton({required String title, required VoidCallback onPressed}) {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ElevatedButton(
//           onPressed: onPressed,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             shadowColor: Colors.transparent,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             elevation: 0,
//           ),
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

















import 'package:backup_ticket/provider/auth/register_provider.dart';
import 'package:backup_ticket/views/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _referralController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _referralController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final success = await authProvider.register(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
        referralCode: _referralController.text.trim(),
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration successful! OTP sent."),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to OTP screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  OtpScreen(number: _phoneController.text,token: authProvider.registerResponse!.token,)),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value.trim())) {
      return 'Name should contain only alphabets';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter mobile number';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
      return 'Enter a valid 10-digit number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter email';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(value.trim())) {
      return 'Enter valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter password';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value.trim() != _passwordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/logintopimage.png'),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),

                            const Text(
                              'Enter Your Details',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'One step closer to great details on ticket',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            const SizedBox(height: 50),

                            const Text(
                              'SignUp',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 30),

                            // FIRST NAME
                            const Text('First Name',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _inputField(
                              controller: _firstNameController,
                              validator: _validateName,
                              icon: Icons.person,
                              hint: "Enter your first name",
                            ),
                            const SizedBox(height: 15),

                            // LAST NAME
                            const Text('Last Name',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _inputField(
                              controller: _lastNameController,
                              validator: _validateName,
                              icon: Icons.person_outline,
                              hint: "Enter your last name",
                            ),
                            const SizedBox(height: 15),

                            // PHONE
                            const Text('Mobile Number',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _inputField(
                              controller: _phoneController,
                              validator: _validatePhone,
                              icon: Icons.phone,
                              hint: "Enter your mobile number",
                              keyboard: TextInputType.phone,
                            ),
                            const SizedBox(height: 15),

                            // EMAIL
                            const Text('E-mail',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _inputField(
                              controller: _emailController,
                              validator: _validateEmail,
                              icon: Icons.email,
                              hint: "Enter your email",
                              keyboard: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 15),

                            // REFERRAL
                            const Text('Referral Code (Optional)',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _inputField(
                              controller: _referralController,
                              icon: Icons.card_giftcard,
                              hint: "Enter referral code",
                            ),
                            const SizedBox(height: 15),

                            // PASSWORD
                            const Text('Password',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                validator: _validatePassword,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.grey.shade500),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey.shade500,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // CONFIRM PASSWORD
                            const Text('Confirm Password',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                validator: _validateConfirmPassword,
                                obscureText: _obscureConfirmPassword,
                                decoration: InputDecoration(
                                  hintText: "Confirm your password",
                                  prefixIcon:
                                      Icon(Icons.lock_outline, color: Colors.grey.shade500),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey.shade500,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirmPassword = !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // BUTTON
                            _gradientButton(
                              title: "Let's Go",
                              onPressed: authProvider.isLoading ? () {} : _handleSignup,
                            ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),

                      Image.asset('assets/loginbottom.png'),
                    ],
                  ),
                ),
              ),
              
              // Loading Indicator
              if (authProvider.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // Reusable input field UI
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    TextInputType? keyboard,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey.shade500),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  // Gradient Button
  Widget _gradientButton({required String title, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
