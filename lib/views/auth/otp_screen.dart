// import 'package:backup_ticket/views/auth/signup_screen.dart';
// import 'package:flutter/material.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});
 
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }

//   void _onChanged(String value, int index) {
//     if (value.isNotEmpty && index < 3) {
//       _focusNodes[index + 1].requestFocus();
//     }
//     if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true, 
//       body: SafeArea(
//         child: SingleChildScrollView( 
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
//             ),
//             child: IntrinsicHeight(
//               child: Column(
//                 children: [
//                   Flexible(
//                     flex: 2,
//                     child: Container(
//                       constraints: const BoxConstraints(maxHeight: 200),
//                       child: Image.asset(
//                         'assets/logintopimage.png',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
                  
//                   Flexible(
//                     flex: 3,
//                     child: Padding(
//                       padding: const EdgeInsets.all(24.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const SizedBox(height: 20),
                          
//                           // Title
//                           const Text(
//                             'Verify your\nnumber',
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                               height: 1.2,
//                             ),
//                           ),
                          
//                           const SizedBox(height: 20),
                          
//                           // Subtitle
//                           const Text(
//                             'Enter the code we sent to the number',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
                          
//                           const SizedBox(height: 8),
                          
//                           // Phone number
//                           const Text(
//                             '123xxxxxx1233',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
                          
//                           const SizedBox(height: 30),
                          
//                           // OTP Input Fields
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: List.generate(4, (index) {
//                               return Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[100],
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: Colors.grey[300]!,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: TextField(
//                                   controller: _controllers[index],
//                                   focusNode: _focusNodes[index],
//                                   keyboardType: TextInputType.number,
//                                   textAlign: TextAlign.center,
//                                   maxLength: 1,
//                                   style: const TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     counterText: '',
//                                     border: InputBorder.none,
//                                   ),
//                                   onChanged: (value) => _onChanged(value, index),
//                                 ),
//                               );
//                             }),
//                           ),
                          
//                           const SizedBox(height: 20),
                          
//                           // Resend code link
//                           Row(
//                             children: [
//                               const Text(
//                                 "Didn't receive your code? ",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
//                                 },
//                                 child: const Text(
//                                   'Resend',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Color(0xFF4A90E2),
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
                  

//                   SizedBox(height: 130,),
//                   Flexible(
//                     flex: 1,
//                     child: Container(
//                       constraints: const BoxConstraints(maxHeight: 170),
//                       child: Image.asset(
//                         'assets/loginbottom.png',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
















import 'package:backup_ticket/views/auth/signup_screen.dart';
import 'package:backup_ticket/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String?number;
  const OtpScreen({super.key,this.number});
 
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    
    // Check if all fields are filled and verify OTP
    if (value.isNotEmpty && index == 3) {
      _verifyOTP();
    }
  }

  void _verifyOTP() {
    String enteredOTP = _controllers.map((controller) => controller.text).join();
    
    if (enteredOTP.length == 4) {
      if (enteredOTP == "1234") {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP verified successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate to navbar screen after a short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavbarScreen(),
              ),
            );
          }
        });
      } else {
        // Show error message for wrong OTP
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid OTP. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
        
        // Clear all fields
        for (var controller in _controllers) {
          controller.clear();
        }
        
        // Focus on first field
        _focusNodes[0].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        child: SingleChildScrollView( 
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: Image.asset(
                        'assets/logintopimage.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          
                          // Title
                          const Text(
                            'Verify your\nnumber',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 1.2,
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Subtitle
                          const Text(
                            'Enter the code we sent to the number',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Phone number
                           Text(
                        '${widget.number}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          
                          const SizedBox(height: 30),
                          
                          // OTP Input Fields
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(4, (index) {
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                child: TextField(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) => _onChanged(value, index),
                                ),
                              );
                            }),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Info text for demo
                          // const Center(
                          //   child: Text(
                          //     'Enter 1234 to verify',
                          //     style: TextStyle(
                          //       fontSize: 14,
                          //       color: Colors.blue,
                          //       fontStyle: FontStyle.italic,
                          //     ),
                          //   ),
                          // ),
                          
                          const SizedBox(height: 20),
                          
                          // Resend code link
                          Row(
                            children: [
                              const Text(
                                "Didn't receive your code? ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => const SignupScreen()
                                    )
                                  );
                                },
                                child: const Text(
                                  'Resend',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4A90E2),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 130),
                  
                  Flexible(
                    flex: 1,
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 170),
                      child: Image.asset(
                        'assets/loginbottom.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}