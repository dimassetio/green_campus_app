import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/challenge_model.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:nb_utils/nb_utils.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.showDate,
    this.height,
    this.width,
    this.onTap,
  });

  final ChallengeModel challenge;
  final bool showDate;
  final double? height;
  final double? width;
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
          width: width,
          height: height,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GCFormFoto(
                height: 60,
                width: 60,
                defaultPath: img_green_challenge,
                oldPath: challenge.foto ?? '',
                showButton: false,
              ),
              16.width,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title ?? "",
                      style: textTheme(context)
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      challenge.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.height,
                    Row(
                      children: [
                        SvgPicture.asset(svg_gp, width: 24),
                        Text(
                            "  ${decimalFormatter(challenge.rewards ?? 0)} ${'gp'.tr}")
                      ],
                    ),
                    if (showDate)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          (challenge.isActive ?? false)
                              ? Icon(
                                  Icons.task_alt_rounded,
                                  size: 20,
                                  color: primaryColor(context),
                                )
                              : Icon(
                                  Icons.clear_rounded,
                                  size: 20,
                                  color: theme(context).colorScheme.error,
                                ),
                          8.width,
                          Text(
                              "${dateFormatter(challenge.startDate)} - ${dateFormatter(challenge.endDate)}")
                        ],
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
