import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/helper/static_helper.dart';
import 'package:backup_ticket/views/auth/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _confirmDelete = false;
  bool _isDeleting = false;

  final Dio _dio = Dio();

  /// 🔥 DELETE ACCOUNT API CALL
  Future<void> _deleteAccount() async {
    final String? userId = await UserPreferences.getUserId();
    final String? token = await SharedPrefsHelper.getToken();

    debugPrint('━━━━━━━━━━ DELETE ACCOUNT ━━━━━━━━━━');
    debugPrint('🧑 USER ID: $userId');
    debugPrint('🔐 TOKEN: ${token != null ? "FOUND" : "NOT FOUND"}');

    if (userId == null || userId.isEmpty) {
      _showSnack('User ID not found', Colors.red);
      return;
    }

    if (token == null) {
      _showSnack('Authentication token missing', Colors.red);
      return;
    }

    final String url =
        'http://31.97.206.144:8127/api/auth/deletemyaccount/$userId';

    setState(() => _isDeleting = true);

    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          validateStatus: (status) => true, // 🔥 allow all responses
        ),
      );

      debugPrint('✅ STATUS CODE: ${response.statusCode}');
      debugPrint('✅ RESPONSE TYPE: ${response.data.runtimeType}');
      debugPrint('✅ RAW RESPONSE: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        await UserPreferences.clearUser();

        if (!mounted) return;

        _showSnack('Account deleted successfully', Colors.green);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (_) => false,
        );
      } else {
        String errorMessage = 'Failed to delete account';

        if (response.data is Map<String, dynamic>) {
          errorMessage = response.data['message'] ?? errorMessage;
        } else if (response.data is String) {
          errorMessage = response.data;
        }

        _showSnack(errorMessage, Colors.red);
      }
    } catch (e) {
      debugPrint('❌ DELETE ERROR: $e');
      _showSnack('Something went wrong', Colors.red);
    } finally {
      if (mounted) {
        setState(() => _isDeleting = false);
      }
    }
  }

  /// ⚠️ CONFIRMATION DIALOG
  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: const [
              Icon(Icons.warning_amber_rounded,
                  color: Colors.red, size: 28),
              SizedBox(width: 8),
              Text('Delete Account?'),
            ],
          ),
          content: const Text(
            'This action is permanent.\n\n'
            'All your data will be permanently deleted.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                _deleteAccount();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Account')),
      body: _isDeleting
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Deleting your account...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete_forever,
                        size: 80,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Delete Your Account',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'This action is permanent and cannot be undone.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CheckboxListTile(
                    value: _confirmDelete,
                    onChanged: (value) {
                      setState(() => _confirmDelete = value ?? false);
                    },
                    title: const Text(
                      'I understand my account will be permanently deleted.',
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _confirmDelete
                          ? _showDeleteConfirmationDialog
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Delete My Account',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
