// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';

import '../../data/models/taskModel.dart';
import '../../data/theme/theme.dart';
import '../../widgets/customCircularProgressLoadingIndicator.dart';
import '../../widgets/todoCard.dart';

class CompletedPage extends StatelessWidget {
  CompletedPage({Key? key}) : super(key: key);

  final AuthenticationModuleController authenticationModuleController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
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
                      'Completed Tasks',
                      style: getBoldTextStyle.copyWith(
                        color: Get.isDarkMode ? getPrimaryColor : darkBlueColor,
                      ),
                    ),
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
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
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
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
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
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
