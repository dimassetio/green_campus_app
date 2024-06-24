import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:nb_utils/nb_utils.dart';

class NotifDrawer extends StatelessWidget {
  const NotifDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(svg_confirmation),
          8.height,
          Text('emptyNotification'.tr),
        ],
      ),
    );
  }
}
