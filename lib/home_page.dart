import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sample_project/claude_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variables
  File? _image;
  String? _description;
  bool _isLoading = false;
  final _picker = ImagePicker();

  // Pick The Image
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await _picker.pickImage(
        source: source,
        maxHeight: 1080,
        maxWidth: 1920,
        imageQuality: 85,
      );

      // Image has been chosen? start the analysis
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
        await _analyzeImage();
      }
    } catch (e) {
      print(e);
    }
  }

  // Analyze Image Function
  Future<void> _analyzeImage() async {
    // If no image chosen to analyze
    if (_image == null) return;

    // loading....
    setState(() {
      _isLoading = true;
    });

    try {
      final desc = await ClaudeService().analyzeImage(_image!);

      setState(() {
        _description = desc;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yashwant's Creation"),
      ),
      body: Column(
        children: [
          // display Image
          Container(
            height: 300,
            color: Colors.grey,
            child: _image != null
                ? Image.file(_image!)
                : const Center(child: Text("Choose an image...")),
          ),

          const SizedBox(
            height: 25,
          ),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Take a Photo using Camera
              ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: const Text("Take Photo")),

              // Take From Gallery
              ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text("Pick From Gallery"))
            ],
          ),

          const SizedBox(
            height: 25,
          ),

          // Description loading...
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )

          // Description loaded
          else if (_description != null)
            Text(_description!),
        ],
      ),
    );
  }
}
