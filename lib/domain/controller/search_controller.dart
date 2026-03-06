

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/search_model.dart';
import '../../data/services/api_service.dart';

class QueryController extends GetxController {
  final ApiService _apiService = ApiService();
  final TextEditingController textController = TextEditingController();


  final RxBool isLoading = false.obs;
  final Rxn<SearchResponse> searchResponse = Rxn<SearchResponse>();
  final RxString errorMessage = ''.obs;
  final RxString selectedMode = 'auto'.obs;

  final List<String> availableModes = [
    'auto',
    'academic',
    'writing',
    'math',
    'video',
    'social',
  ];


  Future<void> search() async {
    final query = textController.text.trim();
    if (query.isEmpty) return;

    isLoading.value = true;
    errorMessage.value = '';
    searchResponse.value = null;

    try {
      final result = await _apiService.search(
        query: query,
        searchMode: selectedMode.value,
      );
      searchResponse.value = result;
      Get.toNamed('/result');
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear search state and go back to home.
  void clearSearch() {
    textController.clear();
    searchResponse.value = null;
    errorMessage.value = '';
    Get.offAllNamed('/');
  }

  void setMode(String mode) => selectedMode.value = mode;

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
