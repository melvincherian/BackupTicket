// import 'dart:convert';
// import 'package:backup_ticket/constant/api_constant.dart';
// import 'package:backup_ticket/model/cart_model.dart';
// import 'package:http/http.dart' as http;


// class CartService {
//   // Add ticket to cart
//   Future<Map<String, dynamic>> addToCart(AddToCartRequest request) async {
//     try {
//       final response = await http.post(
//         Uri.parse(ApiConstants.addtoCart),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(request.toJson()),
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return {
//           'success': true,
//           'message': data['message'] ?? 'Added to cart successfully',
//           'data': data,
//         };
//       } else {
//         return {
//           'success': false,
//           'message': data['message'] ?? 'Failed to add to cart',
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Error: ${e.toString()}',
//       };
//     }
//   }

//   // Get cart by userId
//   Future<Map<String, dynamic>> getCart(String userId) async {
//     try {
//       final url = ApiConstants.getCart.replaceAll(':userId', userId);
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         final cart = CartModel.fromJson(data['cart']);
//         return {
//           'success': true,
//           'message': data['message'] ?? 'Cart fetched successfully',
//           'cart': cart,
//         };
//       } else {
//         return {
//           'success': false,
//           'message': data['message'] ?? 'Failed to fetch cart',
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Error: ${e.toString()}',
//       };
//     }
//   }
// }


















import 'dart:convert';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/model/cart_model.dart';
import 'package:http/http.dart' as http;

class CartService {
  /// ================= ADD TO CART =================
  Future<Map<String, dynamic>> addToCart(AddToCartRequest request) async {
    try {
      final payload = request.toJson();

      print('🛒 ADD TO CART API');
      print('➡️ URL: ${ApiConstants.addtoCart}');
      print('📦 REQUEST PAYLOAD: ${jsonEncode(payload)}');

      final response = await http.post(
        Uri.parse(ApiConstants.addtoCart),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      print('⬅️ STATUS CODE: ${response.statusCode}');
      print('📥 RESPONSE BODY: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Added to cart successfully',
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add to cart',
        };
      }
    } catch (e, st) {
      print('❌ ADD TO CART ERROR: $e');
      print('📌 STACKTRACE: $st');

      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  /// ================= GET CART =================
  Future<Map<String, dynamic>> getCart(String userId) async {
    try {
      final url = ApiConstants.getCart.replaceAll(':userId', userId);

      print('🛍️ GET CART API');
      print('➡️ URL: $url');
      print('📦 REQUEST PARAM: userId=$userId');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      print('⬅️ STATUS CODE: ${response.statusCode}');
      print('📥 RESPONSE BODY: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final cart = CartModel.fromJson(data['cart']);

        return {
          'success': true,
          'message': data['message'] ?? 'Cart fetched successfully',
          'cart': cart,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch cart',
        };
      }
    } catch (e, st) {
      print('❌ GET CART ERROR: $e');
      print('📌 STACKTRACE: $st');

      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
}
