import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTicketsScreen extends StatefulWidget {
  const UserTicketsScreen({super.key});

  @override
  State<UserTicketsScreen> createState() => _UserTicketsScreenState();
}

class _UserTicketsScreenState extends State<UserTicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.white,
                )),
            title: CustomText(
              text: "Your Tickets",
              color: Colors.white,
              size: 22,
            ),
            centerTitle: true,
            backgroundColor: bgColor,
            bottom: TabBar(
                labelColor: selectedNav,
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                dividerHeight: 0,
                indicatorColor: selectedNav,
                unselectedLabelColor: unSelectednav,
                unselectedLabelStyle: TextStyle(fontSize: 16),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 1,
                tabs: [
                  Tab(
                    text: "Upcoming",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                ]),
          ),
          body: TabBarView(children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: bgColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // CarouselItem(
                    //   contHeight: 265,
                    // ),
                  ],
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: bgColor,
              child: Column(
                children: <Widget>[
                  // EventContainer(),
                ],
              ),
            ),
          ])),
    );
  }
}
