import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';

class GCBottomBar extends StatelessWidget {
  GCBottomBar({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  final List<List> itemList = [
    [
      svg_ic_home,
      svg_ic_home_a,
      Routes.HOME,
    ],
    [
      svg_ic_challenge,
      svg_ic_challenge_a,
      Routes.CHALLENGES_INDEX,
    ],
    [
      svg_ic_map,
      svg_ic_map_a,
      Routes.FACILITIES_MAP,
    ],
    [
      svg_ic_bike,
      svg_ic_bike_a,
      Routes.BIKE,
    ],
    [
      svg_ic_profile,
      svg_ic_profile_a,
      Routes.PROFILE,
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      color: theme(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            itemList.length,
            (index) => Container(
              decoration: selectedIndex == index
                  ? BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(24))
                  : null,
              child: IconButton(
                iconSize: 28,
                onPressed: selectedIndex == index
                    ? null
                    : () {
                        Get.toNamed(itemList[index][2]);
                      },
                icon: SvgPicture.asset(
                  selectedIndex == index
                      ? itemList[index][1]
                      : itemList[index][0],
                  height: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
