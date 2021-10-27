import 'package:agriaku_assignment/controller/home_controller.dart';
import 'package:agriaku_assignment/home_page/detail_heroes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 25,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(
                () => homeController.loading.value
                    ? Container(
                        height: 350,
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: homeController.error.value
                            ? Container(
                                height: Get.height - 200,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning_rounded,
                                      color: Colors.red,
                                      size: 100,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Error',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Error get data, please check your connection',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        homeController.onInit();
                                      },
                                      child: Text('Retry'),
                                    )
                                  ],
                                ),
                              )
                            : Row(
                                children: [
                                  for (var i = 0;
                                      i < homeController.listRoles.length;
                                      i++)
                                    Row(
                                      children: [
                                        ChoiceChip(
                                          backgroundColor:
                                              homeController.rolesSelected
                                                      .where(
                                                        (element) =>
                                                            element ==
                                                            homeController
                                                                .listRoles[i],
                                                      )
                                                      .isNotEmpty
                                                  ? Colors.red
                                                  : Colors.transparent,
                                          label: Text(
                                            homeController.listRoles[i],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onSelected: (v) {
                                            if (homeController.rolesSelected
                                                .where(
                                                  (element) =>
                                                      element ==
                                                      homeController
                                                          .listRoles[i],
                                                )
                                                .isNotEmpty) {
                                              homeController.rolesSelected
                                                  .removeWhere((element) =>
                                                      element ==
                                                      homeController
                                                          .listRoles[i]);
                                            } else {
                                              homeController.rolesSelected.add(
                                                  homeController.listRoles[i]);
                                            }
                                            // homeController.filterData();
                                            homeController.update();
                                          },
                                          shape: StadiumBorder(
                                            side: BorderSide(
                                                color:
                                                    homeController.rolesSelected
                                                            .where(
                                                              (element) =>
                                                                  element ==
                                                                  homeController
                                                                      .listRoles[i],
                                                            )
                                                            .isNotEmpty
                                                        ? Colors.transparent
                                                        : Colors.white,
                                                width: 2),
                                          ),
                                          selected: false,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                      ),
              ),
              Obx(() => homeController.filterData())
            ],
          ),
        ),
      ),
    );
  }
}
