import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:nb_utils/nb_utils.dart';

// class GCAppBar extends StatelessWidget {
//   const GCAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {

//   }
// }

class GCAppBar extends StatelessWidget {
  const GCAppBar({
    super.key,
    required this.label,
    required this.svgIcon,
    this.showNotification = true,
    this.trailingWidget,
    this.onBack,
    this.trailingFunction,
    this.titleWidget,
  });

  final String label;
  final String svgIcon;
  final Widget? titleWidget;
  final void Function()? onBack;
  final void Function()? trailingFunction;
  final bool showNotification;
  final Widget? trailingWidget;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleContainer(
          child: IconButton(
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(double.infinity),
              ),
            ),
            onPressed: onBack ??
                () {
                  Get.back();
                },
            icon: Icon(Icons.chevron_left),
          ),
        ),
        CircleContainer(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svgIcon,
                  height: 28,
                ),
                12.width,
                Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme(context).titleMedium,
                )
              ],
            )),
        trailingWidget ??
            (showNotification
                ? CircleContainer(
                    child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Icon(Icons.notifications_outlined),
                    ),
                  )
                : SizedBox(
                    width: 48,
                  ))
      ],
    );
  }
}
