import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:nb_utils/nb_utils.dart';

class GCErrorWidget extends StatelessWidget {
  const GCErrorWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width,
        ),
        SvgPicture.asset(svg_confirmation),
        16.height,
        Text(message),
        16.height,
        SizedBox(
          width: 120,
          child: GCButton(
              icon: Icon(Icons.chevron_left_rounded),
              title: 'back',
              onPressed: () {
                Get.back();
              }),
        ),
      ],
    );
  }
}
