import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:gpt_chat/classes/message_class.dart';
import 'package:gpt_chat/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TextChatScreen extends StatefulWidget {
  const TextChatScreen({super.key});

  @override
  State<TextChatScreen> createState() => _TextChatScreenState();
}

class _TextChatScreenState extends State<TextChatScreen> {
  TextEditingController _userInput = TextEditingController();
  @override
  void dispose() {
    _userInput.dispose();
    super.dispose();
  }

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [];

   File? _imageFile;
  String? imageText;
  String output = "";

  String extractedText = "";


  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      
      sendImage ();
    }
  }

  Future<void> sendMessage() async {
    final message = _userInput.text;
    _userInput.clear();
    setState(() {
      _messages
          .add(Message(isUser: true, message: message, date: DateTime.now()));
    });

    final content = [Content.text(message)];

    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
    });
  }
    Future<void> sendImage() async {
 final inputImage = InputImage.fromFilePath(_imageFile!.path);
    final textrecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textrecognizer.processImage(inputImage);
        
        setState(() {
          extractedText = recognizedText.text;
          
        });
        
    
    // print(extractedText);
    // print(output);

    final message = extractedText;
    setState(() {
      _messages
          .add(Message(isUser: true, message: _imageFile, date: DateTime.now()));
    });

    final content = [Content.text(message)];

    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
    });
    print(response.text);
  }


  

  //showdialoug
  void myDialoug() {
  
  showDialog(
              context: context,
              builder: (BuildContext context){
                  return AlertDialog(
                    title: const Text("Choose from"),
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           TextButton(onPressed: (){
                            _pickImage();
                            Navigator.pop(context);
                           }, child: const Text('Gallery',style: const TextStyle(color: Colors.black,fontSize: 17),)),
                             TextButton(onPressed: (){}, child: const Text('Camera',style: TextStyle(color: Colors.black,fontSize: 17),))
                        ],
                      ),
                      
                    ),
                    actions: [ 
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text('Close',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold))),
                         
                    ],
                  );
                  
              }
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aadhikar'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {
                  //show dialoug with options camera and gallery
                  myDialoug();
                },
                icon: const Icon(Icons.document_scanner)),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: ListView.builder(
                    physics: const PageScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Messages(
                          isUser: message.isUser,
                          message: message.message,
                          date: DateFormat('HH:mm').format(message.date));
                    })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _userInput,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          label: const Text('Enter Your Message')),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      padding: const EdgeInsets.all(12),
                      iconSize: 30,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all(const CircleBorder())),
                      onPressed: () {
                        sendMessage();
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Message {
  final bool isUser;
  var message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}
