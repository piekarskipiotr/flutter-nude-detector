import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Detect nudity in images
class FlutterNudeDetector {
  static const _threshold = 0.7;
  static const _modelPath = 'assets/ml_models/nude.tflite';

  /// Image has to be type of InputImage, You can create one with following
  /// functions: InputImage.fromBytes(), InputImage.fromFile() or
  /// InputImage.fromFilePath()
  /// You can also specify custom values of threshold and path to model .tflite
  /// default threshold is 0.7 and default path to model is assets/ml_models/nude.tflite
  static Future<bool> hasNudity({
    required InputImage image,
    double threshold = _threshold,
    String modelAssetsPath = _modelPath,
  }) async {
    try {
      final modelPath = await _getModel(modelAssetsPath);
      final options = LocalLabelerOptions(
        modelPath: modelPath,
        confidenceThreshold: threshold,
      );

      final imageLabeler = ImageLabeler(options: options);
      final imageLabels = await imageLabeler.processImage(image);
      if (imageLabels.isEmpty) return false;

      final label = imageLabels.first;
      switch (label.index) {
        case 0:
          return label.confidence < threshold;
        case 1:
          return label.confidence > threshold;
        default:
          return false;
      }
    } catch (e) {
      if (kDebugMode) {
        log('flutter_nude_detector throwing error!', error: e);
      }

      return false;
    }
  }

  // Get path to model .tflite
  static Future<String> _getModel(String assetPath) async {
    if (Platform.isAndroid) return assetPath;

    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    final file = File(path);

    await Directory(dirname(path)).create(recursive: true);
    if (!file.existsSync()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
    }

    return file.path;
  }
}
