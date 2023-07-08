// import 'dart:async';
// import 'dart:io';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';

// Future<bool> compareImages(File image1, File image2) async {
// // Create a face detector.
// final faceDetector = FirebaseVision.instance.faceDetector();

// // Load the images into Firebase VisionImage objects.
// final image1Vision = FirebaseVisionImage.fromFile(image1);
// final image2Vision = FirebaseVisionImage.fromFile(image2);

// // Detect faces in the images.
// final faces1 = await faceDetector.processImage(image1Vision);
// final faces2 = await faceDetector.processImage(image2Vision);

// // If there are no faces in either image, return false.
// if (faces1.isEmpty || faces2.isEmpty) {
// return false;
// }

// // Compare the faces in the images.
// final face1 = faces1.first;
// final face2 = faces2.first;

// // Compute the distance between the faces.
// final distance = face1.boundingBox.distanceTo(face2.boundingBox);

// // Return true if the distance is below a certain threshold.
// return distance < 0.5;
// }

// double distanceTo(BoundingBox other) {
// // Calculate the distance between the centers of the bounding boxes.
// final dx = center.dx - other.center.dx;
// final dy = center.dy - other.center.dy;

// // Calculate the distance between the corners of the bounding boxes.
// final maxX = math.max(left, other.left);
// final minX = math.min(right, other.right);
// final maxY = math.max(top, other.top);
// final minY = math.min(bottom, other.bottom);

// // Return the distance between the centers of the bounding boxes, or the distance between the corners of the bounding boxes, whichever is greater.
// return math.max(dx * dx + dy * dy, (maxX - minX) * (maxX - minX) + (maxY - minY) * (maxY - minY));
// }