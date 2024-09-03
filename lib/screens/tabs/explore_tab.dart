import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/carousel_item.dart';
import 'package:eventure/widgets/custom_inputField.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    filled: true,
                    fillColor: inpBg,
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    suffixIcon: SvgPicture.asset(
                            "assets/icons/search.svg",
                            fit: BoxFit.none,
                          ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: inpBg),
                      borderRadius: BorderRadius.circular(8)
                    ), 
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: inpBg
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ) 
                  ), 
                ),
              ),
        
              SizedBox(height: 24,),
        
              //Categories
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(text: "Categories", color: Colors.white, ),
                  SizedBox(height: 24,),
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
            ],
          ),
        ),
      ),
    );
  }
}