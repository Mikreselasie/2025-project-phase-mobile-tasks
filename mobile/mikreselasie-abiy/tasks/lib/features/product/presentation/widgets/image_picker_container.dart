import 'dart:io'; // For File
import 'package:ecommerce/features/product/presentation/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerContainer extends StatefulWidget {
  // Add onImagePicked as a required parameter
  final Function(String) onImagePicked;

  const ImagePickerContainer({super.key, required this.onImagePicked});

  @override
  _ImagePickerContainerState createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // Call the onImagePicked callback and pass the file path
      widget.onImagePicked(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage, // Open image picker on tap
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.borderPrimary,
          borderRadius: BorderRadius.circular(10),
          image: _imageFile != null
              ? DecorationImage(
                  image: FileImage(_imageFile!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _imageFile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.image_outlined, size: 50),
                  Center(
                    child: Text(
                      'Upload image',
                      style: AppTextStyles.addProductText,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
