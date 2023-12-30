// ignore_for_file: must_be_immutable, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/app/widgets/customCircularProgressLoadingIndicator.dart';
import 'package:time_planner/app/views/profileScreen.dart';
import 'package:time_planner/app/views/searchScreen.dart';
import 'package:time_planner/app/widgets/todoCard.dart';
import 'package:time_planner/app/data/models/taskModel.dart';

import '../../data/theme/theme.dart';
import '../../controllers/authenticationModuleController.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);
  final AuthenticationModuleController authenticationModuleController =
      Get.find();

  Color getPrimaryColor = Get.theme.colorScheme.primary;
  Color getSecondaryColor = Get.theme.colorScheme.secondary;
  Color getScaffoldColor = Get.theme.scaffoldBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomAppBar(),
              const SizedBox(
                height: 10,
              ),
              getActiveTodoList(),
              getPendingToDoList(),
              getCompletedToDoList(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding getPendingToDoList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Pending To-Dos',
                    style: getBoldTextStyle.copyWith(
                      color: Get.isDarkMode ? getPrimaryColor : darkBlueColor,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: greyColor,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.add,
                      color: greyColor,
                      size: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(authenticationModuleController.userModel.userId)
                .collection('tasks')
                .where('status', isEqualTo: "Pending")
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomCircularProgressLoadingIndicator();
              }
              if (snapshot.data!.docs.isEmpty) {
                return Text(
                  'You have no pending tasks, as of right now!',
                  style: getDefaultTextStyle.copyWith(
                    color: greyColor,
                    fontSize: 12,
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  TaskModel taskModel =
                      TaskModel.fromSnap(snapshot.data!.docs[index]);
                  return ToDoCard(
                    task: taskModel,
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Padding getCompletedToDoList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Completed',
                    style: getBoldTextStyle.copyWith(
                      color: Get.isDarkMode ? getPrimaryColor : darkBlueColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: greyColor,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.add,
                      color: greyColor,
                      size: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(authenticationModuleController.userModel.userId)
                .collection('tasks')
                .where('status', isEqualTo: "Completed")
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomCircularProgressLoadingIndicator();
              }
              if (snapshot.data!.docs.isEmpty) {
                return Text(
                  'You have not completed any tasks yet!!',
                  style: getDefaultTextStyle.copyWith(
                      color: greyColor, fontSize: 12),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  TaskModel taskModel =
                      TaskModel.fromSnap(snapshot.data!.docs[index]);
                  return ToDoCard(
                    task: taskModel,
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Padding getActiveTodoList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Active',
                    style: getBoldTextStyle.copyWith(
                      color: Get.isDarkMode ? getPrimaryColor : darkBlueColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: greyColor,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.add,
                      color: greyColor,
                      size: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(authenticationModuleController.userModel.userId)
                .collection('tasks')
                .where('status', isEqualTo: "Active")
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomCircularProgressLoadingIndicator();
              }
              if (snapshot.data!.docs.isEmpty) {
                return Text(
                  'No active tasks',
                  style: getDefaultTextStyle.copyWith(
                      color: greyColor, fontSize: 12),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  TaskModel taskModel =
                      TaskModel.fromSnap(snapshot.data!.docs[index]);
                  return ToDoCard(
                    task: taskModel,
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Container getCustomAppBar() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Get.theme.colorScheme.primary,
            Get.theme.colorScheme.secondary,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => ProfileScreen());
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authenticationModuleController.userModel.userName,
                        style: getBoldTextStyle.copyWith(
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        authenticationModuleController.userModel.email,
                        style: getSubtitleTextStyle.copyWith(height: .9),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SearchScreen());
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Get.theme.scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox.shrink(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today, ${DateFormat.MMMEd().format(DateTime.now())}.",
                  style: getSubtitleTextStyle.copyWith(height: .9),
                ),
                Text(
                  "Time Planner Dashboard",
                  style: getBoldTextStyle.copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
