// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/services/postFunctions.dart';

import '../widgets/snackbar.dart';

class HomeModuleController {
  var currentPageIndexOnMainframe = 0.obs;
  PageController mainframePageController = PageController(initialPage: 0);
  TextEditingController addATaskTitleTEC = TextEditingController();
  TextEditingController addATaskDescriptionTEC = TextEditingController();
  TextEditingController searchTEC = TextEditingController();
  var selectedEventDate = DateTime.now().obs;
  var showSelectedDate = false.obs;
  var showLoadingAnimationInAddATaskPopup = false.obs;
  var showSearchResults = false.obs;

  selectDate(BuildContext context) async {
    var eventDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1998),
      lastDate: DateTime(2100),
    );
    if (eventDate != null) {
      selectedEventDate.value = eventDate;
      showSelectedDate.value = true;
    }
  }

  saveATask() async {
    String title = addATaskTitleTEC.value.text;
    String description = addATaskDescriptionTEC.value.text;
    String status = "Pending";
    if (title.isNotEmpty &&
        description.isNotEmpty &&
        showSelectedDate.value == true) {
      showLoadingAnimationInAddATaskPopup.value = true;
      await Future.delayed(const Duration(seconds: 2));
      String postedSuccessfully = await PostingFunctions().addATask(
        title: title,
        description: description,
        eventDate: selectedEventDate.value,
        status: "Pending",
      );
      showLoadingAnimationInAddATaskPopup.value = false;
      if (postedSuccessfully == "Success") {
        addATaskTitleTEC.text = "";
        addATaskDescriptionTEC.text = "";
        showSelectedDate.value = false;
        Get.back();
        showCustomSnackBar(
          title: "Success! :D",
          message: "Your task has been added to your time_planner list.",
        );
      } else {
        showLoadingAnimationInAddATaskPopup.value = false;
        showCustomSnackBar(
          title: "Error",
          message:
              "An error occurred while trying to save our task to your time_planner list.",
        );
      }
    } else {
      showCustomSnackBar(
        title: "Error",
        message: "Input fields cannot be empty! :(",
      );
    }
  }

  void deleteTodoTask(String id) async {
    await PostingFunctions().deleteTodoTask(id);
    Get.back();
    showCustomSnackBar(
      title: "Task deleted",
      message: "Your task has been deleted from time_planner.",
    );
  }

  void clearScreenInSearchPage() {
    showSearchResults.value = false;
    searchTEC.text = '';
  }

  void deleteUserData() async {
    await PostingFunctions().deleteUserData();
    showCustomSnackBar(
        title: "Success",
        message: "Done! You're relived of all of your todos. :)");
  }
}
