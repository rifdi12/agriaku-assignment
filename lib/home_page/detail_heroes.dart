import 'package:agriaku_assignment/controller/home_controller.dart';
import 'package:agriaku_assignment/model/heroes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailHeroes extends StatelessWidget {
  const DetailHeroes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HeroesModel arg = Get.arguments;
    HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(arg.localizedName!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.bottomLeft,
              height: 200,
              width: Get.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://api.opendota.com${arg.img!}'),
                    fit: BoxFit.fill),
              ),
              child: Wrap(
                children: [
                  for (var i = 0; i < arg.roles!.length; i++)
                    Text(
                      '${i + 1 == arg.roles!.length ? arg.roles![i] : arg.roles![i] + ', '}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Type',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        arg.attackType!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Max Atk',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${arg.baseAttackMin!} - ${arg.baseAttackMax!}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Health',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${arg.baseHealth!}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'MSPD',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${arg.moveSpeed!}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Attr',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${arg.primaryAttr!}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Similiar Heroes',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            homeController.similiarHeroes(arg)
          ],
        ),
      ),
    );
  }
}
