import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:extended_image/extended_image.dart';

class ImageCropperScreen extends StatefulWidget {
  final File imageFile;
  final bool isQrCrop;
  
  const ImageCropperScreen({
    super.key,
    required this.imageFile,
    this.isQrCrop = false,
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
  int _currentStep = 0; // 0 = crop QR, 1 = done
  File? _croppedQrImage;

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
      _aspectRatio = 1.0; // Default to square for QR code
    });
  }

  Future<void> _cropQrCode() async {
    final state = _editorKey.currentState;
    if (state == null) return;

    final Uint8List? croppedData = await _cropImageDataWithDartLibrary(state);

    if (croppedData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cropping failed')),
      );
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/qr_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(croppedData);

    setState(() {
      _croppedQrImage = file;
      _currentStep = 1;
    });
  }

void _finishCropping() {
  if (_croppedQrImage != null) {
    print('Returning: Full=${widget.imageFile.path}, QR=${_croppedQrImage!.path}');
    Navigator.pop(context, {
      'fullImage': widget.imageFile,
      'qrImage': _croppedQrImage,
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please crop the QR code first'),
        backgroundColor: Colors.red,
      ),
    );
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

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF214194),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _currentStep == 0 ? "Crop QR Code" : "Review Images",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          if (_currentStep == 0)
            IconButton(
              icon: const Icon(Icons.check, color: Colors.white),
              onPressed: _cropQrCode,
            )
          else
            IconButton(
              icon: const Icon(Icons.done_all, color: Colors.white),
              onPressed: _finishCropping,
            ),
        ],
      ),
      body: _currentStep == 0 ? _buildCropView() : _buildReviewView(),
    );
  }

  Widget _buildCropView() {
    final aspectRatio = _aspectRatio == 0.0 ? null : _aspectRatio;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF214194).withOpacity(0.2),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.white, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Please crop only the QR code area from your ticket',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
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
        // _buildAspectRatioSelector(),
      ],
    );
  }

  Widget _buildReviewView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Full Ticket Image',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(
                widget.imageFile,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Cropped QR Code',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.file(
                  _croppedQrImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Both images are ready. Tap the checkmark to continue.',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
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
              label: Text(entry.key, style: const TextStyle(color: Colors.white)),
              selected: _aspectRatio == entry.value,
              onSelected: (_) => setState(() => _aspectRatio = entry.value),
              selectedColor: Colors.white24,
              backgroundColor: Colors.grey[800],
              labelStyle: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<Uint8List?> _cropImageDataWithDartLibrary(
      ExtendedImageEditorState state) async {
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

    final byteData =
        await croppedImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }
}