import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:media_scanner/media_scanner.dart';

class PdfPreviewScreen extends StatelessWidget {
  final File tempFile;

  const PdfPreviewScreen({super.key, required this.tempFile});

  Future<void> _downloadPdf(BuildContext context) async {
    try {
      final Directory downloadDir =
          Directory('/storage/emulated/0/Download');

      final String finalPath =
          '${downloadDir.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';

      final File finalFile = await tempFile.copy(finalPath);

      // 🔥 Make visible in Downloads
      await MediaScanner.loadMedia(path: finalFile.path);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Invoice downloaded successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Download failed: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Download',
            onPressed: () => _downloadPdf(context),
          ),
        ],
      ),
      body: PDFView(
        filePath: tempFile.path,
        enableSwipe: true,
        autoSpacing: true,
        pageFling: true,
      ),
    );
  }
}
