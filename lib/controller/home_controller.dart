import 'dart:ui';

import 'package:agriaku_assignment/home_page/detail_heroes.dart';
import 'package:agriaku_assignment/model/heroes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class HomeController extends GetxController {
  final listHero = <HeroesModel>[].obs;
  final listRoles = [].obs;
  final rolesSelected = <String>[].obs;
  final loading = false.obs;
  final error = false.obs;

  @override
  void onInit() {
    getInitData();
    super.onInit();
  }

  Widget filterData() {
    List<HeroesModel> heroesFrom = List.from(listHero);
    List<HeroesModel> data =
        rolesSelected.length == 0 ? List.from(listHero) : [];
    for (var heroesItem in heroesFrom) {
      for (var rolesSelectedItem in rolesSelected) {
        if (heroesItem.roles!.contains(rolesSelectedItem)) {
          data.add(heroesItem);
        }
      }
    }
    data = data.toSet().toList();
    return Expanded(
      child: GridView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 90 / 120,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => DetailHeroes(), arguments: data[index]);
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.black54),
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://api.opendota.com${data[index].img!}',
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Container(
                        alignment: Alignment.center,
                        height: 90,
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.white,
                        ),
                      );
                    },
                    height: 90,
                    width: Get.width,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data[index].localizedName}',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Wrap(
                          children: [
                            for (var i = 0; i < data[index].roles!.length; i++)
                              Text(
                                '${i + 1 == data[index].roles!.length ? data[index].roles![i] : data[index].roles![i] + ', '}',
                                style: TextStyle(color: Colors.grey),
                              )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: data[index].primaryAttr == 'agi'
                                      ? Colors.green
                                      : data[index].primaryAttr == 'str'
                                          ? Colors.red
                                          : Colors.blue),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              data[index].primaryAttr!.toUpperCase(),
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void getInitData() async {
    loading.value = true;
    update();
    try {
      Response apiCall =
          await Dio().get('https://api.opendota.com/api/herostats');
      for (var item in apiCall.data) {
        listRoles.addAll(item['roles']);
        HeroesModel data = HeroesModel.fromJson(item);
        listHero.add(data);
      }
      listRoles.assignAll(listRoles.toSet().toList());
      error.value = false;
    } catch (e) {
      error.value = true;
    }

    loading.value = false;
    update();
  }

  Widget similiarHeroes(HeroesModel heroes) {
    List<HeroesModel> heroesModel = List.from(listHero);
    if (heroes.primaryAttr == 'agi') {
      heroesModel.removeWhere((element) => element.primaryAttr != 'agi');
      heroesModel.removeWhere((element) => element.name == heroes.name);
      heroesModel.sort((b, a) => a.moveSpeed!.compareTo(b.moveSpeed!));
    }
    if (heroes.primaryAttr == 'str') {
      heroesModel.removeWhere((element) => element.primaryAttr != 'str');
      heroesModel.removeWhere((element) => element.name == heroes.name);
      heroesModel.sort((b, a) => a.baseAttackMax!.compareTo(b.baseAttackMax!));
    }
    if (heroes.primaryAttr == 'int') {
      heroesModel.removeWhere((element) => element.primaryAttr != 'int');
      heroesModel.removeWhere((element) => element.name == heroes.name);
      heroesModel.sort((b, a) => a.baseMana!.compareTo(b.baseMana!));
    }
    return Column(
      children: [
        for (var item in heroesModel.take(3))
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(15),
            height: 100,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black38,
                    BlendMode.hardLight,
                  ),
                  image: NetworkImage('https://api.opendota.com${item.img!}'),
                  fit: BoxFit.cover),
            ),
            child: Text(
              item.localizedName!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
      ],
    );
  }
}
