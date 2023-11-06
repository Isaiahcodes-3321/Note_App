// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../Api_Service/api_class.dart';
import 'export_note_input.dart';

var logics = ConnectionCheck();
ApiServiceState apiService = ApiServiceState();

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
          duration: const Duration(seconds: 4),
        ),
      );
    } else {
      print('Updating note');
      GlobalControllers.providerRef
          .read(UserNewNotes.noteTittle.notifier)
          .state = GlobalControllers.noteTittleContext.text;
      GlobalControllers.providerRef.read(UserNewNotes.noteBody.notifier).state =
          GlobalControllers.noteContext.text;

      apiService.saveUserNote(context);
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
  // String recordedAudioFile = 'lib/Audio_file/recorded_audio';
  String recordedAudio = '';
  Future<void> recordingAudio(BuildContext context) async {
    GlobalControllers.controller.reset();
    try {
      if (await GlobalControllers.controller.checkPermission()) {
        await GlobalControllers.controller.record();
      }
    } catch (e) {
      print("error recording $e");
    }

    showDialog(
      context: context,
      builder: (context) {
        // ignore: deprecated_member_use
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
              waveStyle: const WaveStyle(
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
                    recordedAudio = path!;
                    Navigator.of(context).pop();
                  },
                  child: const Text("Stop Recording"),
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

    try {
      print('Audio is playing now');

      print('audio is about to play');
      await GlobalControllers.playerController.preparePlayer(
        path: recordedAudio,
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
                waveformData: const [],
                playerWaveStyle: const PlayerWaveStyle(
                  fixedWaveColor: Color.fromARGB(255, 220, 153, 148),
                  liveWaveColor: Colors.blueAccent,
                  spacing: 6,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await GlobalControllers.playerController.stopPlayer();
                  Navigator.pop(context);
                },
                child: const Text('Stop Audio'),
              ),
            ],
          ),
        );
      },
    );
  }
}
