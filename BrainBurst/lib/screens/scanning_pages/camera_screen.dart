// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';


// class CameraScreen extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const CameraScreen({Key? key, required this.cameras}) : super(key: key);

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(
//       widget.cameras[0],
//       ResolutionPreset.medium,
//     );

//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller);
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
//             // final image = await _controller.takePicture();

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////\
///
/*
import 'package:brainburst/screens/scanning_pages/scanning_index.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final branchProvider = context.watch<BranchProvider>();

    return Container(
      height: 852,
      width: 393,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.39, 0.92),
          end: Alignment(-0.39, -0.92),
          colors: [Color(0xFFF7D5E5), Color(0x00FA99C8)],
        ),
      ),
      child: const Column(children: [
        ScanningPageLogo(),
        // Container(
        //   height: 400,
        //   width: 320,
        //   color: Colors.grey,
        // )
        // CameraWidget(),
      ]),
    );
  }
}

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController _controller;

  Future<void> cameraFun() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    // final firstCamera = cameras.first;
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccess denied':
            print('Camera access denied');
            break;
          default:
            print('Camera error: $e');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 400,
      child: CameraPreview(_controller),
    );
  }
}



// class CameraWidget extends StatefulWidget {
//   @override
//   _CameraWidgetState createState() => _CameraWidgetState();
// }

// class _CameraWidgetState extends State<CameraWidget> {
//   CameraController? controller;

//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }

//   Future<void> initCamera() async {
//     final cameras = await availableCameras();
//     if (cameras.isNotEmpty) {
//       controller = CameraController(cameras[0], ResolutionPreset.medium);
//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (controller == null || !controller!.value.isInitialized) {
//       return Container(
//         width: 320,
//         height: 400,
//         color: Colors.grey,
//       );
//     } else {
//       return SizedBox(
//         width: 320,
//         height: 400,
//         child: CameraPreview(controller!),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
*/


/*import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
   XFile? _image;

  Future getImage(bool isCamera) async {
XFile? image; 
if (isCamera) {
image = (await ImagePicker.pickImage(source: ImageSource.camera)) ;
} else {

  image = (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;
}
setState(() {
_image = image;
});
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        children: [
          Row(
            children: [
              Icon(Icons.upload),
              Icon(Icons.camera_alt),
            ],
          ),
          _image == null
              ? Text('No image selected.')
              : Image.file(_image,height: 300,width: 200,),     
        ],
      ),
    );
  }
}

*/ 