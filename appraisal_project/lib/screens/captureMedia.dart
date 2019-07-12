import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class CaptureMedia extends StatefulWidget {
  CaptureMedia({Key key, this.mediaAttachments}) : super(key: key);

  final List<String> mediaAttachments;

  @override
  _CaptureMediaState createState() => _CaptureMediaState();
}

class _CaptureMediaState extends State<CaptureMedia> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File _imageFile;
  List<String> mediaAttached = List<String>();
  dynamic _pickImageError;
  bool isVideo = false;
  VideoPlayerController _controller;
  String _retrieveDataError;
  bool _isButtonDisabled;

  //copy recieved media array into local array it can be updated with new media
  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
    var len;
    if (widget.mediaAttachments.isEmpty) {
      len = 0;
    } else {
      len = widget.mediaAttachments.length;
    }

    for (var k = 0; k < len; k++) {
      var n = widget.mediaAttachments[k];
      mediaAttached.add(n);
    }
  }

  //get image and enable sumbit selected media button
  void _onImageButtonPressed(ImageSource source) async {
    var image;

    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(_onVideoControllerUpdate);
    }

    if (isVideo) {
      ImagePicker.pickVideo(source: source).then((File file) {
        if (file != null && mounted) {
          setState(() {
            _controller = VideoPlayerController.file(file)
              ..addListener(_onVideoControllerUpdate)
              ..setVolume(1.0)
              ..initialize()
              ..setLooping(true)
              ..play();
          });
        }
      });
    } else {
      try {
        image = await ImagePicker.pickImage(source: source);
      } catch (e) {
        _pickImageError = e;
      }
      setState(() {
        _imageFile = image;
        _isButtonDisabled = false;
      });
    }
  }

  void _onVideoControllerUpdate() {
    setState(() {});
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(_onVideoControllerUpdate);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Widget _previewVideo(VideoPlayerController controller) {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    } else if (controller.value.initialized) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: AspectRatioVideo(controller),
      );
    } else {
      return const Text(
        'Error Loading Video',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Image.file(_imageFile);
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.video) {
          isVideo = true;
          _controller = VideoPlayerController.file(response.file)
            ..addListener(_onVideoControllerUpdate)
            ..setVolume(1.0)
            ..initialize()
            ..setLooping(true)
            ..play();
        } else {
          isVideo = false;
          _imageFile = response.file;
        }
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  //show message in snackbar
  void showMessage(String message, [MaterialColor color = Colors.lightBlue]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color, content: Center(child: new Text(message))));
  }

  Future _uploadPic(BuildContext context) async {
    //upload selected picture to firebase
    String filename = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = taskSnapshot.ref.getDownloadURL().toString();
    print(downloadUrl);

    setState(() {
      if (mediaAttached == null) {
        mediaAttached = [];
      }

      mediaAttached.add(downloadUrl);
      showMessage("Media Uploaded Successfully!");
      _imageFile = null;
      _isButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text('Capture Media'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context, mediaAttached),
          )),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Platform.isAndroid
                  ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return isVideo
                                ? _previewVideo(_controller)
                                : _previewImage();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                      },
                    )
                  : (isVideo ? _previewVideo(_controller) : _previewImage()),
            ),
            new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0,right: 40),
                child: new RaisedButton(
                    child: const Text('Submit Selected Media'),
                    onPressed: () {
                      _isButtonDisabled ? null : _uploadPic(context);
                    }))
          ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              isVideo = false;
              _onImageButtonPressed(ImageSource.gallery);
            },
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            child: const Icon(Icons.photo_library),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'image1',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.gallery);
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: const Icon(Icons.video_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: const Icon(Icons.videocam),
            ),
          ),
        ],
      ),
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
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.initialized) {
      initialized = controller.value.initialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value?.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
