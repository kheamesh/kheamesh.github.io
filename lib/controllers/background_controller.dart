import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  var mousePos = Offset.zero.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void updateMousePos(Offset pos) {
    mousePos.value = pos;
  }
}
