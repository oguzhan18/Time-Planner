// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/controllers/homeModuleController.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';
import 'package:time_planner/app/services/postFunctions.dart';
import 'package:time_planner/app/data/models/taskModel.dart';
import '../widgets/customBackButton.dart';
import '../widgets/customCircularProgressLoadingIndicator.dart';

class ShowTaskDetailsScreen extends StatelessWidget {
  final TaskModel task;
  ShowTaskDetailsScreen({Key? key, required this.task}) : super(key: key);

  final AuthenticationModuleController authenticationModuleController =
      Get.find();

  final HomeModuleController homeModuleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task details",
          style: getBoldTextStyle.copyWith(
            color: Get.theme.colorScheme.primary,
          ),
        ),
        leading: CustomBackButton(),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              homeModuleController.deleteTodoTask(task.id);
            },
            icon: const Icon(
              Icons.delete_outline,
              color: errorColor,
              size: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Get.theme.colorScheme.primary,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(authenticationModuleController.userModel.userId)
            .collection('tasks')
            .where(
              'id',
              isEqualTo: task.id,
            )
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomCircularProgressLoadingIndicator();
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              TaskModel taskModel =
                  TaskModel.fromSnap(snapshot.data!.docs[index]);
              return SizedBox(
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: getBoldTextStyle.copyWith(
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          taskModel.title,
                          style: getDefaultTextStyle.copyWith(
                            color: Get.isDarkMode ? whiteColor : blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Description',
                          style: getBoldTextStyle.copyWith(
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          taskModel.description,
                          style: getDefaultTextStyle.copyWith(
                            color: Get.isDarkMode ? whiteColor : blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Event date',
                          style: getBoldTextStyle.copyWith(
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          DateFormat.MMMEd().format(taskModel.eventDate),
                          style: getDefaultTextStyle.copyWith(
                            color: Get.isDarkMode
                                ? whiteColor.withOpacity(.6)
                                : blackColor.withOpacity(.6),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Status',
                          style: getBoldTextStyle.copyWith(
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            PostingFunctions()
                                .changeTaskStatus("Active", taskModel.id);
                          },
                          child: Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Get.theme.colorScheme.secondary,
                                width: 2,
                              ),
                              color: taskModel.status == "Active"
                                  ? Get.theme.colorScheme.secondary
                                  : Get.theme.scaffoldBackgroundColor,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Active',
                              style: getBoldTextStyle.copyWith(
                                color: taskModel.status == "Active"
                                    ? Get.theme.scaffoldBackgroundColor
                                    : Get.theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            PostingFunctions()
                                .changeTaskStatus("Pending", taskModel.id);
                          },
                          child: Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Get.theme.colorScheme.secondary,
                                width: 2,
                              ),
                              color: taskModel.status == "Pending"
                                  ? Get.theme.colorScheme.secondary
                                  : Get.theme.scaffoldBackgroundColor,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Pending',
                              style: getBoldTextStyle.copyWith(
                                color: taskModel.status == "Pending"
                                    ? Get.theme.scaffoldBackgroundColor
                                    : Get.theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            PostingFunctions()
                                .changeTaskStatus("Completed", taskModel.id);
                          },
                          child: Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Get.theme.colorScheme.secondary,
                                width: 2,
                              ),
                              color: taskModel.status == "Completed"
                                  ? Get.theme.colorScheme.secondary
                                  : Get.theme.scaffoldBackgroundColor,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Completed',
                              style: getBoldTextStyle.copyWith(
                                color: taskModel.status == "Completed"
                                    ? Get.theme.scaffoldBackgroundColor
                                    : Get.theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
