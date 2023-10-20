
import 'package:flutter/material.dart';
import 'export_note_input.dart';

var logics = ConnectionCheck();

class ConnectionCheck {

  Future<void> savedState(BuildContext context) async {
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
    } else {
      
      print('Updating note');
      GlobalControllers.providerRef.read(noteTittle.notifier).state =
          GlobalControllers.noteTittleContext!.text;
      GlobalControllers.providerRef.read(noteBody.notifier).state =
          GlobalControllers.noteContext!.text;

      String notebodyValue =
          GlobalControllers.providerRef.read(noteBody.notifier).state;
      print("Current notebody value: $notebodyValue");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: themeColor,
          content: Text(
            "Note Saved",
            style: AppTextStyle.textStyle().copyWith(fontSize: 15.sp),
          ),
          duration: Duration(seconds: 5),
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

// Function to capture photo
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
                recordingAudio(context);
                print(" click is working");
              },
            ),
          ],
        );
      },
    );
  }

// Recording Audio
  String recordedAudioFile = '';
  Future<void> recordingAudio(BuildContext context) async {
    GlobalControllers.controller?.reset();
    try {
      if (await GlobalControllers.controller!.checkPermission()) {
        await GlobalControllers.controller!.record();
      }
    } catch (e) {
      print("error recording $e");
    }

    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            // Prevent dialog from closing if the user clicks outside the dialog
            return false;
          },
          child: AlertDialog(
            title: Text("Recording in Progress",
                style: AppTextStyle.textStyle()
                    .copyWith(fontSize: 20.sp, color: Colors.black)),
            content: AudioWaveforms(
              size: Size(MediaQuery.of(context).size.width, 100.0),
              recorderController: GlobalControllers.controller,
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
                    String? path = await GlobalControllers.controller.stop();
                    recordedAudioFile = path!;
                    Navigator.of(context).pop();
                  },
                  child: Text("Stop Recording"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// Playing Audio
  Future<void> playAudio(BuildContext context) async {
    // Ensure that a recorded audio file path is available
    if (recordedAudioFile == null) {
      return;
    }

    try {
      print('Audio is playing now');
      await GlobalControllers.playerController.preparePlayer(
        path: recordedAudioFile,
        shouldExtractWaveform: true,
        noOfSamples: 100,
        volume: 1.0,
      );

      // Listen to audio completion and dispose when finished
      GlobalControllers.playerController.onCompletion.listen((_) {
        print('Audio playback completed');
        // player_controller.dispose();
      });

      await GlobalControllers.playerController
          .startPlayer(finishMode: FinishMode.stop);
    } catch (e) {
      print("Error playing audio: $e");
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AudioFileWaveforms(
                size: Size(150.sp, 50.sp),
                playerController: GlobalControllers.playerController,
                enableSeekGesture: true,
                waveformType: WaveformType.long,
                waveformData: [],
                playerWaveStyle: const PlayerWaveStyle(
                  fixedWaveColor: Color.fromARGB(255, 220, 153, 148),
                  liveWaveColor: Colors.blueAccent,
                  spacing: 6,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await GlobalControllers.playerController.stopPlayer();
                  Navigator.pop(context);
                },
                child: Text('Stop Audio'),
              ),
            ],
          ),
        );
      },
    );
  }
}
