import 'package:flutter/material.dart';
import 'export_note_input.dart';
import 'dart:ui' as ui;

var logics = ConnectionCheck();

class ConnectionCheck {
  Future<void> showBanner(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: themeColor,
          content: Text(
            "Failed to Save. Please check your internet connection.",
            style: AppTextStyle.textStyle().copyWith(fontSize: 15.sp),
          ),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  final ImagePicker picker = ImagePicker();
  XFile? image;
  // Function to show the options bottom sheet
  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera, color: Colors.black, size: 23.sp),
              title: Text('Take a photo',
                  style: AppTextStyle.textStyle()
                      .copyWith(fontSize: 18.sp, color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                takePhoto();
              },
            ),
            ListTile(
              leading: Icon(Icons.image, color: Colors.black, size: 23.sp),
              title: Text('Choose from gallery',
                  style: AppTextStyle.textStyle()
                      .copyWith(fontSize: 18.sp, color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                getImage();
              },
            ),
          ],
        );
      },
    );
  }

// Function to capture a photo
  Future<void> takePhoto() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = pickedFile;
    }
  }

  // get image from user phone storage
  Future<void> getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    image = pickedFile;
  }

//  Audio recording
  bool isRecording = true;

  void showAudioOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.record_voice_over_outlined,
                  color: Colors.black, size: 23.sp),
              title: Text('Start Recording',
                  style: AppTextStyle.textStyle()
                      .copyWith(fontSize: 18.sp, color: Colors.black)),
              onTap: () {
                // setState() {
                isRecording = !isRecording;
                recordingAudio(context);
                print(" clik is working");
                // }
              },
            ),
          ],
        );
      },
    );
  }

  var audio;
  RecorderController controller = RecorderController();
  Future<void> recordingAudio(BuildContext context) async {
    final hasPermission = await controller.checkPermission();
    await controller.record();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Recording in Progress",
                  style: AppTextStyle.textStyle()
                      .copyWith(fontSize: 20.sp, color: Colors.black)),
              content: AudioWaveforms(
                size: Size(MediaQuery.of(context).size.width, 100.0),
                recorderController: controller,
                enableGesture: true,
                waveStyle: WaveStyle(
                  waveColor: Colors.blue,
                  showDurationLabel: true,
                  spacing: 8.0,
                  showBottom: false,
                  extendWaveform: true,
                  showMiddleLine: false,
                ),
              ),
              actions: [
                SizedBox(
                  height: 3.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      await controller.stop();
                      Navigator.of(context).pop();
                    },
                    child: Text("Stop Recording"),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
