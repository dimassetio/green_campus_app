import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/bike_model.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:nb_utils/nb_utils.dart';

class BikeCard extends StatelessWidget {
  const BikeCard({
    super.key,
    required this.bike,
    this.onTap,
  });

  final BikeModel bike;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap ??
            () {
              // Get.toNamed(Routes., arguments: bike);
            },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: !bike.foto.isEmptyOrNull
                    ? CachedNetworkImage(
                        imageUrl: bike.foto!,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(svg_logo, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bike.name,
                    style: textTheme(context).titleSmall,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.pedal_bike_outlined,
                        color: primaryColor(context),
                      ),
                      8.width,
                      Expanded(
                        child: Text(
                          bike.type,
                          maxLines: 1,
                          style: textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: secondTextColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleContainer(
                        color: bike.status == BikeStatus.available
                            ? primaryColor(context)
                            : bike.status == BikeStatus.nonactive
                                ? clrSoftRed
                                : secondaryColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                        child: Text(
                          bike.status,
                          style: textTheme(context).labelLarge?.copyWith(
                              color: bike.status != BikeStatus.inUse
                                  ? theme(context).colorScheme.onPrimary
                                  : null),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
