
import 'dart:io';
import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class CreateMovie extends StatefulWidget {
  const CreateMovie({super.key});

  @override
  State<CreateMovie> createState() => _CreateMovieState();
}

class _CreateMovieState extends State<CreateMovie> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagController = TextEditingController();

  final List<String> _tags = [];
  final List<String> _languages = []; // Store language variants

  // Language selection
  String? _selectedLanguage;
  String? _selectedFormat;

  // Available options
  final List<String> _availableLanguages = [
    'Telugu',
    'Kannada',
    'Tamil',
    'Hindi',
    'Malayalam',
    'English',
  ];

  final List<String> _availableFormats = ['2D', '3D', 'IMAX'];

  File? _selectedImage;
  Uint8List? _webImage;
  String? _selectedFileName;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _webImage = bytes;
            _selectedFileName = pickedFile.name;
            _selectedImage = null;
          });
        } else {
          setState(() {
            _selectedImage = File(pickedFile.path);
            _selectedFileName = pickedFile.name;
            _webImage = null;
          });
        }
      }
    } catch (e) {
      _showSnackBar('Error picking image: $e', isError: true);
    }
  }

  void _addTag() {
    if (_tagController.text.trim().isNotEmpty) {
      final tag = _tagController.text.trim();
      if (!_tags.contains(tag)) {
        setState(() {
          _tags.add(tag);
          _tagController.clear();
        });
      } else {
        _showSnackBar('Tag already exists', isError: true);
      }
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _addLanguage() {
    if (_selectedLanguage == null || _selectedFormat == null) {
      _showSnackBar('Please select both language and format', isError: true);
      return;
    }

    final languageVariant = '$_selectedLanguage $_selectedFormat';

    if (!_languages.contains(languageVariant)) {
      setState(() {
        _languages.add(languageVariant);
        _selectedLanguage = null;
        _selectedFormat = null;
      });
    } else {
      _showSnackBar('This language variant already exists', isError: true);
    }
  }

  void _removeLanguage(String language) {
    setState(() {
      _languages.remove(language);
    });
  }

  Future<void> _createCategory() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedImage == null && _webImage == null) {
      _showSnackBar('Please select an image', isError: true);
      return;
    }

    if (_tags.isEmpty) {
      _showSnackBar('Please add at least one tag', isError: true);
      return;
    }

    if (_languages.isEmpty) {
      _showSnackBar('Please add at least one language variant', isError: true);
      return;
    }

    final provider = Provider.of<MovieCategoryProvider>(context, listen: false);

    bool success;

    if (kIsWeb && _webImage != null) {
      success = await provider.createCategoryFromBytes(
        name: _nameController.text.trim(),
        imageBytes: _webImage,
        fileName: _selectedFileName ?? 'category_image.jpg',
        tags: _tags,
        languages: _languages, // Pass languages
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );
    } else if (_selectedImage != null) {
      success = await provider.createCategory(
        name: _nameController.text.trim(),
        imageFile: _selectedImage,
        tags: _tags,
        languages: _languages, // Pass languages
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );
    } else {
      _showSnackBar('No image selected', isError: true);
      return;
    }

    if (success) {
      _showSnackBar('Category created successfully!');
      Navigator.pop(context);
    } else {
      _showSnackBar(
        provider.error ?? 'Failed to create category',
        isError: true,
      );
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Movie Category'), elevation: 0),
      body: Consumer<MovieCategoryProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Picker Section
                      const Text(
                        'Category Image',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey[400]!,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: _selectedImage != null || _webImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: kIsWeb && _webImage != null
                                      ? Image.memory(
                                          _webImage!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                      : Image.file(
                                          _selectedImage!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 64,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tap to select image',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Category Name
                      const Text(
                        'Category Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'e.g., Kantara, RRR, KGF',
                          prefixIcon: const Icon(Icons.movie_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a movie name';
                          }
                          if (value.trim().length < 2) {
                            return 'Name must be at least 2 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Description
                      const Text(
                        'Description (Optional)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText:
                              'Add a brief description about this movie...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Languages Section
                      // const Text(
                      //   'Language Variants',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      // Container(
                      //   padding: const EdgeInsets.all(16),
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue[50],
                      //     borderRadius: BorderRadius.circular(12),
                      //     border: Border.all(color: Colors.blue[200]!),
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: DropdownButtonFormField<String>(
                      //               value: _selectedLanguage,
                      //               decoration: InputDecoration(
                      //                 labelText: 'Language',
                      //                 prefixIcon: const Icon(Icons.language),
                      //                 border: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                 ),
                      //                 filled: true,
                      //                 fillColor: Colors.white,
                      //               ),
                      //               items: _availableLanguages.map((lang) {
                      //                 return DropdownMenuItem(
                      //                   value: lang,
                      //                   child: Text(lang),
                      //                 );
                      //               }).toList(),
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   _selectedLanguage = value;
                      //                 });
                      //               },
                      //             ),
                      //           ),
                      //           const SizedBox(width: 12),
                      //           Expanded(
                      //             child: DropdownButtonFormField<String>(
                      //               value: _selectedFormat,
                      //               decoration: InputDecoration(
                      //                 labelText: 'Format',
                      //                 prefixIcon: const Icon(Icons.theaters),
                      //                 border: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                 ),
                      //                 filled: true,
                      //                 fillColor: Colors.white,
                      //               ),
                      //               items: _availableFormats.map((format) {
                      //                 return DropdownMenuItem(
                      //                   value: format,
                      //                   child: Text(format),
                      //                 );
                      //               }).toList(),
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   _selectedFormat = value;
                      //                 });
                      //               },
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(height: 12),
                      //       SizedBox(
                      //         width: double.infinity,
                      //         child: ElevatedButton.icon(
                      //           onPressed: _addLanguage,
                      //           icon: const Icon(Icons.add),
                      //           label: const Text('Add Language Variant'),
                      //           style: ElevatedButton.styleFrom(
                      //             padding: const EdgeInsets.symmetric(
                      //               vertical: 16,
                      //             ),
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(12),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Language Variants',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),

                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.blue[200]!),
                              ),
                              child: Column(
                                children: [
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      // If screen width is small → show dropdowns in column
                                      final isSmall =
                                          constraints.maxWidth < 350;

                                      return isSmall
                                          ? Column(
                                              children: [
                                                DropdownButtonFormField<String>(
                                                  value: _selectedLanguage,
                                                  decoration: InputDecoration(
                                                    labelText: 'Language',
                                                    prefixIcon: const Icon(
                                                      Icons.language,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                  ),
                                                  items: _availableLanguages
                                                      .map((lang) {
                                                        return DropdownMenuItem(
                                                          value: lang,
                                                          child: Text(lang),
                                                        );
                                                      })
                                                      .toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedLanguage = value;
                                                    });
                                                  },
                                                ),
                                                const SizedBox(height: 12),
                                                DropdownButtonFormField<String>(
                                                  value: _selectedFormat,
                                                  decoration: InputDecoration(
                                                    labelText: 'Format',
                                                    prefixIcon: const Icon(
                                                      Icons.theaters,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                  ),
                                                  items: _availableFormats.map((
                                                    format,
                                                  ) {
                                                    return DropdownMenuItem(
                                                      value: format,
                                                      child: Text(format),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedFormat = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Flexible(
                                                  child: DropdownButtonFormField<String>(
                                                    value: _selectedLanguage,
                                                    decoration: InputDecoration(
                                                      labelText: 'Language',
                                                      prefixIcon: const Icon(
                                                        Icons.language,
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    items: _availableLanguages
                                                        .map((lang) {
                                                          return DropdownMenuItem(
                                                            value: lang,
                                                            child: Text(lang),
                                                          );
                                                        })
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedLanguage =
                                                            value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Flexible(
                                                  child: DropdownButtonFormField<String>(
                                                    value: _selectedFormat,
                                                    decoration: InputDecoration(
                                                      labelText: 'Format',
                                                      prefixIcon: const Icon(
                                                        Icons.theaters,
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    items: _availableFormats.map(
                                                      (format) {
                                                        return DropdownMenuItem(
                                                          value: format,
                                                          child: Text(format),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedFormat = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                    },
                                  ),

                                  const SizedBox(height: 12),

                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: _addLanguage,
                                      icon: const Icon(Icons.add),
                                      label: const Text('Add Language Variant'),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
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

                      const SizedBox(height: 12),

                      // Display Languages
                      if (_languages.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Added Languages:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _languages.map((language) {
                                  return Chip(
                                    label: Text(language),
                                    deleteIcon: const Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                    onDeleted: () => _removeLanguage(language),
                                    backgroundColor: Colors.green[100],
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Tags Section
                      const Text(
                        'Tags',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _tagController,
                              decoration: InputDecoration(
                                hintText: 'Add a tag (e.g., Action, Thriller)',
                                prefixIcon: const Icon(Icons.label_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                              onFieldSubmitted: (_) => _addTag(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _addTag,
                            icon: const Icon(Icons.add),
                            label: const Text('Add'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Display Tags
                      if (_tags.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _tags.map((tag) {
                              return Chip(
                                label: Text(tag),
                                deleteIcon: const Icon(Icons.close, size: 18),
                                onDeleted: () => _removeTag(tag),
                                backgroundColor: Colors.blue[100],
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                      const SizedBox(height: 32),

                      // Create Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: provider.isLoading
                              ? null
                              : _createCategory,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: provider.isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Create Movie',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Loading Overlay
              if (provider.isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text(
                              'Creating movie...',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
