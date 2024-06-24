import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/bike_model.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:nb_utils/nb_utils.dart';

class BikeStationCard extends StatelessWidget {
  const BikeStationCard({
    super.key,
    required this.facility,
    this.height,
    this.width,
    this.onTap,
  });

  final double? height;
  final double? width;
  final FacilityModel facility;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GCFormFoto(
                height: 60,
                width: 60,
                defaultPath: img_challenge_bike,
                oldPath: facility.foto ?? '',
                showButton: false,
              ),
              16.width,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(facility.name, style: textTheme(context).titleSmall),
                    Text(
                      facility.description,
                      maxLines: 2,
                      style: textTheme(context)
                          .labelMedium
                          ?.copyWith(color: secondTextColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.height,
                    StreamBuilder(
                      stream: BikeModel.streamCountAtStation(facility.id),
                      builder: (context, snapshot) {
                        if (ConnectionState.waiting ==
                            snapshot.connectionState) {
                          return LinearProgressIndicator();
                        }
                        if (snapshot.data is int) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleContainer(
                                alignment: Alignment.centerRight,
                                color: primaryColor(context),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.pedal_bike_outlined,
                                      size: 18,
                                      color:
                                          theme(context).colorScheme.onPrimary,
                                    ),
                                    16.width,
                                    Text(
                                      "${decimalFormatter(snapshot.data ?? 0)} ${'bikeAvailable'.tr}",
                                      style: textTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                              color: theme(context)
                                                  .colorScheme
                                                  .onPrimary),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
