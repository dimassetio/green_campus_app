import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:nb_utils/nb_utils.dart';

class GCTile extends StatelessWidget {
  const GCTile({
    super.key,
    required this.label,
    required this.value,
    this.leading,
    this.trailing,
    this.verticalAlignment = CrossAxisAlignment.center,
    this.horizontalAlignment = MainAxisAlignment.start,
  });
  final String label;
  final String value;
  final Widget? leading;
  final Widget? trailing;
  final CrossAxisAlignment verticalAlignment;
  final MainAxisAlignment horizontalAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: horizontalAlignment,
        crossAxisAlignment: verticalAlignment,
        children: [
          if (leading is Widget) leading!.marginOnly(right: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme(context)
                      .labelMedium
                      ?.copyWith(color: secondTextColor),
                ),
                2.height,
                Text(
                  value,
                  style: textTheme(context).bodyMedium,
                ),
              ],
            ),
          ),
          if (trailing is Widget) trailing!.marginOnly(left: 12),
        ],
      ),
    );
  }
}
