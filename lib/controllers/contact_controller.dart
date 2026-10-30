import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_colors.dart';
import '../firebase_options.dart';

class ContactController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final isLoading = false.obs;
  final isSuccess = false.obs;
  final errorMessage = ''.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> _ensureFirebaseInitialized() async {
    if (Firebase.apps.isEmpty) {
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } catch (e) {
        debugPrint('Firebase initialization in ContactController warning: $e');
      }
    }
  }

  Future<bool> _saveViaRestApi(
    String name,
    String email,
    String message,
    String now,
  ) async {
    try {
      final apiKey = DefaultFirebaseOptions.currentPlatform.apiKey;
      final connect = GetConnect(timeout: const Duration(seconds: 10));
      final body = {
        'fields': {
          'name': {'stringValue': name},
          'email': {'stringValue': email},
          'message': {'stringValue': message},
          'createdAt': {'stringValue': now},
        },
      };

      final baseUrl =
          'https://firestore.googleapis.com/v1/projects/resume-a3e92/databases/(default)/documents';

      // 1. Post to top-level contacts with API key
      final resp1 = await connect.post('$baseUrl/contacts?key=$apiKey', body);

      // 2. Post to /data/A2UdF5PIX4lS8LuiTosy/contacts with API key
      final resp2 = await connect.post(
        '$baseUrl/data/A2UdF5PIX4lS8LuiTosy/contacts?key=$apiKey',
        body,
      );

      // 3. Update summary in /data/A2UdF5PIX4lS8LuiTosy
      final patchBody = {
        'fields': {
          'lastSubmission': {
            'mapValue': {
              'fields': {
                'name': {'stringValue': name},
                'email': {'stringValue': email},
                'message': {'stringValue': message},
                'createdAt': {'stringValue': now},
              },
            },
          },
          'updatedAt': {'stringValue': now},
        },
      };

      await connect.patch(
        '$baseUrl/data/A2UdF5PIX4lS8LuiTosy?key=$apiKey&updateMask.fieldPaths=lastSubmission&updateMask.fieldPaths=updatedAt',
        patchBody,
      );

      debugPrint(
        'Firestore REST API response 1 status: ${resp1.statusCode}, body: ${resp1.body}',
      );
      debugPrint(
        'Firestore REST API response 2 status: ${resp2.statusCode}, body: ${resp2.body}',
      );

      if (resp1.isOk ||
          resp2.isOk ||
          resp1.statusCode == 200 ||
          resp2.statusCode == 200) {
        return true;
      }

      // 4. Try Firebase Realtime Database REST API fallback
      try {
        final rtdbResp = await connect.post(
          'https://resume-a3e92-default-rtdb.firebaseio.com/contacts.json',
          {'name': name, 'email': email, 'message': message, 'createdAt': now},
        );
        debugPrint(
          'Realtime DB REST API response status: ${rtdbResp.statusCode}, body: ${rtdbResp.body}',
        );
        if (rtdbResp.isOk || rtdbResp.statusCode == 200) {
          return true;
        }
      } catch (rtdbErr) {
        debugPrint('Realtime DB REST API write exception: $rtdbErr');
      }
    } catch (e) {
      debugPrint('Firestore REST API write exception: $e');
    }
    return false;
  }

  Future<void> submitContactForm() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty) {
      _showSnackbar(
        AppStrings.requiredField,
        AppStrings.enterNameError,
        isError: true,
      );
      return;
    }

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      _showSnackbar(
        AppStrings.invalidEmailTitle,
        AppStrings.enterValidEmailError,
        isError: true,
      );
      return;
    }

    if (message.isEmpty) {
      _showSnackbar(
        AppStrings.requiredField,
        AppStrings.enterMessageError,
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    isSuccess.value = false;

    await _ensureFirebaseInitialized();

    bool savedSuccessfully = false;
    String lastError = '';

    final now = DateTime.now().toIso8601String();
    final contactData = {
      'name': name,
      'email': email,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'createdAt': now,
    };

    try {
      // 1. If Firebase Native SDK is initialized, try standard SDK write
      if (Firebase.apps.isNotEmpty) {
        try {
          await FirebaseFirestore.instance
              .collection('contacts')
              .add(contactData);
          savedSuccessfully = true;
          debugPrint('Successfully saved to top-level contacts via SDK');
        } catch (e) {
          lastError = e.toString();
          debugPrint('Top-level contacts SDK write warning: $e');
        }

        try {
          final docRef = FirebaseFirestore.instance.doc(
            'data/A2UdF5PIX4lS8LuiTosy',
          );

          await docRef.collection('contacts').add(contactData);

          await docRef.set({
            'lastSubmission': {
              'name': name,
              'email': email,
              'message': message,
              'createdAt': now,
            },
            'messages': FieldValue.arrayUnion([
              {
                'name': name,
                'email': email,
                'message': message,
                'createdAt': now,
              },
            ]),
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

          savedSuccessfully = true;
          debugPrint(
            'Successfully saved to /data/A2UdF5PIX4lS8LuiTosy via SDK',
          );
        } catch (e) {
          if (lastError.isEmpty) lastError = e.toString();
          debugPrint(
            'Document /data/A2UdF5PIX4lS8LuiTosy SDK write warning: $e',
          );
        }
      }

      // 2. Fallback to Firestore REST API (e.g. Windows desktop stub or uninitialized native SDK)
      if (!savedSuccessfully) {
        debugPrint(
          'Firestore SDK write unavailable or failed. Attempting Firestore REST API fallback...',
        );
        savedSuccessfully = await _saveViaRestApi(name, email, message, now);
      }

      if (!savedSuccessfully) {
        throw Exception(lastError.isNotEmpty ? lastError : 'permission-denied');
      }

      isSuccess.value = true;
      nameController.clear();
      emailController.clear();
      messageController.clear();

      _showSnackbar(
        AppStrings.success,
        AppStrings.contactSuccessMessage,
        isError: false,
      );
    } catch (e) {
      debugPrint('Firestore submission error: $e');
      errorMessage.value = e.toString();

      String userFriendlyMessage = e.toString();
      if (e.toString().contains('permission-denied')) {
        userFriendlyMessage =
            'Firebase Permission Denied: Check Firestore Security Rules in Firebase Console.';
      } else if (e.toString().contains('not-found') ||
          e.toString().contains('NOT_FOUND')) {
        userFriendlyMessage =
            'Firestore Database not found: Please create Firestore Database in Firebase Console.';
      } else if (e.toString().contains('API key') ||
          e.toString().contains('api-key') ||
          e.toString().contains('unauthorized') ||
          e.toString().contains('YourWebApiKeyPlaceholder')) {
        userFriendlyMessage = AppStrings.invalidApiKeyError;
      }

      // Try mailto fallback if permission is denied or no method channel
      if (e.toString().contains('permission-denied') ||
          e.toString().contains('NOT_FOUND') ||
          e.toString().contains('no-app')) {
        try {
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: AppStrings.email,
            queryParameters: {
              'subject': 'Portfolio Message from $name',
              'body': 'Name: $name\nEmail: $email\n\nMessage:\n$message',
            },
          );
          await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
        } catch (_) {}
      }

      _showSnackbar(
        AppStrings.submissionErrorTitle,
        userFriendlyMessage,
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackbar(String title, String message, {required bool isError}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError
          ? AppColors.redAccent.withValues(alpha: 0.9)
          : AppColors.green.withValues(alpha: 0.9),
      colorText: AppColors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
      duration: const Duration(seconds: 6),
    );
  }
}
