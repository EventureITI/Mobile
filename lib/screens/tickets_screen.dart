import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/carousel_item.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:eventure/widgets/event_container.dart';
import 'package:flutter/material.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: Icon(Icons.arrow_back_sharp, color: Colors.white,)
          ),
          title: CustomText(text: "Your Tickets", color: Colors.white,size: 22,),
          centerTitle: true,
          backgroundColor: bgColor,
          bottom: TabBar(
            labelColor: selectedNav,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
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
            ]
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CarouselItem(
                    contHeight: 265,
                    pic: "assets/images/kinglear.jfif",
                    eventCategory: "Drama",
                    eventPrice: "450",
                    title: "King Lear",
                    eventActors: "Yehia El Fakharany",
                    eventDate: "Sep 11",
                    eventTime: "09:00 PM",
                  ),
                  SizedBox(height: 8,),
                  CarouselItem(
                    contHeight: 265,
                    pic: "assets/images/event1.jfif",
                    eventCategory: "Comedy",
                    eventPrice: "600",
                    title: "Ain Gamal",
                    eventActors: "Omar El Gamal • Ahmed Amin",
                    eventDate: "Sep 14",
                    eventTime: "10:00 PM",
                  ),
                  
                ],
              )
            ),
            
      
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: bgColor,
              child: Column(
                children: <Widget>[
                  EventContainer(),
                  EventContainer(),
                  EventContainer(),
                  EventContainer(),
                  
                ],
              ),
            ),
          ]
        )
      ),
    );
  }
}