import 'package:flutter/material.dart';
import 'export_note_input.dart';

var connectionCheck = ConnectionCheck();

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
      // setState(() {
      image = pickedFile;
      // });
    }
  }

  // get image from user phone storage
  Future<void> getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    // setState(() {
    image = pickedFile;
    // });
  }

//  Audio recording
  bool isRecording = false;

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
              title: Text(!isRecording ? 'Start Recording' : 'Stop Recording'),
              onTap: () {
                setState() {
                  isRecording = !isRecording;
                }
              },
            ),
          ],
        );
      },
    );
  }


}
