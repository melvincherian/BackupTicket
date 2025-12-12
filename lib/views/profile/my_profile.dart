// // ignore_for_file: deprecated_member_use

// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class MyProfile extends StatefulWidget {
//   const MyProfile({super.key});

//   @override
//   State<MyProfile> createState() => _MyProfileState();
// }

// class _MyProfileState extends State<MyProfile> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadUserProfile() async {
//     try {
//       // Get userId from SharedPreferences
//       String? userId = await UserPreferences.getUserId();

//       if (userId != null && userId.isNotEmpty) {
//         if (mounted) {
//           final profileProvider = Provider.of<UserProfileProvider>(context, listen: false);
//           await profileProvider.loadUserProfile(userId);

//           // Update controllers with loaded data
//           if (profileProvider.name != null && profileProvider.name!.isNotEmpty) {
//             _nameController.text = profileProvider.name!;
//             print('Loaded name: ${profileProvider.name}'); // Debug print
//           }
//           if (profileProvider.phoneNumber != null && profileProvider.phoneNumber!.isNotEmpty) {
//             _phoneController.text = profileProvider.phoneNumber!;
//             print('Loaded phone: ${profileProvider.phoneNumber}'); // Debug print
//           }
//           if (profileProvider.email != null && profileProvider.email!.isNotEmpty) {
//             _emailController.text = profileProvider.email!;
//             print('Loaded email: ${profileProvider.email}'); // Debug print
//           }
//         }
//       } else {
//         print('No userId found, loading from SharedPreferences'); // Debug print
//         // Fallback to SharedPreferences data if no userId
//         String? name = await UserPreferences.getName();
//         String? phone = await UserPreferences.getMobileNumber();
//         String? email = await UserPreferences.getEmail();

//         print('SharedPreferences - Name: $name, Phone: $phone, Email: $email'); // Debug print

//         if (mounted) {
//           _nameController.text = name ?? '';
//           _phoneController.text = phone ?? '';
//           _emailController.text = email ?? '';
//         }
//       }
//     } catch (e) {
//       print('Error in _loadUserProfile: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error loading profile: ${e.toString()}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _handleSave() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         final profileProvider = Provider.of<UserProfileProvider>(context, listen: false);
//         String? userId = await UserPreferences.getUserId();

//         if (userId != null && userId.isNotEmpty) {
//           // Update existing profile
//           await profileProvider.updateUserProfile(
//             userId: userId,
//             name: _nameController.text.trim(),
//             phoneNumber: _phoneController.text.trim(),
//             email: _emailController.text.trim(),
//           );
//         } else {
//           // Create new profile with timestamp as userId
//           userId = DateTime.now().millisecondsSinceEpoch.toString();
//           await profileProvider.saveUserProfile(
//             userId: userId,
//             name: _nameController.text.trim(),
//             phoneNumber: _phoneController.text.trim(),
//             email: _emailController.text.trim(),
//           );
//         }

//         // Update SharedPreferences
//         await UserPreferences.saveUser(
//           userId: userId,
//           name: _nameController.text.trim(),
//           mobileNumber: _phoneController.text.trim(),
//           email: _emailController.text.trim(),
//         );

//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Profile updated successfully!'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         }
//       } catch (e) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Error saving profile: ${e.toString()}'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     }
//   }

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
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your mobile number';
//     }
//     // Remove +91 prefix if present for validation
//     String phoneNumber = value.trim().replaceFirst('+91', '');
//     if (phoneNumber.length != 10) {
//       return 'Please enter a valid 10-digit mobile number';
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
//       return 'Mobile number should contain only digits';
//     }
//     return null;
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your email address';
//     }
//     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         centerTitle: true,
//         title: const Text(
//           'My Profile',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Consumer<UserProfileProvider>(
//         builder: (context, profileProvider, child) {
//           return SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     Center(
//                       child: Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           image: const DecorationImage(
//                             image: AssetImage('assets/profileimage.png'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Show loading indicator
//                     if (profileProvider.isLoading) ...[
//                       const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                       const SizedBox(height: 20),
//                     ],

//                     // Show error message if any
//                     if (profileProvider.errorMessage != null) ...[
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.red.shade50,
//                           border: Border.all(color: Colors.red.shade200),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 profileProvider.errorMessage!,
//                                 style: TextStyle(
//                                   color: Colors.red.shade700,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.close, size: 20),
//                               onPressed: () {
//                                 profileProvider.clearError();
//                               },
//                               color: Colors.red.shade700,
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                     ],

//                     // Full Name
//                     TextFormField(
//                       controller: _nameController,
//                       validator: _validateName,
//                       decoration: const InputDecoration(
//                         labelText: 'Full Name',
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.person),
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // Phone Number
//                     TextFormField(
//                       controller: _phoneController,
//                       validator: _validatePhone,
//                       decoration: const InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.phone),
//                       ),
//                       keyboardType: TextInputType.phone,
//                     ),
//                     const SizedBox(height: 16),

//                     // Email
//                     TextFormField(
//                       controller: _emailController,
//                       validator: _validateEmail,
//                       decoration: const InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.email),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 250),

//                     // Save Button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: profileProvider.isUpdating ? null : _handleSave,
//                         style: ButtonStyle(
//                           shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8))),
//                           padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
//                           backgroundColor: MaterialStateProperty.all(Colors.transparent),
//                           elevation: MaterialStateProperty.all(0),
//                         ),
//                         child: Ink(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: profileProvider.isUpdating
//                                   ? [Colors.grey.shade400, Colors.grey.shade500]
//                                   : [const Color(0xFF214194), const Color(0xFF4C7EFF)],
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Container(
//                             alignment: Alignment.center,
//                             child: profileProvider.isUpdating
//                                 ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                 : const Text(
//                                     'Save',
//                                     style: TextStyle(fontSize: 16, color: Colors.white),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
import 'package:backup_ticket/services/cloudinary_image_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  String? _currentProfileImageUrl;
  bool _isUploadingImage = false;

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

  Future<void> _loadUserProfile() async {
    try {
      String? userId = await UserPreferences.getUserId();

      if (userId != null && userId.isNotEmpty) {
        if (mounted) {
          final profileProvider = Provider.of<UserProfileProvider>(
            context,
            listen: false,
          );
          await profileProvider.loadUserProfile(userId);

          if (profileProvider.name != null &&
              profileProvider.name!.isNotEmpty) {
            _nameController.text = profileProvider.name!;
          }
          if (profileProvider.phoneNumber != null &&
              profileProvider.phoneNumber!.isNotEmpty) {
            _phoneController.text = profileProvider.phoneNumber!;
          }
          if (profileProvider.email != null &&
              profileProvider.email!.isNotEmpty) {
            _emailController.text = profileProvider.email!;
          }
          if (profileProvider.profileImageUrl != null &&
              profileProvider.profileImageUrl!.isNotEmpty) {
            setState(() {
              _currentProfileImageUrl = profileProvider.profileImageUrl;
            });
          }
        }
      } else {
        String? name = await UserPreferences.getName();
        String? phone = await UserPreferences.getMobileNumber();
        String? email = await UserPreferences.getEmail();

        if (mounted) {
          _nameController.text = name ?? '';
          _phoneController.text = phone ?? '';
          _emailController.text = email ?? '';
        }
      }
    } catch (e) {
      print('Error in _loadUserProfile: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
          // For web platform
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _selectedImageBytes = bytes;
            _selectedImageFile = null;
          });
        } else {
          // For mobile/desktop
          setState(() {
            _selectedImageFile = File(pickedFile.path);
            _selectedImageBytes = null;
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error selecting image: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<String?> _uploadImageToCloudinary() async {
    try {
      setState(() {
        _isUploadingImage = true;
      });

      String? uploadedUrl;

      if (kIsWeb && _selectedImageBytes != null) {
        // Upload for web
        uploadedUrl = await CloudinaryService.uploadImageFromBytes(
          _selectedImageBytes!,
          'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
      } else if (_selectedImageFile != null) {
        // Upload for mobile/desktop
        uploadedUrl = await CloudinaryService.uploadImage(_selectedImageFile!);
      }

      setState(() {
        _isUploadingImage = false;
      });

      return uploadedUrl;
    } catch (e) {
      setState(() {
        _isUploadingImage = false;
      });
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _handleSave() async {
    if (_formKey.currentState!.validate()) {
      try {
        final profileProvider = Provider.of<UserProfileProvider>(
          context,
          listen: false,
        );
        String? userId = await UserPreferences.getUserId();
        String? profileImageUrl = _currentProfileImageUrl;

        // Upload new image if selected
        if (_selectedImageFile != null || _selectedImageBytes != null) {
          final uploadedUrl = await _uploadImageToCloudinary();
          if (uploadedUrl != null) {
            profileImageUrl = uploadedUrl;

            // Delete old image from Cloudinary if exists
            if (_currentProfileImageUrl != null &&
                _currentProfileImageUrl!.isNotEmpty &&
                _currentProfileImageUrl != uploadedUrl) {
              await CloudinaryService.deleteImage(_currentProfileImageUrl!);
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Failed to upload image. Profile will be saved without new image.',
                  ),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          }
        }

        if (userId != null && userId.isNotEmpty) {
          // Update existing profile
          await profileProvider.updateUserProfile(
            userId: userId,
            name: _nameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            email: _emailController.text.trim(),
            profileImageUrl: profileImageUrl,
          );
        } else {
          // Create new profile
          userId = DateTime.now().millisecondsSinceEpoch.toString();
          await profileProvider.saveUserProfile(
            userId: userId,
            name: _nameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            email: _emailController.text.trim(),
            profileImageUrl: profileImageUrl,
          );
        }

        // Update SharedPreferences
        await UserPreferences.saveUser(
          userId: userId,
          name: _nameController.text.trim(),
          mobileNumber: _phoneController.text.trim(),
          email: _emailController.text.trim(),
        );

        // Clear selected image after successful save
        setState(() {
          _selectedImageFile = null;
          _selectedImageBytes = null;
          _currentProfileImageUrl = profileImageUrl;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving profile: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

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
            onTap: _isUploadingImage ? null : _pickImage,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF214194),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: _isUploadingImage
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.camera_alt, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageWidget() {
    // 1️⃣ Show selected memory image
    if (_selectedImageBytes != null) {
      return Image.memory(_selectedImageBytes!, fit: BoxFit.cover);
    }

    // 2️⃣ Show selected file image
    if (_selectedImageFile != null) {
      return Image.file(_selectedImageFile!, fit: BoxFit.cover);
    }

    // 3️⃣ Show current profile image (network)
    if (_currentProfileImageUrl != null &&
        _currentProfileImageUrl!.isNotEmpty) {
      return Image.network(
        _currentProfileImageUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _defaultPersonIcon();
        },
      );
    }

    // 4️⃣ Show person icon by default
    return _defaultPersonIcon();
  }

  Widget _defaultPersonIcon() {
    return Container(
      color: Colors.grey[300],
      child: const Icon(Icons.person, size: 40, color: Colors.grey),
    );
  }

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
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your mobile number';
    }
    String phoneNumber = value.trim().replaceFirst('+91', '');
    if (phoneNumber.length != 10) {
      return 'Please enter a valid 10-digit mobile number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      return 'Mobile number should contain only digits';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, profileProvider, child) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Center(child: _buildProfileImage()),
                    const SizedBox(height: 20),

                    if (profileProvider.isLoading) ...[
                      const Center(child: CircularProgressIndicator()),
                      const SizedBox(height: 20),
                    ],

                    if (profileProvider.errorMessage != null) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          border: Border.all(color: Colors.red.shade200),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                profileProvider.errorMessage!,
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () {
                                profileProvider.clearError();
                              },
                              color: Colors.red.shade700,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

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
                      validator: _validatePhone,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                        suffixIcon: Icon(Icons.lock),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _emailController,
                      validator: _validateEmail,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        suffixIcon: Icon(Icons.lock),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 250),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            (profileProvider.isUpdating || _isUploadingImage)
                            ? null
                            : _handleSave,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(0),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.transparent,
                          ),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors:
                                  (profileProvider.isUpdating ||
                                      _isUploadingImage)
                                  ? [Colors.grey.shade400, Colors.grey.shade500]
                                  : [
                                      const Color(0xFF214194),
                                      const Color(0xFF4C7EFF),
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child:
                                (profileProvider.isUpdating ||
                                    _isUploadingImage)
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Save',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
