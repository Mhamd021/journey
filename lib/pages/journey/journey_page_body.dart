import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey/controllers/journeycontroller.dart';
import '../../consts/dimensions.dart';

class JourneysPageBody extends StatefulWidget {
  const JourneysPageBody({super.key});
  @override
  State<JourneysPageBody> createState() => _JourneysPageBodyState();
}

var postInfoController = TextEditingController();
TextEditingController commentInfoController = TextEditingController();
class _JourneysPageBodyState extends State<JourneysPageBody> {


  @override
  Widget build(BuildContext context) {
    return  GetBuilder<Journeycontroller>(builder: (controller) {
          return controller.isLoading.value
              ? const CircularProgressIndicator()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.journeys.length,
                  itemBuilder: (context, index) {
                    final journey = controller.journeys[index];
                    return Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.width10 / 1.5),
                      margin: EdgeInsets.only(
                        bottom: Dimensions.width10,
                        left: Dimensions.width10 / 1.2,
                        right: Dimensions.width10 / 1.2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3),
                          ),
                        ],
                      ),
                      child: Column(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              journey.headline,
                              style: TextStyle(
                                  fontSize: Dimensions.font20 / 2 + 5),
                            ),
                            SizedBox(height: Dimensions.width10 / 4),
                             Text(
                              journey.headline,
                              style: TextStyle(
                                  fontSize: Dimensions.font20 / 2 + 5),
                            ),
                           
                          ],
                        ),
                        SizedBox(height: Dimensions.height20),
                       
                      ]),
                    );
                  },
                );
        });
   
  }
}
