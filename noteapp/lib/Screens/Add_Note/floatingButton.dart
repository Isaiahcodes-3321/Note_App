import 'export_note_input.dart';
import 'package:flutter/material.dart';


class ImageAudioButton extends StatefulWidget {
  const ImageAudioButton({super.key});

  @override
  State<ImageAudioButton> createState() => _ImageAudioButtonState();
}

class _ImageAudioButtonState extends State<ImageAudioButton> {

    bool isButtonVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
              // color: Colors.black,
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height * 0.35,
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                fit: StackFit.loose,
                children: [
                  FloatingActionButton(
                    focusElevation: 30,
                    onPressed: () {
                      setState(() {
                        isButtonVisible = !isButtonVisible;
                      });
                    },
                    backgroundColor: themeColor,
                    child: Icon(
                      isButtonVisible ? Icons.close : Icons.add,
                      color: AppTextStyle.appBarTextColor,
                      size: 25.sp,
                    ),
                  ),
                  if (isButtonVisible)
                    Positioned(
                      top: 0.h,
                      child: Column(
                        children: [
                          // image button
                          FloatingActionButton(
                            onPressed: () {
                              logics.showImagePickerOptions(context);
                            },
                            backgroundColor: themeColor,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: AppTextStyle.appBarTextColor,
                              size: 25.sp,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          // audio button
                          FloatingActionButton(
                            onPressed: () {
                              logics.showAudioOptions(context);
                            },
                            backgroundColor: themeColor,
                            child: Icon(
                              Icons.audiotrack_outlined,
                              color: AppTextStyle.appBarTextColor,
                              size: 25.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
  }
}