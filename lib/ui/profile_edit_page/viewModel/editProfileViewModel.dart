import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_blog/ui/profile_edit_page/view/editProfile.dart';

abstract class EditProfileViewModel extends State<EditProfile> {
  bool isEditingData = false;
  bool buttonIsVisible = true;
  bool isImagePicking = false;
  List<TextEditingController> textEditingController;
  List<String> textFieldsDefaultValues;
  String dateTime;
  Gender selectedGender;

  File pickedImage;
  final picker = ImagePicker();

  void saveGender(Gender gender) {
    this.selectedGender = gender;
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        isImagePicking = true;
        pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    textEditingController = List();
    textFieldsDefaultValues = ['Name', 'Email', 'Jobs', 'Date of Birth'];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.forEach((element) {
      element.dispose();
    });
  }

  void editProfileState() {
    setState(() {
      isEditingData = true;
      buttonIsVisible = false;
    });
  }

  void savedProfileState() {
    setState(() {
      isEditingData = false;
      buttonIsVisible = true;
      //post işlemleri olacak
    });
  }

  void nonSavedProfileState() {
    setState(() {
      isEditingData = false;
      buttonIsVisible = true;
    });
  }

  void getDateTime() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime(2019, 9, 15), onConfirm: (date) {
      setState(() {
        dateTime = '${date.year}/${date.month}/${date.day}';
        textFieldsDefaultValues[4] = dateTime;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}
