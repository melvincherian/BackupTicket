// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   bool showPasswordFields = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 const Text(
//                   "Forgot Password",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Enter your registered mobile number\nto reset your password",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//                 const SizedBox(height: 30),

//                 // ---- Card UI ----
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 25,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.15),
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.white.withOpacity(0.2)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 10,
//                         spreadRadius: 2,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // MOBILE FIELD
//                       const Text(
//                         "Mobile Number",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       _buildInputField(
//                         controller: mobileController,
//                         hint: "Enter mobile number",
//                         icon: Icons.phone_iphone,
//                         keyboard: TextInputType.number,
//                         maxLength: 10,
//                       ),

//                       const SizedBox(height: 15),

//                       // VERIFY BUTTON
//                       _primaryButton(
//                         label: "Verify",
//                         onTap: () {
//                           if (mobileController.text.length == 10) {
//                             setState(() => showPasswordFields = true);
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   "Please enter valid mobile number",
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       ),

//                       const SizedBox(height: 20),

//                       // ---- Animated Password Fields ----
//                       AnimatedSize(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                         child: showPasswordFields
//                             ? Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 10),
//                                   const Text(
//                                     "New Password",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   _buildInputField(
//                                     controller: newPasswordController,
//                                     hint: "Enter new password",
//                                     icon: Icons.lock_outline,
//                                     obscure: true,
//                                   ),
//                                   const SizedBox(height: 15),
//                                   const Text(
//                                     "Confirm Password",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   _buildInputField(
//                                     controller: confirmPasswordController,
//                                     hint: "Confirm password",
//                                     icon: Icons.lock_reset,
//                                     obscure: true,
//                                   ),
//                                   const SizedBox(height: 25),

//                                   // Reset Password Button
//                                   _primaryButton(
//                                     label: "Reset Password",
//                                     onTap: () {
//                                       if (newPasswordController.text ==
//                                           confirmPasswordController.text) {
//                                         ScaffoldMessenger.of(
//                                           context,
//                                         ).showSnackBar(
//                                           const SnackBar(
//                                             content: Text("Password Updated!"),
//                                           ),
//                                         );
//                                       } else {
//                                         ScaffoldMessenger.of(
//                                           context,
//                                         ).showSnackBar(
//                                           const SnackBar(
//                                             content: Text(
//                                               "Passwords do not match",
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               )
//                             : const SizedBox(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//     bool obscure = false,
//     TextInputType keyboard = TextInputType.text,
//     int? maxLength,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.25),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscure,
//         keyboardType: keyboard,
//         maxLength: maxLength, // <-- Apply max length
//         inputFormatters: [
//           if (keyboard == TextInputType.number)
//             FilteringTextInputFormatter.digitsOnly, // Allow only digits
//         ],
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           counterText: "", // <-- hides the character counter UI
//           prefixIcon: Icon(icon, color: Colors.white),
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(vertical: 14),
//         ),
//       ),
//     );
//   }

//   // ------------------ PRIMARY BUTTON ------------------
//   Widget _primaryButton({required String label, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14),
//           gradient: const LinearGradient(
//             colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//           ),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





















import 'package:backup_ticket/provider/forgot/forgot_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool showPasswordFields = false;

  @override
  void dispose() {
    mobileController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Consumer<PasswordProvider>(
              builder: (context, passwordProvider, child) {
                return Column(
                  children: [
                    const Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Enter your registered mobile number\nto reset your password",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 30),

                    // ---- Card UI ----
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // MOBILE FIELD
                          const Text(
                            "Mobile Number",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildInputField(
                            controller: mobileController,
                            hint: "Enter mobile number",
                            icon: Icons.phone_iphone,
                            keyboard: TextInputType.number,
                            maxLength: 10,
                          ),

                          const SizedBox(height: 15),

                          // Display error or success message
                          if (passwordProvider.errorMessage != null &&
                              !showPasswordFields)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                passwordProvider.errorMessage!,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                          if (passwordProvider.successMessage != null &&
                              !showPasswordFields)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                passwordProvider.successMessage!,
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                          // VERIFY BUTTON
                          _primaryButton(
                            label: "Verify",
                            onTap: passwordProvider.isLoading
                                ? () {}
                                : () async {
                                    if (mobileController.text.length == 10) {
                                      passwordProvider.clearMessages();
                                      final success = await passwordProvider
                                          .forgotPassword(mobileController.text);

                                      if (success && mounted) {
                                        setState(() => showPasswordFields = true);
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please enter valid mobile number",
                                          ),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                    }
                                  },
                            isLoading:
                                passwordProvider.isLoading && !showPasswordFields,
                          ),

                          const SizedBox(height: 20),

                          // ---- Animated Password Fields ----
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: showPasswordFields
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      const Text(
                                        "New Password",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      _buildInputField(
                                        controller: newPasswordController,
                                        hint: "Enter new password",
                                        icon: Icons.lock_outline,
                                        obscure: true,
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        "Confirm Password",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      _buildInputField(
                                        controller: confirmPasswordController,
                                        hint: "Confirm password",
                                        icon: Icons.lock_reset,
                                        obscure: true,
                                      ),
                                      const SizedBox(height: 15),

                                      // Display error or success message for reset
                                      if (passwordProvider.errorMessage != null)
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            passwordProvider.errorMessage!,
                                            style: const TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                      if (passwordProvider.successMessage != null)
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            passwordProvider.successMessage!,
                                            style: const TextStyle(
                                              color: Colors.greenAccent,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                      const SizedBox(height: 10),

                                      // Reset Password Button
                                      _primaryButton(
                                        label: "Reset Password",
                                        onTap: passwordProvider.isLoading
                                            ? () {}
                                            : () async {
                                                if (newPasswordController
                                                    .text.isEmpty ||
                                                    confirmPasswordController
                                                        .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Please fill all fields",
                                                      ),
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                    ),
                                                  );
                                                  return;
                                                }

                                                passwordProvider.clearMessages();

                                                if (passwordProvider.resetToken ==
                                                    null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Token not found. Please verify again.",
                                                      ),
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                    ),
                                                  );
                                                  return;
                                                }

                                                final success =
                                                    await passwordProvider
                                                        .resetPassword(
                                                  token:
                                                      passwordProvider.resetToken!,
                                                  newPassword:
                                                      newPasswordController.text,
                                                  confirmNewPassword:
                                                      confirmPasswordController
                                                          .text,
                                                );

                                                if (success && mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Password reset successfully!",
                                                      ),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  );

                                                  // Navigate back to login after 2 seconds
                                                  Future.delayed(
                                                    const Duration(seconds: 2),
                                                    () {
                                                      if (mounted) {
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  );
                                                }
                                              },
                                        isLoading: passwordProvider.isLoading,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
    int? maxLength,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        maxLength: maxLength,
        inputFormatters: [
          if (keyboard == TextInputType.number)
            FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // ------------------ PRIMARY BUTTON ------------------
  Widget _primaryButton({
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: isLoading
                ? [Colors.grey.shade400, Colors.grey.shade500]
                : [const Color(0xFF214194), const Color(0xFF3F7EF3)],
          ),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}