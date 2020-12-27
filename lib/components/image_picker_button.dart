import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatefulWidget {
  ImagePickerButton();

  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  void _onImageButtonPressed({BuildContext context}) async {
    await _displayPickImageDialog(context, (ImageSource source) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
          maxWidth: 512,
          maxHeight: 512,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    print('_imageFile: $_imageFile');
    if (_imageFile != null) {
      print('kIsWeb: $kIsWeb');
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
        print('imageFile: ${_imageFile.path}');
        return CircleAvatar(
          child: Image.network(_imageFile.path),
        );
      } else {
        return Semantics(
          child: CircleAvatar(
            child: Image.file(
              File(_imageFile.path),
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.black,
            radius: 70.0,
          ),
          label: 'image_picker_example_picked_image',
        );
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return SizedBox(
        width: 180.0,
        height: 180.0,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            Center(
              child: new CircleAvatar(
                radius: 80.0,
                backgroundColor: const Color(0xFF778899),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onImageButtonPressed(context: context);
              },
              child: CircleAvatar(
                child: Icon(
                  Icons.add_a_photo,
                  size: 30.0,
                  color: Colors.white,
                ),
                radius: 33.0,
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
              ? FutureBuilder<void>(
                  future: retrieveLostData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    print(
                        'snapshot.connectionState: ${snapshot.connectionState}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return GestureDetector(
                          onTap: () {
                            // _onImageButtonPressed(ImageSource.camera,
                            //     context: context);
                          },
                          child: Center(
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                Center(
                                  child: new CircleAvatar(
                                    radius: 80.0,
                                    backgroundColor: const Color(0xFF778899),
                                  ),
                                ),
                                Center(
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 80.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      case ConnectionState.done:
                        return _previewImage();
                      default:
                        if (snapshot.hasError) {
                          return Text(
                            'Pick image error: ${snapshot.error}}',
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              // _onImageButtonPressed(ImageSource.camera,
                              //     context: context);
                            },
                            child: Center(
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: <Widget>[
                                  Center(
                                    child: new CircleAvatar(
                                      radius: 80.0,
                                      backgroundColor: const Color(0xFF778899),
                                    ),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 80.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    }
                  },
                )
              : _previewImage(),
        ),
      ],
    );
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Wrap(
              children: <Widget>[
                Text(
                  'Escudo do time',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('Camera'),
                  onTap: () {
                    print('Take a Photo');
                    onPick(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Gallery'),
                  onTap: () {
                    print('Pick Image from gallery');
                    onPick(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                Row(
                  children: [
                    FlatButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      padding: EdgeInsets.all(16.0),
                      splashColor: Colors.white38,
                      onPressed: () {
                        print('Take a Photo');
                        onPick(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 36.0,
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      padding: EdgeInsets.all(16.0),
                      splashColor: Colors.white38,
                      onPressed: () {
                        print('Pick Image from gallery');
                        onPick(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo_library,
                            size: 36.0,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

typedef void OnPickImageCallback(ImageSource source);
