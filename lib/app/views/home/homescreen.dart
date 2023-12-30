import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/widgets/customCircularProgressLoadingIndicator.dart';
import 'package:time_planner/app/controllers/homeModuleController.dart';
import 'package:time_planner/app/views/home/completedPage.dart';
import 'package:time_planner/app/views/home/dashboardPage.dart';

import '../../widgets/customTextField.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final HomeModuleController controller = Get.find();

  @override
  void dispose() {
    Get.delete<HomeModuleController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Get.theme.colorScheme.primary,
          elevation: 0,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            controller.currentPageIndexOnMainframe.value = value;
          },
          controller: controller.mainframePageController,
          children: [
            DashboardPage(),
            CompletedPage(),
          ],
        ),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddATaskDialogPopUp(context);
        },
        backgroundColor: Get.theme.colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Obx getBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Get.theme.colorScheme.primary,
        unselectedItemColor: greyColor,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 6,
        currentIndex: controller.currentPageIndexOnMainframe.value,
        onTap: (value) {
          controller.currentPageIndexOnMainframe.value = value;
          controller.mainframePageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 400),
            curve: Curves.linearToEaseOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.checklist,
              color: controller.currentPageIndexOnMainframe.value == 0
                  ? Get.theme.colorScheme.primary
                  : greyColor,
            ),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: controller.currentPageIndexOnMainframe.value == 1
                  ? Get.theme.colorScheme.primary
                  : greyColor,
            ),
            label: "Completed",
          ),
        ],
      );
    });
  }

  void showAddATaskDialogPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Adding a Task",
          style: getBoldTextStyle.copyWith(
            color: Get.theme.colorScheme.primary,
            fontSize: 20,
          ),
        ),
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        content: SizedBox(
          width: Get.width,
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
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                TEC: controller.addATaskTitleTEC,
                hint: "Enter a title",
                textInputType: TextInputType.text,
                maxLines: 1,
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
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                TEC: controller.addATaskDescriptionTEC,
                hint: "Enter a description",
                textInputType: TextInputType.text,
                maxLines: 5,
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
              Obx(() {
                return controller.showSelectedDate.value
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat.MMMEd()
                                    .format(controller.selectedEventDate.value),
                                style: getDefaultTextStyle.copyWith(
                                  color: Get.isDarkMode
                                      ? whiteColor.withOpacity(.6)
                                      : blackColor.withOpacity(.6),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.showSelectedDate.value = false;
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Get.theme.colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.selectedEventDate.value =
                                      DateTime.now();
                                  controller.showSelectedDate.value = true;
                                },
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Get.theme.colorScheme.primary,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Today",
                                    style: getBoldTextStyle,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.selectDate(context);
                                },
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Get.theme.colorScheme.primary,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Schedule",
                                    style: getBoldTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
              }),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 40,
              width: 80,
              alignment: Alignment.center,
              child: Text(
                'Cancel  ',
                style: getBoldTextStyle.copyWith(
                  color: errorColor,
                ),
              ),
            ),
          ),
          Obx(() {
            return GestureDetector(
              onTap: controller.saveATask,
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Get.theme.colorScheme.secondary,
                ),
                alignment: Alignment.center,
                child: controller.showLoadingAnimationInAddATaskPopup.value
                    ? const CustomCircularProgressLoadingIndicator()
                    : Text(
                        'Save',
                        style: getBoldTextStyle,
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
