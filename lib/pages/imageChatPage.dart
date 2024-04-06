import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:gpt_chat/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class ImageChatPage extends StatefulWidget {
  const ImageChatPage({super.key});

  @override
  State<ImageChatPage> createState() => _ImageChatPageState();
}

class _ImageChatPageState extends State<ImageChatPage> {
//pick Image
  File? _imageFile;
  String? imageText;
  String output = "";

  String extractedText = "";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      
      _processImage();
    }
  }

  Future<void> _processImage() async {
    final inputImage = InputImage.fromFilePath(_imageFile!.path);
    final textrecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textrecognizer.processImage(inputImage);
        
        setState(() {
          extractedText = recognizedText.text;
          
        });
        final content = [Content.text(extractedText)];
        final response = await model.generateContent(content);
        
        setState(() {
          output = response.text!;
        });
    
    print(extractedText);
    print(output);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aadhikar'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  child: InkWell(
                    onTap: () {
                      _pickImage();
                    },
                    child: Container(
                      height: 60,
                      width: double.maxFinite,
                      child: const Center(
                        child: Text('Please select an image'),
                      ),
                    ),
                  ),
                ),
                output != "" ?  Text(output):SizedBox( child: Text("Image not selected")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
