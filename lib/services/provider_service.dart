import 'package:devswipe/const.dart';
import 'package:devswipe/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProviderService extends ChangeNotifier {
  UserModel? user;

  bool isLoading = true;
  String error = '';

  ProviderService() {
    getUser();
  }

  Future<void> getUser() async {
    isLoading = true;
    try {
      http.Response response = await http.get(
        Uri.parse('$api/users/profile'),
        headers: {
          'x-api-key': apiKey,
          "Authorization": authToken,
        },
      );

      if (response.statusCode == 200) {
        print(response
            .body); // Check if 'data' exists and is in the correct format
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('data')) {
          user = UserModel.fromJson(
              jsonResponse['data']); // Pass only the 'data' object
          isLoading = false;
          print("id : ${user!.id}");
        } else {
          error = 'Error: Missing data key in response';
          print(error);
        }
      } else {
        error = 'Error ${response.statusCode}';
        print("User Error: $error");
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
