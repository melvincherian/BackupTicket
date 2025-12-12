// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:backup_ticket/model/movie_ticket_model.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:extended_image/extended_image.dart';

// class SellMovieTicket extends StatefulWidget {
//   const SellMovieTicket({super.key});

//   @override
//   State<SellMovieTicket> createState() => _SellMovieTicketState();
// }

// class _SellMovieTicketState extends State<SellMovieTicket> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for form fields
//   final _fullNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _theatrePlaceController = TextEditingController();
//   final _pricePerTicketController = TextEditingController();
//   final _totalPriceController = TextEditingController();

//   // Form state variables
//   bool _agreeToTerms = false;
//   String? _selectedGender;
//   String? _selectedMovieName; // Changed from controller to dropdown selection
//   String? _selectedTicketType;
//   String? _selectedTicketCount = '1';
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   File? _selectedImage;
//   File? _selectedQrCodeImage;

//   double? _theatreLatitude;
//   double? _theatreLongitude;

//   final ImagePicker _picker = ImagePicker();

//   // Movie options for the dropdown
//   final List<String> _movieOptions = [
//     'OG',
//     'Littlehearts',
//     'Mira',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Add listener to calculate total price automatically
//     _pricePerTicketController.addListener(_calculateTotalPrice);
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _theatrePlaceController.dispose();
//     _pricePerTicketController.dispose();
//     _totalPriceController.dispose();
//     super.dispose();
//   }

//   void _calculateTotalPrice() {
//     if (_pricePerTicketController.text.isNotEmpty && _selectedTicketCount != null) {
//       double pricePerTicket = double.tryParse(_pricePerTicketController.text) ?? 0;
//       int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
//       double totalPrice = pricePerTicket * ticketCount;
//       _totalPriceController.text = totalPrice.toStringAsFixed(2);
//     }
//   }

//   Future<void> _pickImage({bool isQrCode = false}) async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//         imageQuality: 85,
//       );
//       if (image != null) {
//         // Navigate to cropper screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => ImageCropperScreen(
//               imageFile: File(image.path),
//               isQrCode: isQrCode,
//             ),
//           ),
//         ).then((croppedFile) {
//           if (croppedFile != null && croppedFile is File) {
//             setState(() {
//               if (isQrCode) {
//                 _selectedQrCodeImage = croppedFile;
//               } else {
//                 _selectedImage = croppedFile;
//               }
//             });
//           }
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error picking image: $e')),
//       );
//     }
//   }

//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate()) return;
//     if (!_agreeToTerms) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please agree to terms and conditions')),
//       );
//       return;
//     }

//     if (_selectedDate == null || _selectedTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select show date and time')),
//       );
//       return;
//     }

//     if (_selectedMovieName == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a movie')),
//       );
//       return;
//     }

//     try {
//       final provider = Provider.of<MovieTicketProvider>(context, listen: false);

//       // Create MovieTicket object
//       final ticket = MovieTicket(
//         fullName: _fullNameController.text.trim(),
//         phoneNumber: _phoneController.text.trim(),
//         email: _emailController.text.trim(),
//         gender: _selectedGender ?? '',
//         movieName: _selectedMovieName!, // Use selected movie from dropdown
//         theatrePlace: _theatrePlaceController.text.trim(),
//         showDate: _selectedDate!,
//         showTime: '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
//         pricePerTicket: double.tryParse(_pricePerTicketController.text) ?? 0,
//         ticketType: _selectedTicketType ?? '',
//         numberOfTickets: int.tryParse(_selectedTicketCount!) ?? 1,
//         totalPrice: double.tryParse(_totalPriceController.text) ?? 0,
//         agreeToTerms: _agreeToTerms,
//         createdAt: DateTime.now(),

//       );

//       // Show loading dialog
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );

//       // Convert File to XFile for Firebase
//       XFile? imageXFile;
//       XFile? qrCodeXFile;

//       if (_selectedImage != null) {
//         imageXFile = XFile(_selectedImage!.path);
//       }

//       if (_selectedQrCodeImage != null) {
//         qrCodeXFile = XFile(_selectedQrCodeImage!.path);
//       }

//       // Submit to Firebase
//       final ticketId = await provider.createMovieTicket(
//         ticket,
//         imageFile: imageXFile,
//         qrCodeFile: qrCodeXFile,
//       );

//       Navigator.pop(context); // Close loading dialog

//       if (ticketId != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Movie ticket submitted successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         Navigator.pop(context); // Go back to previous screen
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: ${provider.error ?? 'Unknown error occurred'}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       Navigator.pop(context); // Close loading dialog
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error submitting ticket: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Sell Movie Tickets',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 19,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer<MovieTicketProvider>(
//         builder: (context, provider, child) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTextField('Full Name', 'Enter your full name', _fullNameController, required: true),
//                   const SizedBox(height: 16),
//                   _buildTextField('Phone Number', 'Enter phone number', _phoneController, required: true),
//                   const SizedBox(height: 16),
//                   _buildTextField('E-Mail', 'Enter email address', _emailController, required: true),
//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'Gender',
//                     'Select Gender',
//                     ['Male', 'Female', 'Other'],
//                     _selectedGender,
//                     (value) {
//                       setState(() {
//                         _selectedGender = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   // Changed movie name from text field to dropdown
//                   _buildDropdownField(
//                     'Movie Name',
//                     'Select movie name',
//                     _movieOptions,
//                     _selectedMovieName,
//                     (value) {
//                       setState(() {
//                         _selectedMovieName = value;
//                       });
//                     },
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField('Theatre Place', 'Enter theatre name/place', _theatrePlaceController, required: true),
//                   const SizedBox(height: 16),
//                   _buildDateField(
//                     'Show Date',
//                     _selectedDate != null
//                         ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
//                         : 'Select show date',
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTimeField(
//                     'Show Time',
//                     _selectedTime != null
//                         ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
//                         : '',
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField('Price per Ticket', 'Enter price per ticket', _pricePerTicketController,
//                     required: true, isNumber: true),
//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'Ticket Type',
//                     'Select ticket type',
//                     ['Economy', 'Business', 'Premium', 'Luxury'],
//                     _selectedTicketType,
//                     (value) {
//                       setState(() {
//                         _selectedTicketType = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'Number of Tickets',
//                     '1',
//                     ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
//                     _selectedTicketCount,
//                     (value) {
//                       setState(() {
//                         _selectedTicketCount = value;
//                         _calculateTotalPrice();
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: _buildTextField('Total Price', 'Total price', _totalPriceController,
//                           readOnly: true),
//                       ),
//                       const Expanded(flex: 2, child: SizedBox()),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   _buildFileUploadField('Upload Ticket Image', false, _selectedImage),
//                   const SizedBox(height: 16),
//                   _buildFileUploadField('Upload QR Code', true, _selectedQrCodeImage),
//                   const SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: _agreeToTerms,
//                         onChanged: (value) {
//                           setState(() {
//                             _agreeToTerms = value ?? false;
//                           });
//                         },
//                         activeColor: Colors.blue,
//                       ),
//                       const Expanded(
//                         child: Text(
//                           'I agree to the terms and conditions',
//                           style: TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: _agreeToTerms && !provider.isLoading ? _submitForm : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF214194),
//                         disabledBackgroundColor: Colors.grey[300],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: provider.isLoading
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                               ),
//                             )
//                           : const Text(
//                               'Submit',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTextField(String label, String hint, TextEditingController controller,
//       {bool required = false, bool isNumber = false, bool readOnly = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           readOnly: readOnly,
//           keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//           validator: required
//               ? (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'This field is required';
//                   }
//                   if (isNumber && double.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 }
//               : null,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: readOnly ? Colors.grey[100] : Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdownField(
//     String label,
//     String hint,
//     List<String> items,
//     String? selectedValue,
//     Function(String?) onChanged,
//     {bool required = false}
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: selectedValue,
//           validator: required
//               ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'This field is required';
//                   }
//                   return null;
//                 }
//               : null,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(value: value, child: Text(value));
//           }).toList(),
//           onChanged: onChanged,
//           icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateField(String label, String hint) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: true,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             suffixIcon: const Icon(
//               Icons.calendar_today,
//               color: Colors.black,
//               size: 20,
//             ),
//           ),
//           onTap: () async {
//             final DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: _selectedDate ?? DateTime.now(),
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(const Duration(days: 365)),
//             );
//             if (picked != null && picked != _selectedDate) {
//               setState(() {
//                 _selectedDate = picked;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildTimeField(String label, String displayTime) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: true,
//           controller: TextEditingController(text: displayTime),
//           decoration: InputDecoration(
//             hintText: displayTime.isEmpty ? 'Select time' : null,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             suffixIcon: const Icon(
//               Icons.access_time,
//               color: Colors.black,
//               size: 20,
//             ),
//           ),
//           onTap: () async {
//             final TimeOfDay? picked = await showTimePicker(
//               context: context,
//               initialTime: _selectedTime ?? TimeOfDay.now(),
//             );
//             if (picked != null && picked != _selectedTime) {
//               setState(() {
//                 _selectedTime = picked;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildFileUploadField(String label, bool isQrCode, File? selectedFile) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           width: double.infinity,
//           height: 120,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: const Color.fromARGB(255, 181, 181, 181)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: InkWell(
//             onTap: () => _pickImage(isQrCode: isQrCode),
//             borderRadius: BorderRadius.circular(12),
//             child: selectedFile != null
//                 ? Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(
//                           selectedFile,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: 120,
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: const Icon(
//                             Icons.crop,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 16,
//                           backgroundColor: const Color(0xFFF0F0F0),
//                           child: Icon(
//                             isQrCode ? Icons.qr_code : Icons.upload_file,
//                             color: Colors.grey,
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           isQrCode ? 'Choose QR Code' : 'Choose File',
//                           style: const TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                         const SizedBox(height: 2),
//                         const Text(
//                           'Tap to crop',
//                           style: TextStyle(color: Colors.grey, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Image Cropper Screen integrated into the same file
// class ImageCropperScreen extends StatefulWidget {
//   final File imageFile;
//   final bool isQrCode;

//   const ImageCropperScreen({
//     super.key,
//     required this.imageFile,
//     this.isQrCode = false,
//   });

//   @override
//   State<ImageCropperScreen> createState() => _ImageCropperScreenState();
// }

// class _ImageCropperScreenState extends State<ImageCropperScreen> {
//   final GlobalKey<ExtendedImageEditorState> _editorKey =
//       GlobalKey<ExtendedImageEditorState>();

//   double? _aspectRatio;
//   Size? _originalImageSize;
//   Map<String, double> _aspectRatios = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadOriginalImageSize();
//   }

//   void _loadOriginalImageSize() async {
//     final data = await widget.imageFile.readAsBytes();
//     final decodedImage = await decodeImageFromList(data);
//     final originalWidth = decodedImage.width.toDouble();
//     final originalHeight = decodedImage.height.toDouble();
//     final originalRatio = originalWidth / originalHeight;

//     setState(() {
//       _originalImageSize = Size(originalWidth, originalHeight);
//       _aspectRatios = {
//         'Original': originalRatio,
//         '1:1': 1.0,
//         '16:9': 16 / 9,
//         '9:16': 9 / 16,
//         '7:5': 7 / 5,
//         '5:7': 5 / 7,
//       };
//       // For QR codes, default to square (1:1), otherwise use original
//       _aspectRatio = widget.isQrCode ? 1.0 : originalRatio;
//     });
//   }

//   void _cropAndReturn() async {
//     final state = _editorKey.currentState;
//     if (state == null) return;

//     final Uint8List? croppedData = await _cropImageDataWithDartLibrary(state);

//     if (croppedData == null) {
//       print("Cropping failed");
//       return;
//     }

//     try {
//       // Use application documents directory instead of temp
//       final appDir = await getApplicationDocumentsDirectory();
//       final cropDir = Directory('${appDir.path}/cropped_images');

//       // Create directory if it doesn't exist
//       if (!await cropDir.exists()) {
//         await cropDir.create(recursive: true);
//       }

//       final filePath = '${cropDir.path}/cropped_${widget.isQrCode ? 'qr_' : ''}${DateTime.now().millisecondsSinceEpoch}.png';
//       final file = File(filePath);
//       await file.writeAsBytes(croppedData);

//       // Return the cropped file
//       Navigator.pop(context, file);
//     } catch (e) {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error saving cropped image: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       print('Error in _cropAndReturn: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_aspectRatios.isEmpty) {
//       return const Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     final aspectRatio = _aspectRatio == 0.0 ? null : _aspectRatio;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF214194),
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           widget.isQrCode ? "Crop QR Code" : "Crop Ticket Image",
//           style: const TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check, color: Colors.white),
//             onPressed: _cropAndReturn,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ExtendedImage.file(
//               widget.imageFile,
//               fit: BoxFit.contain,
//               mode: ExtendedImageMode.editor,
//               extendedImageEditorKey: _editorKey,
//               initEditorConfigHandler: (state) {
//                 return EditorConfig(
//                   maxScale: 8.0,
//                   cropRectPadding: const EdgeInsets.all(20.0),
//                   hitTestSize: 20.0,
//                   cropAspectRatio: aspectRatio,
//                 );
//               },
//               cacheRawData: true,
//             ),
//           ),
//           _buildAspectRatioSelector(),
//         ],
//       ),
//     );
//   }

//   Widget _buildAspectRatioSelector() {
//     return Container(
//       height: 80,
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       color: Colors.black,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: _aspectRatios.entries.map((entry) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: ChoiceChip(
//               label: Text(
//                 entry.key,
//                 style: const TextStyle(color: Colors.white, fontSize: 12),
//               ),
//               selected: _aspectRatio == entry.value,
//               onSelected: (_) => setState(() => _aspectRatio = entry.value),
//               selectedColor: const Color(0xFF214194),
//               backgroundColor: Colors.grey[800],
//               labelStyle: const TextStyle(color: Colors.white),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Future<Uint8List?> _cropImageDataWithDartLibrary(
//       ExtendedImageEditorState state) async {
//     final Rect cropRect = state.getCropRect()!;
//     final Uint8List data = state.rawImageData!;
//     final ui.Image image = await decodeImageFromList(data);

//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);
//     final paint = Paint();

//     final srcRect = cropRect;
//     final dstRect = Rect.fromLTWH(0, 0, cropRect.width, cropRect.height);

//     canvas.drawImageRect(image, srcRect, dstRect, paint);

//     final picture = recorder.endRecording();
//     final ui.Image croppedImage = await picture.toImage(
//       cropRect.width.toInt(),
//       cropRect.height.toInt(),
//     );

//     final byteData = await croppedImage.toByteData(format: ui.ImageByteFormat.png);
//     return byteData?.buffer.asUint8List();
//   }
// }

// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:backup_ticket/model/movie_ticket_model.dart';
// import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:extended_image/extended_image.dart';

// class SellMovieTicket extends StatefulWidget {
//   const SellMovieTicket({super.key});

//   @override
//   State<SellMovieTicket> createState() => _SellMovieTicketState();
// }

// class _SellMovieTicketState extends State<SellMovieTicket> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for form fields
//   final _fullNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _theatrePlaceController = TextEditingController();
//   final _pricePerTicketController = TextEditingController();
//   final _totalPriceController = TextEditingController();

//   // List of seat number controllers
//   List<TextEditingController> _seatControllers = [TextEditingController()];

//   // Form state variables
//   bool _agreeToTerms = false;
//   String? _selectedGender;
//   String? _selectedMovieName;
//   String? _selectedTicketType;
//   String? _selectedTicketCount = '1';
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   File? _selectedImage;
//   File? _selectedQrCodeImage;

//   double? _theatreLatitude;
//   double? _theatreLongitude;

//   String? _selectedCategory;
//   String? _selectedTicketTypes;

//   final Map<String, List<String>> ticketCategories = {
//     "Premium Seats": ["Executive", "Platinum", "Recliner"],
//     "Regular Seats": ["Normal", "Gold", "Classic"],
//     "Special Seats": [
//       "Box",
//       "Upper Balcony",
//       "Lower Balcony",
//       "First Class",
//       "Second Class",
//     ],
//   };

//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     // Add listener to calculate total price automatically
//     _pricePerTicketController.addListener(_calculateTotalPrice);

//     // Fetch movie categories when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<MovieCategoryProvider>(
//         context,
//         listen: false,
//       ).fetchCategories();
//     });
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _theatrePlaceController.dispose();
//     _pricePerTicketController.dispose();
//     _totalPriceController.dispose();
//     // Dispose all seat controllers
//     for (var controller in _seatControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   void _updateSeatControllers(int count) {
//     setState(() {
//       // Dispose old controllers if we're reducing the count
//       if (_seatControllers.length > count) {
//         for (int i = count; i < _seatControllers.length; i++) {
//           _seatControllers[i].dispose();
//         }
//         _seatControllers = _seatControllers.sublist(0, count);
//       } else {
//         // Add new controllers if we're increasing the count
//         for (int i = _seatControllers.length; i < count; i++) {
//           _seatControllers.add(TextEditingController());
//         }
//       }
//     });
//   }

//   void _calculateTotalPrice() {
//     if (_pricePerTicketController.text.isNotEmpty &&
//         _selectedTicketCount != null) {
//       double pricePerTicket =
//           double.tryParse(_pricePerTicketController.text) ?? 0;
//       int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
//       double totalPrice = pricePerTicket * ticketCount;
//       _totalPriceController.text = totalPrice.toStringAsFixed(2);
//     }
//   }

//   Future<void> _pickImage({bool isQrCode = false}) async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//         imageQuality: 85,
//       );
//       if (image != null) {
//         // Navigate to cropper screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => ImageCropperScreen(
//               imageFile: File(image.path),
//               isQrCode: isQrCode,
//             ),
//           ),
//         ).then((croppedFile) {
//           if (croppedFile != null && croppedFile is File) {
//             setState(() {
//               if (isQrCode) {
//                 _selectedQrCodeImage = croppedFile;
//               } else {
//                 _selectedImage = croppedFile;
//               }
//             });
//           }
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
//     }
//   }

//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate()) return;
//     if (!_agreeToTerms) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please agree to terms and conditions')),
//       );
//       return;
//     }

//     if (_selectedDate == null || _selectedTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select show date and time')),
//       );
//       return;
//     }

//     if (_selectedMovieName == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Please select a movie')));
//       return;
//     }

//     // Validate all seat numbers are filled
//     for (int i = 0; i < _seatControllers.length; i++) {
//       if (_seatControllers[i].text.trim().isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please enter seat number ${i + 1}')),
//         );
//         return;
//       }
//     }

//     try {
//       final provider = Provider.of<MovieTicketProvider>(context, listen: false);

//       // Collect all seat numbers
//       List<String> seatNumbers = _seatControllers
//           .map((controller) => controller.text.trim())
//           .toList();

//       // Create MovieTicket object
//       final ticket = MovieTicket(
//         fullName: _fullNameController.text.trim(),
//         phoneNumber: _phoneController.text.trim(),
//         email: _emailController.text.trim(),
//         gender: _selectedGender ?? '',
//         movieName: _selectedMovieName!,
//         theatrePlace: _theatrePlaceController.text.trim(),
//         showDate: _selectedDate!,
//         showTime:
//             '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
//         pricePerTicket: double.tryParse(_pricePerTicketController.text) ?? 0,
//         ticketType: _selectedTicketType ?? '',
//         numberOfTickets: int.tryParse(_selectedTicketCount!) ?? 1,
//         totalPrice: double.tryParse(_totalPriceController.text) ?? 0,
//         agreeToTerms: _agreeToTerms,
//         createdAt: DateTime.now(),
//         ticketCategory: _selectedCategory!,
//         seatNumbers: seatNumbers,
//       );

//       // Show loading dialog
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(child: CircularProgressIndicator()),
//       );

//       // Convert File to XFile for Firebase
//       XFile? imageXFile;
//       XFile? qrCodeXFile;

//       if (_selectedImage != null) {
//         imageXFile = XFile(_selectedImage!.path);
//       }

//       if (_selectedQrCodeImage != null) {
//         qrCodeXFile = XFile(_selectedQrCodeImage!.path);
//       }

//       // Submit to Firebase
//       final ticketId = await provider.createMovieTicket(
//         ticket,
//         imageFile: imageXFile,
//         qrCodeFile: qrCodeXFile,
//       );

//       Navigator.pop(context); // Close loading dialog

//       if (ticketId != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Movie ticket submitted successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         Navigator.pop(context); // Go back to previous screen
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Error: ${provider.error ?? 'Unknown error occurred'}',
//             ),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       Navigator.pop(context); // Close loading dialog
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error submitting ticket: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Sell Movie Tickets',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 19,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer2<MovieTicketProvider, MovieCategoryProvider>(
//         builder: (context, ticketProvider, categoryProvider, child) {
//           // Get active movie categories
//           final activeCategories = categoryProvider.activeCategories;
//           final movieOptions = activeCategories.map((cat) => cat.name).toList();

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTextField(
//                     'Full Name',
//                     'Enter your full name',
//                     _fullNameController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'Phone Number',
//                     'Enter phone number',
//                     _phoneController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'E-Mail',
//                     'Enter email address',
//                     _emailController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'Gender',
//                     'Select Gender',
//                     ['Male', 'Female', 'Other'],
//                     _selectedGender,
//                     (value) {
//                       setState(() {
//                         _selectedGender = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   // Dynamic movie name dropdown from Firebase categories
//                   categoryProvider.isLoading
//                       ? const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(vertical: 16.0),
//                             child: CircularProgressIndicator(),
//                           ),
//                         )
//                       : movieOptions.isEmpty
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Movie Name',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade50,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   color: Colors.orange.shade200,
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.info_outline,
//                                     color: Colors.orange.shade700,
//                                     size: 20,
//                                   ),
//                                   const SizedBox(width: 12),
//                                   const Expanded(
//                                     child: Text(
//                                       'No movie categories available. Please add categories first.',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )
//                       : _buildDropdownField(
//                           'Movie Name',
//                           'Select movie name',
//                           movieOptions,
//                           _selectedMovieName,
//                           (value) {
//                             setState(() {
//                               _selectedMovieName = value;
//                             });
//                           },
//                           required: true,
//                         ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'Theatre Place',
//                     'Enter theatre name/place',
//                     _theatrePlaceController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildDateField(
//                     'Show Date',
//                     _selectedDate != null
//                         ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
//                         : 'Select show date',
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTimeField(
//                     'Show Time',
//                     _selectedTime != null
//                         ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
//                         : '',
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'Price per Ticket',
//                     'Enter price per ticket',
//                     _pricePerTicketController,
//                     required: true,
//                     isNumber: true,
//                   ),
//                   const SizedBox(height: 16),

//                   // Category dropdown
//                   _buildDropdownField(
//                     'Ticket Category',
//                     'Select category',
//                     ticketCategories.keys.toList(),
//                     _selectedCategory,
//                     (value) {
//                       setState(() {
//                         _selectedCategory = value;
//                         _selectedTicketType = null;
//                       });
//                     },
//                     required: true,
//                   ),

//                   const SizedBox(height: 16),

//                   // Ticket type dropdown (appears only after category)
//                   if (_selectedCategory != null)
//                     _buildDropdownField(
//                       'Ticket Type',
//                       'Select ticket type',
//                       ticketCategories[_selectedCategory]!,
//                       _selectedTicketType,
//                       (value) {
//                         setState(() {
//                           _selectedTicketType = value;
//                         });
//                       },
//                       required: true,
//                     ),

//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'You wanna sell',
//                     '1',
//                     ['1', '2', '3', '4', '5', '6'],
//                     _selectedTicketCount,
//                     (value) {
//                       setState(() {
//                         _selectedTicketCount = value;
//                         _calculateTotalPrice();
//                         // Update seat controllers based on ticket count
//                         _updateSeatControllers(int.parse(value!));
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   // Seat Number Fields - Dynamic based on ticket count
//                   ..._buildSeatNumberFields(),

//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: _buildTextField(
//                           'Total Price',
//                           'Total price',
//                           _totalPriceController,
//                           readOnly: true,
//                         ),
//                       ),
//                       const Expanded(flex: 2, child: SizedBox()),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   _buildFileUploadField(
//                     'Upload Ticket Image',
//                     false,
//                     _selectedImage,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildFileUploadField(
//                     'Upload QR Code',
//                     true,
//                     _selectedQrCodeImage,
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: _agreeToTerms,
//                         onChanged: (value) {
//                           setState(() {
//                             _agreeToTerms = value ?? false;
//                           });
//                         },
//                         activeColor: Colors.blue,
//                       ),
//                       const Expanded(
//                         child: Text(
//                           'I agree to the terms and conditions',
//                           style: TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed:
//                           _agreeToTerms &&
//                               !ticketProvider.isLoading &&
//                               movieOptions.isNotEmpty
//                           ? _submitForm
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF214194),
//                         disabledBackgroundColor: Colors.grey[300],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: ticketProvider.isLoading
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.white,
//                                 ),
//                               ),
//                             )
//                           : const Text(
//                               'Submit',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   List<Widget> _buildSeatNumberFields() {
//     List<Widget> seatFields = [];

//     for (int i = 0; i < _seatControllers.length; i++) {
//       seatFields.add(
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Seat Number ${i + 1}',
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _seatControllers[i],
//               textCapitalization: TextCapitalization.characters,
//               decoration: InputDecoration(
//                 hintText: 'Enter seat number (e.g., A1, B12)',
//                 hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Colors.grey, width: 1),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Colors.grey, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Colors.blue, width: 1),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 12,
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 prefixIcon: const Icon(
//                   Icons.event_seat,
//                   color: Colors.grey,
//                   size: 20,
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Please enter seat number ${i + 1}';
//                 }
//                 return null;
//               },
//             ),
//           ],
//         ),
//       );

//       if (i < _seatControllers.length - 1) {
//         seatFields.add(const SizedBox(height: 16));
//       }
//     }

//     return seatFields;
//   }

//   Widget _buildTextField(
//     String label,
//     String hint,
//     TextEditingController controller, {
//     bool required = false,
//     bool isNumber = false,
//     bool readOnly = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           readOnly: readOnly,
//           keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//           validator: required
//               ? (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'This field is required';
//                   }
//                   if (isNumber && double.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 }
//               : null,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: readOnly ? Colors.grey[100] : Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdownField(
//     String label,
//     String hint,
//     List<String> items,
//     String? selectedValue,
//     Function(String?) onChanged, {
//     bool required = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: selectedValue,
//           validator: required
//               ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'This field is required';
//                   }
//                   return null;
//                 }
//               : null,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(value: value, child: Text(value));
//           }).toList(),
//           onChanged: onChanged,
//           icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateField(String label, String hint) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: true,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             suffixIcon: const Icon(
//               Icons.calendar_today,
//               color: Colors.black,
//               size: 20,
//             ),
//           ),
//           onTap: () async {
//             final DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: _selectedDate ?? DateTime.now(),
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(const Duration(days: 365)),
//             );
//             if (picked != null && picked != _selectedDate) {
//               setState(() {
//                 _selectedDate = picked;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildTimeField(String label, String displayTime) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: true,
//           controller: TextEditingController(text: displayTime),
//           decoration: InputDecoration(
//             hintText: displayTime.isEmpty ? 'Select time' : null,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             suffixIcon: const Icon(
//               Icons.access_time,
//               color: Colors.black,
//               size: 20,
//             ),
//           ),
//           onTap: () async {
//             final TimeOfDay? picked = await showTimePicker(
//               context: context,
//               initialTime: _selectedTime ?? TimeOfDay.now(),
//             );
//             if (picked != null && picked != _selectedTime) {
//               setState(() {
//                 _selectedTime = picked;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }
//   Widget _buildFileUploadField(
//     String label,
//     bool isQrCode,
//     File? selectedFile,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           width: double.infinity,
//           height: 120,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: const Color.fromARGB(255, 181, 181, 181)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: InkWell(
//             onTap: () => _pickImage(isQrCode: isQrCode),
//             borderRadius: BorderRadius.circular(12),
//             child: selectedFile != null
//                 ? Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(
//                           selectedFile,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: 120,
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: const Icon(
//                             Icons.crop,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 16,
//                           backgroundColor: const Color(0xFFF0F0F0),
//                           child: Icon(
//                             isQrCode ? Icons.qr_code : Icons.upload_file,
//                             color: Colors.grey,
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           isQrCode ? 'Choose QR Code' : 'Choose File',
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         const Text(
//                           'Tap to crop',
//                           style: TextStyle(color: Colors.grey, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:backup_ticket/model/movie_ticket_model.dart';
import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
import 'package:backup_ticket/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'dart:io';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SeatSelection {
  final String row;
  final int seatNumber;
  bool isBooked;

  SeatSelection({
    required this.row,
    required this.seatNumber,
    this.isBooked = false,
  });

  @override
  String toString() => 'Row $row - Seat $seatNumber';

  String toDisplayString() => 'Row $row, Seat $seatNumber';

  String toFirebaseKey() => '${row}_$seatNumber';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatSelection &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          seatNumber == other.seatNumber;

  @override
  int get hashCode => row.hashCode ^ seatNumber.hashCode;
}

class SellMovieTicket extends StatefulWidget {
  const SellMovieTicket({super.key});

  @override
  State<SellMovieTicket> createState() => _SellMovieTicketState();
}

class _SellMovieTicketState extends State<SellMovieTicket> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _theatrePlaceController = TextEditingController();
  final _pricePerTicketController = TextEditingController();
  final _totalPriceController = TextEditingController();

  final _qrCodeLinkController = TextEditingController();

  final _commissionController = TextEditingController();
  final _finalAmountController = TextEditingController();

  // Seat selection list
  List<SeatSelection> _selectedSeats = [];
  Map<String, bool> _bookedSeats = {}; // Store booked seats

  // Form state variables
  bool _agreeToTerms = false;
  String? _selectedGender;
  String? _selectedMovieName;
  String? _selectedTicketType;
  String? _selectedTicketCount = '1';
  String? _selectedLanguage; // New language field
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  File? _selectedImage;
  File? _selectedQrCodeImage;

  String? _selectedCategory;

  final Map<String, List<String>> ticketCategories = {
    "Premium Seats": ["Executive", "Platinum", "Recliner"],
    "Regular Seats": ["Normal", "Gold", "Classic"],
    "Special Seats": [
      "Box",
      "Upper Balcony",
      "Lower Balcony",
      "First Class",
      "Second Class",
    ],
  };

  // Language options
  final List<String> languageOptions = [
    'English',
    'Hindi',
    'Telugu',
    'Tamil',
    'Malayalam',
    'Kannada',
    'Bengali',
    'Marathi',
    'Gujarati',
    'Punjabi',
    'Other',
  ];

  // Row options A-Z
  final List<String> rowOptions = List.generate(
    26,
    (index) => String.fromCharCode(65 + index),
  );

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _pricePerTicketController.addListener(_calculateTotalPrice);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieCategoryProvider>(
        context,
        listen: false,
      ).fetchCategories();
    });
  }

  Future<bool> _isUserLoggedIn() async {
    final userId = await UserPreferences.getUserId();
    return userId != null && userId != 'guest';
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Login Required',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Please login to sell tickets. Guest users cannot sell tickets.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF214194),
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadUserData() async {
    final name = await UserPreferences.getName();
    final phone = await UserPreferences.getMobileNumber();
    final email = await UserPreferences.getEmail();

    if (mounted) {
      setState(() {
        if (name != null) _fullNameController.text = name;
        if (phone != null) _phoneController.text = phone;
        if (email != null) _emailController.text = email;
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _theatrePlaceController.dispose();
    _pricePerTicketController.dispose();
    _totalPriceController.dispose();
    _qrCodeLinkController.dispose();
    _commissionController.dispose();
    _finalAmountController.dispose();
    super.dispose();
  }

  // void _calculateTotalPrice() {
  //   if (_pricePerTicketController.text.isNotEmpty &&
  //       _selectedTicketCount != null) {
  //     double pricePerTicket =
  //         double.tryParse(_pricePerTicketController.text) ?? 0;
  //     int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
  //     double totalPrice = pricePerTicket * ticketCount;
  //     _totalPriceController.text = totalPrice.toStringAsFixed(2);
  //   }
  // }

  void _calculateTotalPrice() {
    if (_pricePerTicketController.text.isNotEmpty &&
        _selectedTicketCount != null) {
      double pricePerTicket =
          double.tryParse(_pricePerTicketController.text) ?? 0;
      int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
      double totalPrice = pricePerTicket * ticketCount;

      // Calculate 10% commission
      double commission = totalPrice * 0.10;
      double finalAmount = totalPrice - commission;

      _totalPriceController.text = totalPrice.toStringAsFixed(2);
      _commissionController.text = commission.toStringAsFixed(2);
      _finalAmountController.text = finalAmount.toStringAsFixed(2);
    }
  }

  // Generate unique booking key for the show
  String _getBookingKey() {
    if (_selectedMovieName == null ||
        _theatrePlaceController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      return '';
    }

    String dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    String timeStr =
        '${_selectedTime!.hour.toString().padLeft(2, '0')}${_selectedTime!.minute.toString().padLeft(2, '0')}';

    return '${_selectedMovieName}_${_theatrePlaceController.text}_${dateStr}_$timeStr'
        .replaceAll(' ', '_')
        .toLowerCase();
  }

  // Fetch booked seats from Firebase
  Future<void> _fetchBookedSeats() async {
    String bookingKey = _getBookingKey();
    if (bookingKey.isEmpty) return;

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('booked_seats')
          .doc(bookingKey)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          _bookedSeats = Map<String, bool>.from(data['seats'] ?? {});
        });
      } else {
        setState(() {
          _bookedSeats = {};
        });
      }
    } catch (e) {
      print('Error fetching booked seats: $e');
      setState(() {
        _bookedSeats = {};
      });
    }
  }

  // Check if a seat is booked
  bool _isSeatBooked(String row, int seatNumber) {
    String key = '${row}_$seatNumber';
    return _bookedSeats[key] == true;
  }

  // Book selected seats in Firebase
  Future<bool> _bookSeatsInFirebase() async {
    String bookingKey = _getBookingKey();
    if (bookingKey.isEmpty || _selectedSeats.isEmpty) return false;

    try {
      // Create a map of newly selected seats
      Map<String, bool> newSeats = {};
      for (var seat in _selectedSeats) {
        newSeats[seat.toFirebaseKey()] = true;
      }

      // Use transaction to ensure atomic update
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference docRef = FirebaseFirestore.instance
            .collection('booked_seats')
            .doc(bookingKey);

        DocumentSnapshot snapshot = await transaction.get(docRef);

        Map<String, bool> currentSeats = {};
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          currentSeats = Map<String, bool>.from(data['seats'] ?? {});
        }

        // Check if any selected seat is already booked
        for (var seatKey in newSeats.keys) {
          if (currentSeats[seatKey] == true) {
            throw Exception('Seat $seatKey is already booked');
          }
        }

        // Merge new seats with existing seats
        currentSeats.addAll(newSeats);

        // Update or create document
        transaction.set(docRef, {
          'movieName': _selectedMovieName,
          'theatrePlace': _theatrePlaceController.text,
          'showDate': DateFormat('yyyy-MM-dd').format(_selectedDate!),
          'showTime':
              '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
          'seats': currentSeats,
          'lastUpdated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      });

      return true;
    } catch (e) {
      print('Error booking seats: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to book seats: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future<void> _pickImage({bool isQrCode = false}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          if (isQrCode) {
            _selectedQrCodeImage = File(image.path);
          } else {
            _selectedImage = File(image.path);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  // Show seat selection dialog with real-time booking status
  Future<void> _showSeatSelectionDialog() async {
    // First check if required fields are filled
    if (_selectedMovieName == null ||
        _theatrePlaceController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill Movie Name, Theatre Place, Show Date and Show Time first',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Show loading dialog while fetching booked seats
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    await _fetchBookedSeats();

    if (!mounted) return;
    Navigator.pop(context); // Close loading dialog

    int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
    List<SeatSelection> tempSelectedSeats = List.from(_selectedSeats);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                'Select $ticketCount Seat${ticketCount > 1 ? 's' : ''}',
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Selected: ${tempSelectedSeats.length} of $ticketCount seats',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildLegendItem(Colors.grey.shade200, 'Available'),
                        _buildLegendItem(const Color(0xFF214194), 'Selected'),
                        _buildLegendItem(Colors.red.shade300, 'Booked'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: rowOptions.length,
                        itemBuilder: (context, index) {
                          final row = rowOptions[index];

                          return ExpansionTile(
                            leading: Icon(
                              Icons.event_seat,
                              color: Colors.grey.shade700,
                            ),
                            title: Text(
                              'Row $row',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: List.generate(30, (seatIndex) {
                                    final seatNumber = seatIndex + 1;
                                    final seat = SeatSelection(
                                      row: row,
                                      seatNumber: seatNumber,
                                    );
                                    final isSelected = tempSelectedSeats.any(
                                      (s) =>
                                          s.row == row &&
                                          s.seatNumber == seatNumber,
                                    );
                                    final isBooked = _isSeatBooked(
                                      row,
                                      seatNumber,
                                    );

                                    return InkWell(
                                      onTap: isBooked
                                          ? null
                                          : () {
                                              setDialogState(() {
                                                if (isSelected) {
                                                  tempSelectedSeats.removeWhere(
                                                    (s) =>
                                                        s.row == row &&
                                                        s.seatNumber ==
                                                            seatNumber,
                                                  );
                                                } else {
                                                  if (tempSelectedSeats.length <
                                                      ticketCount) {
                                                    tempSelectedSeats.add(seat);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'You can only select $ticketCount seat(s)',
                                                        ),
                                                        duration:
                                                            const Duration(
                                                              seconds: 1,
                                                            ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              });
                                            },
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: isBooked
                                              ? Colors.red.shade300
                                              : isSelected
                                              ? const Color(0xFF214194)
                                              : Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: isBooked
                                                ? Colors.red.shade400
                                                : isSelected
                                                ? const Color(0xFF214194)
                                                : Colors.grey.shade400,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: isBooked
                                              ? const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 20,
                                                )
                                              : Text(
                                                  '$seatNumber',
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.black87,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: tempSelectedSeats.length == ticketCount
                      ? () {
                          setState(() {
                            _selectedSeats = List.from(tempSelectedSeats);
                          });
                          Navigator.pop(context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF214194),
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  Future<void> _submitForm() async {
    bool isLoggedIn = await _isUserLoggedIn();
    if (!isLoggedIn) {
      _showLoginDialog();
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to terms and conditions')),
      );
      return;
    }

    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select show date and time')),
      );
      return;
    }

    if (_selectedMovieName == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a movie')));
      return;
    }

    int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
    if (_selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select seats for your tickets')),
      );
      return;
    }

    if (_selectedSeats.length != ticketCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select exactly $ticketCount seat(s) matching your ticket count',
          ),
        ),
      );
      return;
    }

    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // First, book the seats in Firebase
      bool seatsBooked = await _bookSeatsInFirebase();

      if (!seatsBooked) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to book seats. Some seats may have been taken by another user.',
            ),
            backgroundColor: Colors.red,
          ),
        );
        // Refresh booked seats and clear selection
        await _fetchBookedSeats();
        setState(() {
          _selectedSeats.clear();
        });
        return;
      }

      final provider = Provider.of<MovieTicketProvider>(context, listen: false);

      // Convert seat selections to string format
      final seatNumbers = _selectedSeats
          .map((seat) => seat.toDisplayString())
          .toList();

      // Create MovieTicket object
      final ticket = MovieTicket(
        fullName: _fullNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        // gender: _selectedGender ?? '',
        movieName: _selectedMovieName!,
        theatrePlace: _theatrePlaceController.text.trim(),
        showDate: _selectedDate!,
        showTime:
            '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
        pricePerTicket: double.tryParse(_pricePerTicketController.text) ?? 0,
        ticketType: _selectedTicketType ?? '',
        numberOfTickets: int.tryParse(_selectedTicketCount!) ?? 1,
        totalPrice: double.tryParse(_totalPriceController.text) ?? 0,
        agreeToTerms: _agreeToTerms,
        createdAt: DateTime.now(),
        ticketCategory: _selectedCategory!,
        seatNumbers: seatNumbers,
        language: _selectedLanguage, // Add language to ticket (optional field)
      );

      // Convert File to XFile for Firebase
      XFile? imageXFile;
      // XFile? qrCodeXFile;

      String? qrCodeLink = _qrCodeLinkController.text.trim().isNotEmpty
          ? _qrCodeLinkController.text.trim()
          : null;

      if (_selectedImage != null) {
        imageXFile = XFile(_selectedImage!.path);
      }

      // if (_selectedQrCodeImage != null) {
      //   qrCodeXFile = XFile(_selectedQrCodeImage!.path);
      // }

      // Submit to Firebase
      final ticketId = await provider.createMovieTicket(
        ticket,
        imageFile: imageXFile,
        // qrCodeFile: qrCodeLink,
        qrCodeLink: qrCodeLink,
      );

      Navigator.pop(context); // Close loading dialog

      if (ticketId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Thanks for uploaded your ticket our team will check and notify you once get uploaded',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Go back to previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${provider.error ?? 'Unknown error occurred'}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting ticket: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECEFF1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sell Movie Tickets',
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer2<MovieTicketProvider, MovieCategoryProvider>(
        builder: (context, ticketProvider, categoryProvider, child) {
          final activeCategories = categoryProvider.activeCategories;
          final movieOptions = activeCategories.map((cat) => cat.name).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    'Full Name',
                    'Enter your full name',
                    _fullNameController,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Phone Number',
                    'Enter phone number',
                    _phoneController,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'E-Mail',
                    'Enter email address',
                    _emailController,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  // _buildDropdownField(
                  //   'Gender',
                  //   'Select Gender',
                  //   ['Male', 'Female', 'Other'],
                  //   _selectedGender,
                  //   (value) {
                  //     setState(() {
                  //       _selectedGender = value;
                  //     });
                  //   },
                  // ),
                  const SizedBox(height: 16),
                  categoryProvider.isLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : movieOptions.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Movie Name',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.orange.shade200,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.orange.shade700,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'No movie categories available. Please add categories first.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : _buildDropdownField(
                          'Movie Name',
                          'Select movie name',
                          movieOptions,
                          _selectedMovieName,
                          (value) {
                            setState(() {
                              _selectedMovieName = value;
                              _selectedSeats.clear();
                              _bookedSeats.clear();
                            });
                          },
                          required: true,
                        ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    'Language',
                    'Select language (Optional)',
                    languageOptions,
                    _selectedLanguage,
                    (value) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    },
                    required: false, // Not required
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Theatre Place',
                    'Enter theatre name/place',
                    _theatrePlaceController,
                    required: true,
                    onChanged: (value) {
                      setState(() {
                        _selectedSeats.clear();
                        _bookedSeats.clear();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDateField(
                    'Show Date',
                    _selectedDate != null
                        ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                        : 'Select show date',
                  ),
                  const SizedBox(height: 16),
                  _buildTimeField(
                    'Show Time',
                    _selectedTime != null
                        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                        : '',
                  ),

                  const SizedBox(height: 16),
                  _buildDropdownField(
                    'Ticket Category',
                    'Select category',
                    ticketCategories.keys.toList(),
                    _selectedCategory,
                    (value) {
                      setState(() {
                        _selectedCategory = value;
                        _selectedTicketType = null;
                      });
                    },
                    required: true,
                  ),

                  // const SizedBox(height: 16),
                  const SizedBox(height: 16),

                  if (_selectedCategory != null)
                    _buildDropdownField(
                      'Ticket Type',
                      'Select ticket type',
                      ticketCategories[_selectedCategory]!,
                      _selectedTicketType,
                      (value) {
                        setState(() {
                          _selectedTicketType = value;
                        });
                      },
                      required: true,
                    ),

                  const SizedBox(height: 16),
                  _buildDropdownField(
                    'Number of Tickets',
                    '1',
                    ['1', '2', '3', '4', '5', '6'],
                    _selectedTicketCount,
                    (value) {
                      setState(() {
                        _selectedTicketCount = value;
                        _calculateTotalPrice();
                        _selectedSeats.clear();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSeatSelectionField(),

                  const SizedBox(height: 16),
                  _buildTextField(
                    'Price per Ticket',
                    'Enter price per ticket',
                    _pricePerTicketController,
                    required: true,
                    isNumber: true,
                  ),

                  const SizedBox(height: 10),

                  // Row(children: [Text(' ')]),

                  // const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 13,
                        child: _buildTextField(
                          '⚠️ After deducting the platform fee, below amount will be added to your wallet',
                          'Total price',
                          // _totalPriceController,
                          _finalAmountController,
                          readOnly: true,
                        ),
                      ),

                      const Expanded(flex: 2, child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFileUploadField(
                    'Upload Ticket Image',
                    false,
                    _selectedImage,
                  ),

                  //                   const SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: _buildTextField(
                  //         'Commission (10%)',
                  //         'Commission amount',
                  //         _commissionController,
                  //         readOnly: true,
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // const SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: _buildTextField(
                  //         'Final Amount (After Commission)',
                  //         'Amount you will receive',
                  //         _finalAmountController,
                  //         readOnly: true,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),

                  // _buildFileUploadField(
                  //   'Upload QR Code',
                  //   true,
                  //   _selectedQrCodeImage,
                  // ),
                  _buildTextField(
                    'QR Code Link',
                    'Paste QR code link here',
                    _qrCodeLinkController,
                    required: false,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      const Expanded(
                        child: Text(
                          'I agree to the terms and conditions',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                          _agreeToTerms &&
                              !ticketProvider.isLoading &&
                              movieOptions.isNotEmpty
                          ? _submitForm
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF214194),
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: ticketProvider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSeatSelectionField() {
    int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Seats ($ticketCount required)',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _showSeatSelectionDialog,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.event_seat, color: Colors.grey, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: _selectedSeats.isEmpty
                      ? const Text(
                          'Tap to select seats',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      : Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: _selectedSeats.map((seat) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF214194).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFF214194),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    seat.toDisplayString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF214194),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedSeats.remove(seat);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: Color(0xFF214194),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (_selectedSeats.isNotEmpty && _selectedSeats.length != ticketCount)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Selected ${_selectedSeats.length} of $ticketCount required seats',
              style: TextStyle(
                color: _selectedSeats.length == ticketCount
                    ? Colors.green
                    : Colors.orange,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    bool required = false,
    bool isNumber = false,
    bool readOnly = false,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          onChanged: onChanged,
          validator: required
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  if (isNumber && double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: readOnly ? Colors.grey[100] : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String hint,
    List<String> items,
    String? selectedValue,
    Function(String?) onChanged, {
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          validator: required
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(
              Icons.calendar_today,
              color: Colors.black,
              size: 20,
            ),
          ),
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null && picked != _selectedDate) {
              setState(() {
                _selectedDate = picked;
                _selectedSeats.clear();
                _bookedSeats.clear();
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildTimeField(String label, String displayTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          controller: TextEditingController(text: displayTime),
          decoration: InputDecoration(
            hintText: displayTime.isEmpty ? 'Select time' : null,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(
              Icons.access_time,
              color: Colors.black,
              size: 20,
            ),
          ),
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: _selectedTime ?? TimeOfDay.now(),
            );
            if (picked != null && picked != _selectedTime) {
              setState(() {
                _selectedTime = picked;
                _selectedSeats.clear();
                _bookedSeats.clear();
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildFileUploadField(
    String label,
    bool isQrCode,
    File? selectedFile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color.fromARGB(255, 181, 181, 181)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: () => _pickImage(isQrCode: isQrCode),
            borderRadius: BorderRadius.circular(12),
            child: selectedFile != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          selectedFile,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 120,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color(0xFFF0F0F0),
                          child: Icon(
                            isQrCode ? Icons.qr_code : Icons.upload_file,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isQrCode ? 'Choose QR Code' : 'Choose File',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:backup_ticket/model/movie_ticket_model.dart';
// import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:extended_image/extended_image.dart';
// import 'dart:io';
// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class SeatSelection {
//   final String row;
//   final int seatNumber;
//   bool isBooked;

//   SeatSelection({
//     required this.row,
//     required this.seatNumber,
//     this.isBooked = false,
//   });

//   @override
//   String toString() => 'Row $row - Seat $seatNumber';

//   String toDisplayString() => 'Row $row, Seat $seatNumber';

//   String toFirebaseKey() => '${row}_$seatNumber';

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is SeatSelection &&
//           runtimeType == other.runtimeType &&
//           row == other.row &&
//           seatNumber == other.seatNumber;

//   @override
//   int get hashCode => row.hashCode ^ seatNumber.hashCode;
// }

// class SellMovieTicket extends StatefulWidget {
//   const SellMovieTicket({super.key});

//   @override
//   State<SellMovieTicket> createState() => _SellMovieTicketState();
// }

// class _SellMovieTicketState extends State<SellMovieTicket> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for form fields
//   final _fullNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _theatrePlaceController = TextEditingController();
//   final _pricePerTicketController = TextEditingController();
//   final _totalPriceController = TextEditingController();

//   // Seat selection list
//   List<SeatSelection> _selectedSeats = [];
//   Map<String, bool> _bookedSeats = {}; // Store booked seats

//   // Form state variables
//   bool _agreeToTerms = false;
//   String? _selectedGender;
//   String? _selectedMovieName;
//   String? _selectedTicketType;
//   String? _selectedTicketCount = '1';
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   File? _selectedImage;
//   File? _selectedQrCodeImage;

//   String? _selectedCategory;

//   final Map<String, List<String>> ticketCategories = {
//     "Premium Seats": ["Executive", "Platinum", "Recliner"],
//     "Regular Seats": ["Normal", "Gold", "Classic"],
//     "Special Seats": [
//       "Box",
//       "Upper Balcony",
//       "Lower Balcony",
//       "First Class",
//       "Second Class",
//     ],
//   };

//   // Row options A-Z
//   final List<String> rowOptions = List.generate(
//     26,
//     (index) => String.fromCharCode(65 + index),
//   );

//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//     _pricePerTicketController.addListener(_calculateTotalPrice);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<MovieCategoryProvider>(
//         context,
//         listen: false,
//       ).fetchCategories();
//     });
//   }

//   Future<void> _loadUserData() async {
//     final name = await UserPreferences.getName();
//     final phone = await UserPreferences.getMobileNumber();
//     final email = await UserPreferences.getEmail();

//     if (mounted) {
//       setState(() {
//         if (name != null) _fullNameController.text = name;
//         if (phone != null) _phoneController.text = phone;
//         if (email != null) _emailController.text = email;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _theatrePlaceController.dispose();
//     _pricePerTicketController.dispose();
//     _totalPriceController.dispose();
//     super.dispose();
//   }

//   void _calculateTotalPrice() {
//     if (_pricePerTicketController.text.isNotEmpty &&
//         _selectedTicketCount != null) {
//       double pricePerTicket =
//           double.tryParse(_pricePerTicketController.text) ?? 0;
//       int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
//       double totalPrice = pricePerTicket * ticketCount;
//       _totalPriceController.text = totalPrice.toStringAsFixed(2);
//     }
//   }

//   // Generate unique booking key for the show
//   String _getBookingKey() {
//     if (_selectedMovieName == null ||
//         _theatrePlaceController.text.isEmpty ||
//         _selectedDate == null ||
//         _selectedTime == null) {
//       return '';
//     }

//     String dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate!);
//     String timeStr =
//         '${_selectedTime!.hour.toString().padLeft(2, '0')}${_selectedTime!.minute.toString().padLeft(2, '0')}';

//     return '${_selectedMovieName}_${_theatrePlaceController.text}_${dateStr}_$timeStr'
//         .replaceAll(' ', '_')
//         .toLowerCase();
//   }

//   // Fetch booked seats from Firebase
//   Future<void> _fetchBookedSeats() async {
//     String bookingKey = _getBookingKey();
//     if (bookingKey.isEmpty) return;

//     try {
//       DocumentSnapshot doc = await FirebaseFirestore.instance
//           .collection('booked_seats')
//           .doc(bookingKey)
//           .get();

//       if (doc.exists) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         setState(() {
//           _bookedSeats = Map<String, bool>.from(data['seats'] ?? {});
//         });
//       } else {
//         setState(() {
//           _bookedSeats = {};
//         });
//       }
//     } catch (e) {
//       print('Error fetching booked seats: $e');
//       setState(() {
//         _bookedSeats = {};
//       });
//     }
//   }

//   // Check if a seat is booked
//   bool _isSeatBooked(String row, int seatNumber) {
//     String key = '${row}_$seatNumber';
//     return _bookedSeats[key] == true;
//   }

//   // Book selected seats in Firebase
//   Future<bool> _bookSeatsInFirebase() async {
//     String bookingKey = _getBookingKey();
//     if (bookingKey.isEmpty || _selectedSeats.isEmpty) return false;

//     try {
//       // Create a map of newly selected seats
//       Map<String, bool> newSeats = {};
//       for (var seat in _selectedSeats) {
//         newSeats[seat.toFirebaseKey()] = true;
//       }

//       // Use transaction to ensure atomic update
//       await FirebaseFirestore.instance.runTransaction((transaction) async {
//         DocumentReference docRef = FirebaseFirestore.instance
//             .collection('booked_seats')
//             .doc(bookingKey);

//         DocumentSnapshot snapshot = await transaction.get(docRef);

//         Map<String, bool> currentSeats = {};
//         if (snapshot.exists) {
//           Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//           currentSeats = Map<String, bool>.from(data['seats'] ?? {});
//         }

//         // Check if any selected seat is already booked
//         for (var seatKey in newSeats.keys) {
//           if (currentSeats[seatKey] == true) {
//             throw Exception('Seat $seatKey is already booked');
//           }
//         }

//         // Merge new seats with existing seats
//         currentSeats.addAll(newSeats);

//         // Update or create document
//         transaction.set(docRef, {
//           'movieName': _selectedMovieName,
//           'theatrePlace': _theatrePlaceController.text,
//           'showDate': DateFormat('yyyy-MM-dd').format(_selectedDate!),
//           'showTime':
//               '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
//           'seats': currentSeats,
//           'lastUpdated': FieldValue.serverTimestamp(),
//         }, SetOptions(merge: true));
//       });

//       return true;
//     } catch (e) {
//       print('Error booking seats: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to book seats: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return false;
//     }
//   }

//   Future<void> _pickImage({bool isQrCode = false}) async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//         imageQuality: 85,
//       );
//       if (image != null) {
//         setState(() {
//           if (isQrCode) {
//             _selectedQrCodeImage = File(image.path);
//           } else {
//             _selectedImage = File(image.path);
//           }
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
//     }
//   }

//   // Show seat selection dialog with real-time booking status
//   Future<void> _showSeatSelectionDialog() async {
//     // First check if required fields are filled
//     if (_selectedMovieName == null ||
//         _theatrePlaceController.text.isEmpty ||
//         _selectedDate == null ||
//         _selectedTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Please fill Movie Name, Theatre Place, Show Date and Show Time first',
//           ),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }

//     // Show loading dialog while fetching booked seats
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()),
//     );

//     await _fetchBookedSeats();

//     if (!mounted) return;
//     Navigator.pop(context); // Close loading dialog

//     int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
//     List<SeatSelection> tempSelectedSeats = List.from(_selectedSeats);

//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return AlertDialog(
//               title: Text(
//                 'Select $ticketCount Seat${ticketCount > 1 ? 's' : ''}',
//               ),
//               content: SizedBox(
//                 width: double.maxFinite,
//                 height: MediaQuery.of(context).size.height * 0.6,
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade50,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.info_outline,
//                             color: Colors.blue.shade700,
//                             size: 20,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               'Selected: ${tempSelectedSeats.length} of $ticketCount seats',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.blue.shade900,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     // Legend
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildLegendItem(Colors.grey.shade200, 'Available'),
//                         _buildLegendItem(const Color(0xFF214194), 'Selected'),
//                         _buildLegendItem(Colors.red.shade300, 'Booked'),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: rowOptions.length,
//                         itemBuilder: (context, index) {
//                           final row = rowOptions[index];

//                           return ExpansionTile(
//                             leading: Icon(
//                               Icons.event_seat,
//                               color: Colors.grey.shade700,
//                             ),
//                             title: Text(
//                               'Row $row',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 8,
//                                 ),
//                                 child: Wrap(
//                                   spacing: 8,
//                                   runSpacing: 8,
//                                   children: List.generate(30, (seatIndex) {
//                                     final seatNumber = seatIndex + 1;
//                                     final seat = SeatSelection(
//                                       row: row,
//                                       seatNumber: seatNumber,
//                                     );
//                                     final isSelected = tempSelectedSeats.any(
//                                       (s) =>
//                                           s.row == row &&
//                                           s.seatNumber == seatNumber,
//                                     );
//                                     final isBooked = _isSeatBooked(
//                                       row,
//                                       seatNumber,
//                                     );

//                                     return InkWell(
//                                       onTap: isBooked
//                                           ? null
//                                           : () {
//                                               setDialogState(() {
//                                                 if (isSelected) {
//                                                   tempSelectedSeats.removeWhere(
//                                                     (s) =>
//                                                         s.row == row &&
//                                                         s.seatNumber ==
//                                                             seatNumber,
//                                                   );
//                                                 } else {
//                                                   if (tempSelectedSeats.length <
//                                                       ticketCount) {
//                                                     tempSelectedSeats.add(seat);
//                                                   } else {
//                                                     ScaffoldMessenger.of(
//                                                       context,
//                                                     ).showSnackBar(
//                                                       SnackBar(
//                                                         content: Text(
//                                                           'You can only select $ticketCount seat(s)',
//                                                         ),
//                                                         duration:
//                                                             const Duration(
//                                                               seconds: 1,
//                                                             ),
//                                                       ),
//                                                     );
//                                                   }
//                                                 }
//                                               });
//                                             },
//                                       child: Container(
//                                         width: 45,
//                                         height: 45,
//                                         decoration: BoxDecoration(
//                                           color: isBooked
//                                               ? Colors.red.shade300
//                                               : isSelected
//                                               ? const Color(0xFF214194)
//                                               : Colors.grey.shade200,
//                                           borderRadius: BorderRadius.circular(
//                                             8,
//                                           ),
//                                           border: Border.all(
//                                             color: isBooked
//                                                 ? Colors.red.shade400
//                                                 : isSelected
//                                                 ? const Color(0xFF214194)
//                                                 : Colors.grey.shade400,
//                                             width: 1.5,
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: isBooked
//                                               ? const Icon(
//                                                   Icons.close,
//                                                   color: Colors.white,
//                                                   size: 20,
//                                                 )
//                                               : Text(
//                                                   '$seatNumber',
//                                                   style: TextStyle(
//                                                     color: isSelected
//                                                         ? Colors.white
//                                                         : Colors.black87,
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: 13,
//                                                   ),
//                                                 ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: tempSelectedSeats.length == ticketCount
//                       ? () {
//                           setState(() {
//                             _selectedSeats = List.from(tempSelectedSeats);
//                           });
//                           Navigator.pop(context);
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF214194),
//                     disabledBackgroundColor: Colors.grey.shade300,
//                   ),
//                   child: const Text(
//                     'Confirm',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildLegendItem(Color color, String label) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 20,
//           height: 20,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: Colors.grey.shade400),
//           ),
//         ),
//         const SizedBox(width: 6),
//         Text(label, style: const TextStyle(fontSize: 11)),
//       ],
//     );
//   }

//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate()) return;
//     if (!_agreeToTerms) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please agree to terms and conditions')),
//       );
//       return;
//     }

//     if (_selectedDate == null || _selectedTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select show date and time')),
//       );
//       return;
//     }

//     if (_selectedMovieName == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Please select a movie')));
//       return;
//     }

//     int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
//     if (_selectedSeats.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select seats for your tickets')),
//       );
//       return;
//     }

//     if (_selectedSeats.length != ticketCount) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Please select exactly $ticketCount seat(s) matching your ticket count',
//           ),
//         ),
//       );
//       return;
//     }

//     try {
//       // Show loading dialog
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(child: CircularProgressIndicator()),
//       );

//       // First, book the seats in Firebase
//       bool seatsBooked = await _bookSeatsInFirebase();

//       if (!seatsBooked) {
//         Navigator.pop(context); // Close loading dialog
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               'Failed to book seats. Some seats may have been taken by another user.',
//             ),
//             backgroundColor: Colors.red,
//           ),
//         );
//         // Refresh booked seats and clear selection
//         await _fetchBookedSeats();
//         setState(() {
//           _selectedSeats.clear();
//         });
//         return;
//       }

//       final provider = Provider.of<MovieTicketProvider>(context, listen: false);

//       // Convert seat selections to string format
//       final seatNumbers = _selectedSeats
//           .map((seat) => seat.toDisplayString())
//           .toList();

//       // Create MovieTicket object
//       final ticket = MovieTicket(
//         fullName: _fullNameController.text.trim(),
//         phoneNumber: _phoneController.text.trim(),
//         email: _emailController.text.trim(),
//         gender: _selectedGender ?? '',
//         movieName: _selectedMovieName!,
//         theatrePlace: _theatrePlaceController.text.trim(),
//         showDate: _selectedDate!,
//         showTime:
//             '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
//         pricePerTicket: double.tryParse(_pricePerTicketController.text) ?? 0,
//         ticketType: _selectedTicketType ?? '',
//         numberOfTickets: int.tryParse(_selectedTicketCount!) ?? 1,
//         totalPrice: double.tryParse(_totalPriceController.text) ?? 0,
//         agreeToTerms: _agreeToTerms,
//         createdAt: DateTime.now(),
//         ticketCategory: _selectedCategory!,
//         seatNumbers: seatNumbers,
//       );

//       // Convert File to XFile for Firebase
//       XFile? imageXFile;
//       XFile? qrCodeXFile;

//       if (_selectedImage != null) {
//         imageXFile = XFile(_selectedImage!.path);
//       }

//       if (_selectedQrCodeImage != null) {
//         qrCodeXFile = XFile(_selectedQrCodeImage!.path);
//       }

//       // Submit to Firebase
//       final ticketId = await provider.createMovieTicket(
//         ticket,
//         imageFile: imageXFile,
//         qrCodeFile: qrCodeXFile,
//       );

//       Navigator.pop(context); // Close loading dialog

//       if (ticketId != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Movie ticket submitted successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         Navigator.pop(context); // Go back to previous screen
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Error: ${provider.error ?? 'Unknown error occurred'}',
//             ),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       Navigator.pop(context); // Close loading dialog
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error submitting ticket: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//    backgroundColor: const Color(0xFFECEFF1),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Sell Movie Tickets',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 19,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer2<MovieTicketProvider, MovieCategoryProvider>(
//         builder: (context, ticketProvider, categoryProvider, child) {
//           final activeCategories = categoryProvider.activeCategories;
//           final movieOptions = activeCategories.map((cat) => cat.name).toList();

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTextField(
//                     'Full Name',
//                     'Enter your full name',
//                     _fullNameController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'Phone Number',
//                     'Enter phone number',
//                     _phoneController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'E-Mail',
//                     'Enter email address',
//                     _emailController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'Gender',
//                     'Select Gender',
//                     ['Male', 'Female', 'Other'],
//                     _selectedGender,
//                     (value) {
//                       setState(() {
//                         _selectedGender = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   categoryProvider.isLoading
//                       ? const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(vertical: 16.0),
//                             child: CircularProgressIndicator(),
//                           ),
//                         )
//                       : movieOptions.isEmpty
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Movie Name',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade50,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   color: Colors.orange.shade200,
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.info_outline,
//                                     color: Colors.orange.shade700,
//                                     size: 20,
//                                   ),
//                                   const SizedBox(width: 12),
//                                   const Expanded(
//                                     child: Text(
//                                       'No movie categories available. Please add categories first.',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )
//                       : _buildDropdownField(
//                           'Movie Name',
//                           'Select movie name',
//                           movieOptions,
//                           _selectedMovieName,
//                           (value) {
//                             setState(() {
//                               _selectedMovieName = value;
//                               _selectedSeats.clear();
//                               _bookedSeats.clear();
//                             });
//                           },
//                           required: true,
//                         ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'Theatre Place',
//                     'Enter theatre name/place',
//                     _theatrePlaceController,
//                     required: true,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedSeats.clear();
//                         _bookedSeats.clear();
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   _buildDateField(
//                     'Show Date',
//                     _selectedDate != null
//                         ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
//                         : 'Select show date',
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTimeField(
//                     'Show Time',
//                     _selectedTime != null
//                         ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
//                         : '',
//                   ),

//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'Ticket Category',
//                     'Select category',
//                     ticketCategories.keys.toList(),
//                     _selectedCategory,
//                     (value) {
//                       setState(() {
//                         _selectedCategory = value;
//                         _selectedTicketType = null;
//                       });
//                     },
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),

//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'Number of Tickets',
//                     '1',
//                     ['1', '2', '3', '4', '5', '6'],
//                     _selectedTicketCount,
//                     (value) {
//                       setState(() {
//                         _selectedTicketCount = value;
//                         _calculateTotalPrice();
//                         _selectedSeats.clear();
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   _buildSeatSelectionField(),
//                   const SizedBox(height: 16),

//                   if (_selectedCategory != null)
//                     _buildDropdownField(
//                       'Ticket Type',
//                       'Select ticket type',
//                       ticketCategories[_selectedCategory]!,
//                       _selectedTicketType,
//                       (value) {
//                         setState(() {
//                           _selectedTicketType = value;
//                         });
//                       },
//                       required: true,
//                     ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'Price per Ticket',
//                     'Enter price per ticket',
//                     _pricePerTicketController,
//                     required: true,
//                     isNumber: true,
//                   ),

//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: _buildTextField(
//                           'Total Price',
//                           'Total price',
//                           _totalPriceController,
//                           readOnly: true,
//                         ),
//                       ),
//                       const Expanded(flex: 2, child: SizedBox()),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   _buildFileUploadField(
//                     'Upload Ticket Image',
//                     false,
//                     _selectedImage,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildFileUploadField(
//                     'Upload QR Code',
//                     true,
//                     _selectedQrCodeImage,
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: _agreeToTerms,
//                         onChanged: (value) {
//                           setState(() {
//                             _agreeToTerms = value ?? false;
//                           });
//                         },
//                         activeColor: Colors.blue,
//                       ),
//                       const Expanded(
//                         child: Text(
//                           'I agree to the terms and conditions',
//                           style: TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed:
//                           _agreeToTerms &&
//                               !ticketProvider.isLoading &&
//                               movieOptions.isNotEmpty
//                           ? _submitForm
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF214194),
//                         disabledBackgroundColor: Colors.grey[300],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: ticketProvider.isLoading
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.white,
//                                 ),
//                               ),
//                             )
//                           : const Text(
//                               'Submit',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSeatSelectionField() {
//     int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Seats ($ticketCount required)',
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         InkWell(
//           onTap: _showSeatSelectionDialog,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey, width: 1),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.event_seat, color: Colors.grey, size: 20),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: _selectedSeats.isEmpty
//                       ? const Text(
//                           'Tap to select seats',
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         )
//                       : Wrap(
//                           spacing: 6,
//                           runSpacing: 6,
//                           children: _selectedSeats.map((seat) {
//                             return Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 6,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFF214194).withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(6),
//                                 border: Border.all(
//                                   color: const Color(0xFF214194),
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     seat.toDisplayString(),
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xFF214194),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 6),
//                                   GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         _selectedSeats.remove(seat);
//                                       });
//                                     },
//                                     child: const Icon(
//                                       Icons.close,
//                                       size: 14,
//                                       color: Color(0xFF214194),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                 ),
//                 const Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.black,
//                   size: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (_selectedSeats.isNotEmpty && _selectedSeats.length != ticketCount)
//           Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: Text(
//               'Selected ${_selectedSeats.length} of $ticketCount required seats',
//               style: TextStyle(
//                 color: _selectedSeats.length == ticketCount
//                     ? Colors.green
//                     : Colors.orange,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildTextField(
//     String label,
//     String hint,
//     TextEditingController controller, {
//     bool required = false,
//     bool isNumber = false,
//     bool readOnly = false,
//     Function(String)? onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           readOnly: readOnly,
//           keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//           onChanged: onChanged,
//           validator: required
//               ? (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'This field is required';
//                   }
//                   if (isNumber && double.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 }
//               : null,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: readOnly ? Colors.grey[100] : Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdownField(
//     String label,
//     String hint,
//     List<String> items,
//     String? selectedValue,
//     Function(String?) onChanged, {
//     bool required = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: selectedValue,
//           validator: required
//               ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'This field is required';
//                   }
//                   return null;
//                 }
//               : null,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(value: value, child: Text(value));
//           }).toList(),
//           onChanged: onChanged,
//           icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateField(String label, String hint) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: true,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             suffixIcon: const Icon(
//               Icons.calendar_today,
//               color: Colors.black,
//               size: 20,
//             ),
//           ),
//           onTap: () async {
//             final DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: _selectedDate ?? DateTime.now(),
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(const Duration(days: 365)),
//             );
//             if (picked != null && picked != _selectedDate) {
//               setState(() {
//                 _selectedDate = picked;
//                 _selectedSeats.clear();
//                 _bookedSeats.clear();
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildTimeField(String label, String displayTime) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: true,
//           controller: TextEditingController(text: displayTime),
//           decoration: InputDecoration(
//             hintText: displayTime.isEmpty ? 'Select time' : null,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             suffixIcon: const Icon(
//               Icons.access_time,
//               color: Colors.black,
//               size: 20,
//             ),
//           ),
//           onTap: () async {
//             final TimeOfDay? picked = await showTimePicker(
//               context: context,
//               initialTime: _selectedTime ?? TimeOfDay.now(),
//             );
//             if (picked != null && picked != _selectedTime) {
//               setState(() {
//                 _selectedTime = picked;
//                 _selectedSeats.clear();
//                 _bookedSeats.clear();
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildFileUploadField(
//     String label,
//     bool isQrCode,
//     File? selectedFile,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           width: double.infinity,
//           height: 120,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: const Color.fromARGB(255, 181, 181, 181)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: InkWell(
//             onTap: () => _pickImage(isQrCode: isQrCode),
//             borderRadius: BorderRadius.circular(12),
//             child: selectedFile != null
//                 ? Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(
//                           selectedFile,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: 120,
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: const Icon(
//                             Icons.edit,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 16,
//                           backgroundColor: const Color(0xFFF0F0F0),
//                           child: Icon(
//                             isQrCode ? Icons.qr_code : Icons.upload_file,
//                             color: Colors.grey,
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           isQrCode ? 'Choose QR Code' : 'Choose File',
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// UserPreferences class
// class UserPreferences {
//   static const String _keyUserId = 'userId';
//   static const String _keyName = 'name';
//   static const String _keyMobileNumber = 'mobileNumber';
//   static const String _keyEmail = 'email';

//   static Future saveUser({
//     required String userId,
//     required String name,
//     required String mobileNumber,
//     required String email,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserId, userId);
//     await prefs.setString(_keyName, name);
//     await prefs.setString(_keyMobileNumber, mobileNumber);
//     await prefs.setString(_keyEmail, email);
//   }

//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserId);
//   }

//   static Future<String?> getName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyName);
//   }

//   static Future<String?> getMobileNumber() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyMobileNumber);
//   }

//   static Future<String?> getEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyEmail);
//   }

//   static Future<bool> isLoggedIn() async {
//     final userId = await getUserId();
//     return userId != null && userId.isNotEmpty;
//   }

//   static Future clearUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyUserId);
//     await prefs.remove(_keyName);
//     await prefs.remove(_keyMobileNumber);
//     await prefs.remove(_keyEmail);
//   }
// }

// // Model for seat selection
// class SeatSelection {
//   final String row;
//   final int seatNumber;

//   SeatSelection({required this.row, required this.seatNumber});

//   @override
//   String toString() => 'Row $row - Seat $seatNumber';

//   String toDisplayString() => 'Row $row, Seat $seatNumber';
// }

// class SellMovieTicket extends StatefulWidget {
//   const SellMovieTicket({super.key});

//   @override
//   State<SellMovieTicket> createState() => _SellMovieTicketState();
// }

// class _SellMovieTicketState extends State<SellMovieTicket> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for form fields
//   final _fullNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _theatrePlaceController = TextEditingController();
//   final _pricePerTicketController = TextEditingController();
//   final _totalPriceController = TextEditingController();

//   // Seat selection list
//   List<SeatSelection> _selectedSeats = [];

//   // Form state variables
//   bool _agreeToTerms = false;
//   String? _selectedGender;
//   String? _selectedMovieName;
//   String? _selectedTicketType;
//   String? _selectedTicketCount = '1';
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   File? _selectedImage;
//   File? _selectedQrCodeImage;

//   double? _theatreLatitude;
//   double? _theatreLongitude;

//   String? _selectedCategory;
//   String? _selectedTicketTypes;

//   final Map<String, List<String>> ticketCategories = {
//     "Premium Seats": ["Executive", "Platinum", "Recliner"],
//     "Regular Seats": ["Normal", "Gold", "Classic"],
//     "Special Seats": [
//       "Box",
//       "Upper Balcony",
//       "Lower Balcony",
//       "First Class",
//       "Second Class",
//     ],
//   };

//   // Row options A-Z
//   final List<String> rowOptions = List.generate(26, (index) => String.fromCharCode(65 + index));

//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     // Load user data from SharedPreferences
//     _loadUserData();

//     // Add listener to calculate total price automatically
//     _pricePerTicketController.addListener(_calculateTotalPrice);

//     // Fetch movie categories when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<MovieCategoryProvider>(
//         context,
//         listen: false,
//       ).fetchCategories();
//     });
//   }

//   // Load user data from SharedPreferences
//   Future<void> _loadUserData() async {
//     final name = await UserPreferences.getName();
//     final phone = await UserPreferences.getMobileNumber();
//     final email = await UserPreferences.getEmail();

//     if (mounted) {
//       setState(() {
//         if (name != null) _fullNameController.text = name;
//         if (phone != null) _phoneController.text = phone;
//         if (email != null) _emailController.text = email;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _theatrePlaceController.dispose();
//     _pricePerTicketController.dispose();
//     _totalPriceController.dispose();
//     super.dispose();
//   }

//   void _calculateTotalPrice() {
//     if (_pricePerTicketController.text.isNotEmpty &&
//         _selectedTicketCount != null) {
//       double pricePerTicket =
//           double.tryParse(_pricePerTicketController.text) ?? 0;
//       int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
//       double totalPrice = pricePerTicket * ticketCount;
//       _totalPriceController.text = totalPrice.toStringAsFixed(2);
//     }
//   }

//   Future<void> _pickImage({bool isQrCode = false}) async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//         imageQuality: 85,
//       );
//       if (image != null) {
//         // Navigate to cropper screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => ImageCropperScreen(
//               imageFile: File(image.path),
//               isQrCode: isQrCode,
//             ),
//           ),
//         ).then((croppedFile) {
//           if (croppedFile != null && croppedFile is File) {
//             setState(() {
//               if (isQrCode) {
//                 _selectedQrCodeImage = croppedFile;
//               } else {
//                 _selectedImage = croppedFile;
//               }
//             });
//           }
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
//     }
//   }

//   // Show seat selection dialog
//   Future<void> _showSeatSelectionDialog() async {
//     int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
//     List<SeatSelection> tempSelectedSeats = List.from(_selectedSeats);

//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return AlertDialog(
//               title: Text('Select $ticketCount Seat${ticketCount > 1 ? 's' : ''}'),
//               content: SizedBox(
//                 width: double.maxFinite,
//                 height: MediaQuery.of(context).size.height * 0.6,
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade50,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               'Selected: ${tempSelectedSeats.length} of $ticketCount seats',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.blue.shade900,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: rowOptions.length,
//                         itemBuilder: (context, index) {
//                           final row = rowOptions[index];

//                           return ExpansionTile(
//                             leading: Icon(
//                               Icons.event_seat,
//                               color: Colors.grey.shade700,
//                             ),
//                             title: Text(
//                               'Row $row',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                 child: Wrap(
//                                   spacing: 8,
//                                   runSpacing: 8,
//                                   children: List.generate(30, (seatIndex) {
//                                     final seatNumber = seatIndex + 1;
//                                     final seat = SeatSelection(row: row, seatNumber: seatNumber);
//                                     final isSelected = tempSelectedSeats.any(
//                                       (s) => s.row == row && s.seatNumber == seatNumber,
//                                     );

//                                     return InkWell(
//                                       onTap: () {
//                                         setDialogState(() {
//                                           if (isSelected) {
//                                             tempSelectedSeats.removeWhere(
//                                               (s) => s.row == row && s.seatNumber == seatNumber,
//                                             );
//                                           } else {
//                                             if (tempSelectedSeats.length < ticketCount) {
//                                               tempSelectedSeats.add(seat);
//                                             } else {
//                                               ScaffoldMessenger.of(context).showSnackBar(
//                                                 SnackBar(
//                                                   content: Text('You can only select $ticketCount seat(s)'),
//                                                   duration: const Duration(seconds: 1),
//                                                 ),
//                                               );
//                                             }
//                                           }
//                                         });
//                                       },
//                                       child: Container(
//                                         width: 45,
//                                         height: 45,
//                                         decoration: BoxDecoration(
//                                           color: isSelected
//                                               ? const Color(0xFF214194)
//                                               : Colors.grey.shade200,
//                                           borderRadius: BorderRadius.circular(8),
//                                           border: Border.all(
//                                             color: isSelected
//                                                 ? const Color(0xFF214194)
//                                                 : Colors.grey.shade400,
//                                             width: 1.5,
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             '$seatNumber',
//                                             style: TextStyle(
//                                               color: isSelected
//                                                   ? Colors.white
//                                                   : Colors.black87,
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 13,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: tempSelectedSeats.length == ticketCount
//                       ? () {
//                           setState(() {
//                             _selectedSeats = List.from(tempSelectedSeats);
//                           });
//                           Navigator.pop(context);
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF214194),
//                     disabledBackgroundColor: Colors.grey.shade300,
//                   ),
//                   child: const Text(
//                     'Confirm',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate()) return;
//     if (!_agreeToTerms) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please agree to terms and conditions')),
//       );
//       return;
//     }

//     if (_selectedDate == null || _selectedTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select show date and time')),
//       );
//       return;
//     }

//     if (_selectedMovieName == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Please select a movie')));
//       return;
//     }

//     // Validate seats are selected
//     int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
//     if (_selectedSeats.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select seats for your tickets')),
//       );
//       return;
//     }

//     if (_selectedSeats.length != ticketCount) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Please select exactly $ticketCount seat(s) matching your ticket count'
//           ),
//         ),
//       );
//       return;
//     }

//     try {
//       final provider = Provider.of<MovieTicketProvider>(context, listen: false);

//       // Convert seat selections to string format
//       final seatNumbers = _selectedSeats.map((seat) => seat.toDisplayString()).toList();

//       // Create MovieTicket object
//       final ticket = MovieTicket(
//         fullName: _fullNameController.text.trim(),
//         phoneNumber: _phoneController.text.trim(),
//         email: _emailController.text.trim(),
//         gender: _selectedGender ?? '',
//         movieName: _selectedMovieName!,
//         theatrePlace: _theatrePlaceController.text.trim(),
//         showDate: _selectedDate!,
//         showTime:
//             '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
//         pricePerTicket: double.tryParse(_pricePerTicketController.text) ?? 0,
//         ticketType: _selectedTicketType ?? '',
//         numberOfTickets: int.tryParse(_selectedTicketCount!) ?? 1,
//         totalPrice: double.tryParse(_totalPriceController.text) ?? 0,
//         agreeToTerms: _agreeToTerms,
//         createdAt: DateTime.now(),
//         ticketCategory: _selectedCategory!,
//         seatNumbers: seatNumbers,
//       );

//       // Show loading dialog
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(child: CircularProgressIndicator()),
//       );

//       // Convert File to XFile for Firebase
//       XFile? imageXFile;
//       XFile? qrCodeXFile;

//       if (_selectedImage != null) {
//         imageXFile = XFile(_selectedImage!.path);
//       }

//       if (_selectedQrCodeImage != null) {
//         qrCodeXFile = XFile(_selectedQrCodeImage!.path);
//       }

//       // Submit to Firebase
//       final ticketId = await provider.createMovieTicket(
//         ticket,
//         imageFile: imageXFile,
//         qrCodeFile: qrCodeXFile,
//       );

//       Navigator.pop(context); // Close loading dialog

//       if (ticketId != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Movie ticket submitted successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         Navigator.pop(context); // Go back to previous screen
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Error: ${provider.error ?? 'Unknown error occurred'}',
//             ),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       Navigator.pop(context); // Close loading dialog
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error submitting ticket: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Sell Movie Tickets',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 19,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer2<MovieTicketProvider, MovieCategoryProvider>(
//         builder: (context, ticketProvider, categoryProvider, child) {
//           // Get active movie categories
//           final activeCategories = categoryProvider.activeCategories;
//           final movieOptions = activeCategories.map((cat) => cat.name).toList();

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTextField(
//                     'Full Name',
//                     'Enter your full name',
//                     _fullNameController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'Phone Number',
//                     'Enter phone number',
//                     _phoneController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'E-Mail',
//                     'Enter email address',
//                     _emailController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'Gender',
//                     'Select Gender',
//                     ['Male', 'Female', 'Other'],
//                     _selectedGender,
//                     (value) {
//                       setState(() {
//                         _selectedGender = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   // Dynamic movie name dropdown from Firebase categories
//                   categoryProvider.isLoading
//                       ? const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(vertical: 16.0),
//                             child: CircularProgressIndicator(),
//                           ),
//                         )
//                       : movieOptions.isEmpty
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Movie Name',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade50,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   color: Colors.orange.shade200,
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.info_outline,
//                                     color: Colors.orange.shade700,
//                                     size: 20,
//                                   ),
//                                   const SizedBox(width: 12),
//                                   const Expanded(
//                                     child: Text(
//                                       'No movie categories available. Please add categories first.',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )
//                       : _buildDropdownField(
//                           'Movie Name',
//                           'Select movie name',
//                           movieOptions,
//                           _selectedMovieName,
//                           (value) {
//                             setState(() {
//                               _selectedMovieName = value;
//                             });
//                           },
//                           required: true,
//                         ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'Theatre Place',
//                     'Enter theatre name/place',
//                     _theatrePlaceController,
//                     required: true,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildDateField(
//                     'Show Date',
//                     _selectedDate != null
//                         ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
//                         : 'Select show date',
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTimeField(
//                     'Show Time',
//                     _selectedTime != null
//                         ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
//                         : '',
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     'Price per Ticket',
//                     'Enter price per ticket',
//                     _pricePerTicketController,
//                     required: true,
//                     isNumber: true,
//                   ),
//                   const SizedBox(height: 16),

//                   // Category dropdown
//                   _buildDropdownField(
//                     'Ticket Category',
//                     'Select category',
//                     ticketCategories.keys.toList(),
//                     _selectedCategory,
//                     (value) {
//                       setState(() {
//                         _selectedCategory = value;
//                         _selectedTicketType = null;
//                       });
//                     },
//                     required: true,
//                   ),

//                   const SizedBox(height: 16),

//                   // Ticket type dropdown (appears only after category)
//                   if (_selectedCategory != null)
//                     _buildDropdownField(
//                       'Ticket Type',
//                       'Select ticket type',
//                       ticketCategories[_selectedCategory]!,
//                       _selectedTicketType,
//                       (value) {
//                         setState(() {
//                           _selectedTicketType = value;
//                         });
//                       },
//                       required: true,
//                     ),

//                   const SizedBox(height: 16),
//                   _buildDropdownField(
//                     'Number of Tickets',
//                     '1',
//                     ['1', '2', '3', '4', '5', '6'],
//                     _selectedTicketCount,
//                     (value) {
//                       setState(() {
//                         _selectedTicketCount = value;
//                         _calculateTotalPrice();
//                         // Clear selected seats when ticket count changes
//                         _selectedSeats.clear();
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   // Seat selection field
//                   _buildSeatSelectionField(),

//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: _buildTextField(
//                           'Total Price',
//                           'Total price',
//                           _totalPriceController,
//                           readOnly: true,
//                         ),
//                       ),
//                       const Expanded(flex: 2, child: SizedBox()),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   _buildFileUploadField(
//                     'Upload Ticket Image',
//                     false,
//                     _selectedImage,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildFileUploadField(
//                     'Upload QR Code',
//                     true,
//                     _selectedQrCodeImage,
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: _agreeToTerms,
//                         onChanged: (value) {
//                           setState(() {
//                             _agreeToTerms = value ?? false;
//                           });
//                         },
//                         activeColor: Colors.blue,
//                       ),
//                       const Expanded(
//                         child: Text(
//                           'I agree to the terms and conditions',
//                           style: TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed:
//                           _agreeToTerms &&
//                               !ticketProvider.isLoading &&
//                               movieOptions.isNotEmpty
//                           ? _submitForm
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF214194),
//                         disabledBackgroundColor: Colors.grey[300],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: ticketProvider.isLoading
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.white,
//                                 ),
//                               ),
//                             )
//                           : const Text(
//                               'Submit',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSeatSelectionField() {
//     int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Seats ($ticketCount required)',
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         InkWell(
//           onTap: _showSeatSelectionDialog,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey, width: 1),
//             ),
//             child: Row(
//               children: [
//                 const Icon(
//                   Icons.event_seat,
//                   color: Colors.grey,
//                   size: 20,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: _selectedSeats.isEmpty
//                       ? const Text(
//                           'Tap to select seats',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         )
//                       : Wrap(
//                           spacing: 6,
//                           runSpacing: 6,
//                           children: _selectedSeats.map((seat) {
//                             return Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 6,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFF214194).withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(6),
//                                 border: Border.all(
//                                   color: const Color(0xFF214194),
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     seat.toDisplayString(),
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xFF214194),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 6),
//                                   GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         _selectedSeats.remove(seat);
//                                       });
//                                     },
//                                     child: const Icon(
//                                       Icons.close,
//                                       size: 14,
//                                       color: Color(0xFF214194),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                 ),
//                 const Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.black,
//                   size: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (_selectedSeats.isNotEmpty && _selectedSeats.length != ticketCount)
//           Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: Text(
//               'Selected ${_selectedSeats.length} of $ticketCount required seats',
//               style: TextStyle(
//                 color: _selectedSeats.length == ticketCount
//                     ? Colors.green
//                     : Colors.orange,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildTextField(
//     String label,
//     String hint,
//     TextEditingController controller, {
//     bool required = false,
//     bool isNumber = false,
//     bool readOnly = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           readOnly: readOnly,
//           keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//           validator: required
//               ? (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'This field is required';
//                   }
//                   if (isNumber && double.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 }
//               : null,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: readOnly ? Colors.grey[100] : Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdownField(
//     String label,
//     String hint,
//     List<String> items,
//     String? selectedValue,
//     Function(String?) onChanged, {
//     bool required = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: selectedValue,
//           validator: required
//               ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'This field is required';
//                   }
//                   return null;
//                 }
//               : null,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(value: value, child: Text(value));
//           }).toList(),
//           onChanged: onChanged,
//           icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateField(String label, String hint) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: true,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             suffixIcon: const Icon(
//               Icons.calendar_today,
//               color: Colors.black,
//               size: 20,
//             ),
//           ),
//           onTap: () async {
//             final DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: _selectedDate ?? DateTime.now(),
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(const Duration(days: 365)),
//             );
//             if (picked != null && picked != _selectedDate) {
//               setState(() {
//                 _selectedDate = picked;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildTimeField(String label, String displayTime) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: true,
//           controller: TextEditingController(text: displayTime),
//           decoration: InputDecoration(
//             hintText: displayTime.isEmpty ? 'Select time' : null,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.grey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue, width: 1),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 12,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             suffixIcon: const Icon(
//               Icons.access_time,
//               color: Colors.black,
//               size: 20,
//             ),
//           ),
//           onTap: () async {
//             final TimeOfDay? picked = await showTimePicker(
//               context: context,
//               initialTime: _selectedTime ?? TimeOfDay.now(),
//             );
//             if (picked != null && picked != _selectedTime) {
//               setState(() {
//                 _selectedTime = picked;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildFileUploadField(
//     String label,
//     bool isQrCode,
//     File? selectedFile,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           width: double.infinity,
//           height: 120,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: const Color.fromARGB(255, 181, 181, 181)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: InkWell(
//             onTap: () => _pickImage(isQrCode: isQrCode),
//             borderRadius: BorderRadius.circular(12),
//             child: selectedFile != null
//                 ? Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(
//                           selectedFile,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: 120,
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: const Icon(
//                             Icons.crop,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 16,
//                           backgroundColor: const Color(0xFFF0F0F0),
//                           child: Icon(
//                             isQrCode ? Icons.qr_code : Icons.upload_file,
//                             color: Colors.grey,
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           isQrCode ? 'Choose QR Code' : 'Choose File',
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         const Text(
//                           'Tap to crop',
//                           style: TextStyle(color: Colors.grey, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class ImageCropperScreen extends StatefulWidget {
  final File imageFile;
  final bool isQrCode;

  const ImageCropperScreen({
    super.key,
    required this.imageFile,
    this.isQrCode = false,
  });

  @override
  State<ImageCropperScreen> createState() => _ImageCropperScreenState();
}

class _ImageCropperScreenState extends State<ImageCropperScreen> {
  final GlobalKey<ExtendedImageEditorState> _editorKey =
      GlobalKey<ExtendedImageEditorState>();

  double? _aspectRatio;
  Size? _originalImageSize;
  Map<String, double> _aspectRatios = {};

  @override
  void initState() {
    super.initState();
    _loadOriginalImageSize();
  }

  void _loadOriginalImageSize() async {
    final data = await widget.imageFile.readAsBytes();
    final decodedImage = await decodeImageFromList(data);
    final originalWidth = decodedImage.width.toDouble();
    final originalHeight = decodedImage.height.toDouble();
    final originalRatio = originalWidth / originalHeight;

    setState(() {
      _originalImageSize = Size(originalWidth, originalHeight);
      _aspectRatios = {
        'Original': originalRatio,
        '1:1': 1.0,
        '16:9': 16 / 9,
        '9:16': 9 / 16,
        '7:5': 7 / 5,
        '5:7': 5 / 7,
      };
      // For QR codes, default to square (1:1), otherwise use original
      _aspectRatio = widget.isQrCode ? 1.0 : originalRatio;
    });
  }

  void _cropAndReturn() async {
    final state = _editorKey.currentState;
    if (state == null) return;

    final Uint8List? croppedData = await _cropImageDataWithDartLibrary(state);

    if (croppedData == null) {
      print("Cropping failed");
      return;
    }

    try {
      // Use application documents directory instead of temp
      final appDir = await getApplicationDocumentsDirectory();
      final cropDir = Directory('${appDir.path}/cropped_images');

      // Create directory if it doesn't exist
      if (!await cropDir.exists()) {
        await cropDir.create(recursive: true);
      }

      final filePath =
          '${cropDir.path}/cropped_${widget.isQrCode ? 'qr_' : ''}${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(croppedData);

      // Return the cropped file
      Navigator.pop(context, file);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving cropped image: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error in _cropAndReturn: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_aspectRatios.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final aspectRatio = _aspectRatio == 0.0 ? null : _aspectRatio;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF214194),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.isQrCode ? "Crop QR Code" : "Crop Ticket Image",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: _cropAndReturn,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExtendedImage.file(
              widget.imageFile,
              fit: BoxFit.contain,
              mode: ExtendedImageMode.editor,
              extendedImageEditorKey: _editorKey,
              initEditorConfigHandler: (state) {
                return EditorConfig(
                  maxScale: 8.0,
                  cropRectPadding: const EdgeInsets.all(20.0),
                  hitTestSize: 20.0,
                  cropAspectRatio: aspectRatio,
                );
              },
              cacheRawData: true,
            ),
          ),
          _buildAspectRatioSelector(),
        ],
      ),
    );
  }

  Widget _buildAspectRatioSelector() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.black,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _aspectRatios.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(
                entry.key,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              selected: _aspectRatio == entry.value,
              onSelected: (_) => setState(() => _aspectRatio = entry.value),
              selectedColor: const Color(0xFF214194),
              backgroundColor: Colors.grey[800],
              labelStyle: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<Uint8List?> _cropImageDataWithDartLibrary(
    ExtendedImageEditorState state,
  ) async {
    final Rect cropRect = state.getCropRect()!;
    final Uint8List data = state.rawImageData!;
    final ui.Image image = await decodeImageFromList(data);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    final srcRect = cropRect;
    final dstRect = Rect.fromLTWH(0, 0, cropRect.width, cropRect.height);

    canvas.drawImageRect(image, srcRect, dstRect, paint);

    final picture = recorder.endRecording();
    final ui.Image croppedImage = await picture.toImage(
      cropRect.width.toInt(),
      cropRect.height.toInt(),
    );

    final byteData = await croppedImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData?.buffer.asUint8List();
  }
}
