// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/controllers/homeModuleController.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';

import '../data/models/taskModel.dart';
import '../widgets/customBackButton.dart';
import '../widgets/todoCard.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final HomeModuleController homeModuleController = Get.find();
  final AuthenticationModuleController authenticationModuleController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: getBoldTextStyle),
        leading: CustomBackButton(),
        backgroundColor: Get.theme.colorScheme.secondary,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getSearchBar(context),
          Expanded(
            child: Obx(
              () {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: homeModuleController.showSearchResults.value
                      ? getSearchResults()
                      : const SizedBox.shrink(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Column getSearchResults() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Text(
          "Search Results",
          style: getBoldTextStyle.copyWith(
            color: Get.isDarkMode ? whiteColor : Get.theme.colorScheme.primary,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(authenticationModuleController.userModel.userId)
                    .collection('tasks')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      TaskModel taskModel =
                          TaskModel.fromSnap(snapshot.data!.docs[index]);
                      return taskModel.title.toLowerCase().contains(
                                homeModuleController.searchTEC.value.text
                                    .toLowerCase(),
                              )
                          ? ToDoCard(
                              task: taskModel,
                            )
                          : const SizedBox.shrink();
                    },
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Container getSearchBar(BuildContext context) {
    return Container(
      color: Get.theme.colorScheme.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: getDefaultTextStyle,
                  cursorColor: whiteColor,
                  controller: homeModuleController.searchTEC,
                  maxLines: 1,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "Enter a query...",
                    hintStyle: getSubtitleTextStyle,
                    border: OutlineInputBorder(
                      borderSide: Divider.createBorderSide(
                        context,
                        color: whiteColor,
                        width: .5,
                      ),
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: Divider.createBorderSide(
                        context,
                        color: whiteColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: Divider.createBorderSide(
                        context,
                        color: whiteColor,
                        width: .5,
                      ),
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                    ),
                    fillColor: whiteColor.withOpacity(.1),
                    filled: true,
                    contentPadding: const EdgeInsets.all(
                      10,
                    ),
                  ),
                  onTap: () {
                    homeModuleController.showSearchResults.value = false;
                  },
                  onSubmitted: (value) {
                    homeModuleController.showSearchResults.value = true;
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: homeModuleController.clearScreenInSearchPage,
                child: const SizedBox(
                  height: 50,
                  width: 30,
                  child: Icon(
                    Icons.close,
                    color: whiteColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (homeModuleController.searchTEC.value.text.isNotEmpty) {
                    homeModuleController.showSearchResults.value = true;
                  }
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: whiteColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
