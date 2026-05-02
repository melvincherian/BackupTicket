
// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class CloudinaryService {
  static const String cloudName = 'do9dkxsc0';
  static const String uploadPreset = 'backupticket';
  static const String apiKey = '994986936173835';
  static const String apiSecret = '-SKpyiXJuNtwqxvOidQf7eLAvms';

  // Upload image from File (for mobile/desktop)
  static Future<String?> uploadImage(File imageFile) async {
    try {
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
      
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset
        ..fields['folder'] = 'movie_tickets' // Optional: organize images in folders
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = jsonDecode(responseData);
        return decodedData['secure_url'];
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        final responseData = await response.stream.bytesToString();
        print('Error response: $responseData');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Upload image from bytes (for web platform)
  static Future<String?> uploadImageFromBytes(Uint8List imageBytes, String fileName) async {
    try {
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
      
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset
        ..fields['folder'] = 'movie_tickets'
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          imageBytes,
          filename: fileName,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = jsonDecode(responseData);
        return decodedData['secure_url'];
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        final responseData = await response.stream.bytesToString();
        print('Error response: $responseData');
        return null;
      }
    } catch (e) {
      print('Error uploading image from bytes: $e');
      return null;
    }
  }

  // Delete image from Cloudinary using public_id
  static Future<bool> deleteImage(String imageUrl) async {
    try {
      // Extract public_id from URL
      final publicId = _extractPublicIdFromUrl(imageUrl);
      if (publicId == null) {
        print('Could not extract public_id from URL: $imageUrl');
        return false;
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final signature = _generateSignature(publicId, timestamp);

      final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/destroy');
      
      final response = await http.post(
        uri,
        body: {
          'public_id': publicId,
          'api_key': apiKey,
          'timestamp': timestamp,
          'signature': signature,
        },
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return decodedData['result'] == 'ok';
      } else {
        print('Image deletion failed with status: ${response.statusCode}');
        print('Error response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting image: $e');
      return false;
    }
  }

  // Extract public_id from Cloudinary URL
  static String? _extractPublicIdFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      
      // Find the index of 'upload' in the path
      int uploadIndex = pathSegments.indexOf('upload');
      if (uploadIndex == -1) return null;
      
      // The public_id is everything after the version (if present) or after upload
      int startIndex = uploadIndex + 1;
      
      // Skip version if present (starts with 'v' followed by numbers)
      if (startIndex < pathSegments.length && 
          pathSegments[startIndex].startsWith('v') &&
          pathSegments[startIndex].substring(1).contains(RegExp(r'^\d+$'))) {
        startIndex++;
      }
      
      if (startIndex >= pathSegments.length) return null;
      
      // Join remaining segments and remove file extension
      List<String> publicIdParts = pathSegments.sublist(startIndex);
      String publicId = publicIdParts.join('/');
      
      // Remove file extension
      int lastDotIndex = publicId.lastIndexOf('.');
      if (lastDotIndex != -1) {
        publicId = publicId.substring(0, lastDotIndex);
      }
      
      return publicId;
    } catch (e) {
      print('Error extracting public_id: $e');
      return null;
    }
  }

  // Generate signature for authenticated requests
  static String _generateSignature(String publicId, String timestamp) {
    // This is a simplified signature generation
    // For production, you might want to use a proper HMAC-SHA1 implementation
    final paramsToSign = 'public_id=$publicId&timestamp=$timestamp$apiSecret';
    
    // For now, using a simple hash - consider using crypto package for HMAC-SHA1
    return _sha1Hash(paramsToSign);
  }

  // Simple SHA1 hash implementation (consider using crypto package)
  static String _sha1Hash(String input) {
    // This is a placeholder - use the crypto package for proper SHA1 hashing
    // For now, return a basic hash
    return input.hashCode.abs().toString();
  }

  // Transform image URL with Cloudinary transformations
  static String transformImageUrl(String originalUrl, {
    int? width,
    int? height,
    String? crop = 'fill',
    String? quality = 'auto',
    String? format = 'auto',
  }) {
    try {
      final uri = Uri.parse(originalUrl);
      final pathSegments = uri.pathSegments.toList();
      
      // Find upload segment
      int uploadIndex = pathSegments.indexOf('upload');
      if (uploadIndex == -1) return originalUrl;
      
      // Build transformation string
      List<String> transformations = [];
      
      if (width != null) transformations.add('w_$width');
      if (height != null) transformations.add('h_$height');
      if (crop != null) transformations.add('c_$crop');
      if (quality != null) transformations.add('q_$quality');
      if (format != null) transformations.add('f_$format');
      
      if (transformations.isEmpty) return originalUrl;
      
      // Insert transformations after upload
      pathSegments.insert(uploadIndex + 1, transformations.join(','));
      
      // Reconstruct URL
      return uri.replace(pathSegments: pathSegments).toString();
    } catch (e) {
      print('Error transforming image URL: $e');
      return originalUrl;
    }
  }
}