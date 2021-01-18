import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// Widget to capture and crop the image
class ImagePickerButton extends StatefulWidget {
  final ImageFileCallback onFileCropped;
  String imageUrl;

  ImagePickerButton({this.onFileCropped, this.imageUrl});
  createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  bool hasImage = false;

  /// Active image file
  File _imageFile;

  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();

  /// Cropper plugin
  Future<void> _cropImage(PickedFile image) async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: image.path,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.indigo,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop It',
      ),
      cropStyle: CropStyle.circle,
      aspectRatio: CropAspectRatio(
        ratioX: 1.0,
        ratioY: 1.0,
      ),
      maxWidth: 80,
      maxHeight: 80,
    );

    setState(() {
      print('cropped: $cropped');
      _imageFile = cropped ?? image.path;
      print('image: $_imageFile');
      widget.onFileCropped(_imageFile);
      hasImage = true;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage({BuildContext context}) async {
    await _displayPickImageDialog(context, (ImageSource source) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
          maxWidth: 512,
          maxHeight: 512,
        );
        setState(() {
          _cropImage(pickedFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  void initState() {
    super.initState();
    if (_imageFile != null || widget.imageUrl != null) {
      hasImage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 180.0,
          height: 180.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              SizedBox(
                width: 160.0,
                height: 160.0,
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  value: 1.0,
                  valueColor: hasImage
                      ? AlwaysStoppedAnimation<Color>(Colors.indigo)
                      : AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              hasImage
                  ? CircleAvatar(
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile)
                          : NetworkImage(widget.imageUrl +
                              '&' +
                              DateTime.now().toString()),
                      backgroundColor: Color(0xFFC5CAE9),
                      radius: 80.0,
                    )
                  : CircleAvatar(
                      radius: 80.0,
                      backgroundColor: Color(0xFFC5CAE9),
                    ),
              GestureDetector(
                onTap: () {
                  _pickImage(context: context);
                },
                child: CircleAvatar(
                  child: Icon(
                    hasImage ? Icons.edit : Icons.add_a_photo,
                  ),
                  radius: 24.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
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
                title: new Text('Câmera'),
                onTap: () {
                  onPick(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text('Galeria de Fotos'),
                onTap: () {
                  onPick(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

typedef void OnPickImageCallback(ImageSource source);
typedef ImageFileCallback(File image);
