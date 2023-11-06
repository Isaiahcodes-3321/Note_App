
import 'package:noteapp/Screens/Add_Note/controller.dart';

import 'export_note_input.dart';
import 'package:flutter/material.dart';


class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 28, 27, 27),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Hero(
            tag: 'imageTag',
            child: Image.file(
              File(logics.image!.path),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
    );
  }
}
