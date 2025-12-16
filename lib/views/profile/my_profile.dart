// // ignore_for_file: deprecated_member_use

// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class MyProfile extends StatefulWidget {
//   const MyProfile({super.key});

//   @override
//   State<MyProfile> createState() => _MyProfileState();
// }

// class _MyProfileState extends State<MyProfile> {
//   final _formKey = GlobalKey<FormState>();

//   final _nameController = TextEditingController(text: 'Guest User');
//   final _phoneController = TextEditingController(text: '9876543210');
//   final _emailController =
//       TextEditingController(text: 'guest@example.com');

//   final ImagePicker _picker = ImagePicker();

//   File? _selectedImageFile;
//   Uint8List? _selectedImageBytes;

//   bool _isSaving = false;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   /// ================= IMAGE PICK =================
//   Future<void> _pickImage() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1024,
//         maxHeight: 1024,
//         imageQuality: 85,
//       );

//       if (pickedFile != null) {
//         if (kIsWeb) {
//           final bytes = await pickedFile.readAsBytes();
//           setState(() {
//             _selectedImageBytes = bytes;
//             _selectedImageFile = null;
//           });
//         } else {
//           setState(() {
//             _selectedImageFile = File(pickedFile.path);
//             _selectedImageBytes = null;
//           });
//         }
//       }
//     } catch (e) {
//       _showSnack('Failed to pick image');
//     }
//   }

//   /// ================= SAVE =================
//   Future<void> _handleSave() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isSaving = true);

//     await Future.delayed(const Duration(seconds: 1));

//     setState(() => _isSaving = false);

//     _showSnack('Profile updated successfully!', success: true);
//   }

//   /// ================= UI HELPERS =================
//   Widget _buildProfileImage() {
//     return Stack(
//       children: [
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade300, width: 2),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: _buildImageWidget(),
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: GestureDetector(
//             onTap: _pickImage,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF214194),
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white, width: 2),
//               ),
//               child:
//                   const Icon(Icons.camera_alt, color: Colors.white, size: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildImageWidget() {
//     if (_selectedImageBytes != null) {
//       return Image.memory(_selectedImageBytes!, fit: BoxFit.cover);
//     }

//     if (_selectedImageFile != null) {
//       return Image.file(_selectedImageFile!, fit: BoxFit.cover);
//     }

//     return Container(
//       color: Colors.grey[300],
//       child: const Icon(Icons.person, size: 40, color: Colors.grey),
//     );
//   }

//   /// ================= VALIDATIONS =================
//   String? _validateName(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your name';
//     }
//     if (value.trim().length < 2) {
//       return 'Name must be at least 2 characters';
//     }
//     return null;
//   }

//   String? _validatePhone(String? value) {
//     if (value == null || value.trim().length != 10) {
//       return 'Invalid mobile number';
//     }
//     return null;
//   }

//   String? _validateEmail(String? value) {
//     if (value == null ||
//         !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//             .hasMatch(value.trim())) {
//       return 'Invalid email address';
//     }
//     return null;
//   }

//   void _showSnack(String message, {bool success = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: success ? Colors.green : Colors.red,
//       ),
//     );
//   }

//   /// ================= BUILD =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         title: const Text(
//           'My Profile',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 Center(child: _buildProfileImage()),
//                 const SizedBox(height: 24),

//                 TextFormField(
//                   controller: _nameController,
//                   validator: _validateName,
//                   decoration: const InputDecoration(
//                     labelText: 'Full Name',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 TextFormField(
//                   controller: _phoneController,
//                   readOnly: true,
//                   validator: _validatePhone,
//                   decoration: const InputDecoration(
//                     labelText: 'Phone Number',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.phone),
//                     suffixIcon: Icon(Icons.lock),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 TextFormField(
//                   controller: _emailController,
//                   readOnly: true,
//                   validator: _validateEmail,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.email),
//                     suffixIcon: Icon(Icons.lock),
//                   ),
//                 ),

//                 const SizedBox(height: 200),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: ElevatedButton(
//                     onPressed: _isSaving ? null : _handleSave,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF214194),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: _isSaving
//                         ? const CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           )
//                         : const Text(
//                             'Save',
//                             style:
//                                 TextStyle(fontSize: 16, color: Colors.white),
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

















// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;

  bool _isSaving = false;
  bool _isLoading = true;
  String? _userId;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// ================= LOAD PROFILE =================
  Future<void> _loadUserProfile() async {
    setState(() => _isLoading = true);

    try {
      final user = await SharedPrefsHelper.getUser();
      if (user == null) {
        _showSnack('User not found. Please login again.');
        return;
      }

      _userId = user.id;

      final response = await http.get(
        Uri.parse('http://31.97.206.144:8127/api/auth/myprofile/$_userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final profileData = data['data'];
          
          setState(() {
            _nameController.text = profileData['fullName'] ?? '';
            _phoneController.text = profileData['phoneNumber'] ?? '';
            _emailController.text = profileData['email'] ?? '';
            _profileImageUrl = profileData['profileImage'];
          });
        } else {
          _showSnack(data['message'] ?? 'Failed to load profile');
        }
      } else {
        _showSnack('Failed to load profile. Status: ${response.statusCode}');
      }
    } catch (e) {
      _showSnack('Error loading profile: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// ================= IMAGE PICK =================
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _selectedImageBytes = bytes;
            _selectedImageFile = null;
          });
        } else {
          setState(() {
            _selectedImageFile = File(pickedFile.path);
            _selectedImageBytes = null;
          });
        }
      }
    } catch (e) {
      _showSnack('Failed to pick image');
    }
  }

  /// ================= SAVE =================
  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final token = await SharedPrefsHelper.getToken();
      if (token == null) {
        _showSnack('Authentication token not found');
        setState(() => _isSaving = false);
        return;
      }

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://31.97.206.144:8127/api/auth/myprofile/$_userId'),
      );

      // Add headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      final nameParts = _nameController.text.trim().split(' ');
      request.fields['firstName'] = nameParts.first;
      request.fields['lastName'] = nameParts.length > 1 
          ? nameParts.sublist(1).join(' ') 
          : '';

      // Add image if selected
      if (_selectedImageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profileImage',
            _selectedImageFile!.path,
          ),
        );
      } else if (_selectedImageBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'profileImage',
            _selectedImageBytes!,
            filename: 'profile.jpg',
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          _showSnack('Profile updated successfully!', success: true);
          
          // Update local storage
          final user = await SharedPrefsHelper.getUser();
          if (user != null) {
            // user.fullName = _nameController.text.trim();
            await SharedPrefsHelper.saveUser(user);
          }
          
          // Reload profile
          await _loadUserProfile();
          
          // Clear selected images
          setState(() {
            _selectedImageFile = null;
            _selectedImageBytes = null;
          });
        } else {
          _showSnack(data['message'] ?? 'Failed to update profile');
        }
      } else {
        _showSnack('Failed to update. Status: ${response.statusCode}');
      }
    } catch (e) {
      _showSnack('Error updating profile: $e');
    } finally {
      setState(() => _isSaving = false);
    }
  }

  /// ================= UI HELPERS =================
  Widget _buildProfileImage() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildImageWidget(),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF214194),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child:
                  const Icon(Icons.camera_alt, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageWidget() {
    // Priority: Selected image > Profile image from API > Placeholder
    if (_selectedImageBytes != null) {
      return Image.memory(_selectedImageBytes!, fit: BoxFit.cover);
    }

    if (_selectedImageFile != null) {
      return Image.file(_selectedImageFile!, fit: BoxFit.cover);
    }

    if (_profileImageUrl != null && _profileImageUrl!.isNotEmpty) {
      return Image.network(
        _profileImageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.person, size: 40, color: Colors.grey),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }

    return Container(
      color: Colors.grey[300],
      child: const Icon(Icons.person, size: 40, color: Colors.grey),
    );
  }

  /// ================= VALIDATIONS =================
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().length != 10) {
      return 'Invalid mobile number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(value.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  void _showSnack(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  /// ================= BUILD =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(child: _buildProfileImage()),
                      const SizedBox(height: 24),

                      TextFormField(
                        controller: _nameController,
                        validator: _validateName,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _phoneController,
                        readOnly: true,
                        validator: _validatePhone,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                          suffixIcon: Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _emailController,
                        readOnly: true,
                        validator: _validateEmail,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          suffixIcon: Icon(Icons.lock),
                        ),
                      ),

                      const SizedBox(height: 200),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isSaving ? null : _handleSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF214194),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isSaving
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                )
                              : const Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}