import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_nude_detector/flutter_nude_detector.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MaterialApp(home: App()));

/// Main view of flutter_nude_detector example
class App extends StatefulWidget {
  /// App constructor
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  File? _image;
  bool _containsNudity = false;

  Future<dynamic> _onButtonPressed() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      final imageFile = File(image.path);
      final hasNudity = await FlutterNudeDetector.hasNudity(image: imageFile);

      setState(() {
        _image = imageFile;
        _containsNudity = hasNudity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _image == null
            ? const Text('No image has been selected')
            : Stack(
          alignment: Alignment.center,
          children: [
            Image.file(File(_image!.path)),
            NudityStatusChip(containsNudity: _containsNudity),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: ElevatedButton(
          onPressed: _onButtonPressed,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text('Open gallery'),
          ),
        ),
      ),
    );
  }
}

/// Widget chip that's shows nudity status
class NudityStatusChip extends StatelessWidget {
  /// NudityStatusChip constructor
  const NudityStatusChip({required this.containsNudity, super.key});

  /// Variable that indicate if image contains nudity or not
  final bool containsNudity;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: containsNudity ? Colors.red : Colors.green,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            32,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Text(
          containsNudity ? 'Contains nudity!' : 'Does not contain nudity',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
