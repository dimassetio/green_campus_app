import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/tile.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/challenges_index_controller.dart';

class ChallengeChart extends GetView<ChallengesIndexController> {
  const ChallengeChart({
    super.key,
  });

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      fontSize: 14,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(dateChartFormatter(controller.getLast7Days[value.toInt()]),
          style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  @override
  Widget build(BuildContext context) {
    return GCCardColumn(
      children: [
        Text(
          'weeklyAchievement'.tr,
          style: textTheme(context).titleMedium,
        ),
        4.height,
        Obx(
          () => Row(
            children: [
              Expanded(
                child: GCTile(
                    leading: Text(
                      decimalFormatter(controller.weeklyCompletedChallenge),
                      style: textTheme(context).titleLarge?.copyWith(
                          color: primaryColor(context),
                          fontWeight: FontWeight.w600),
                    ),
                    label: 'greenChallenges'.tr,
                    value: 'completed'.tr),
              ),
              // Container(
              //   height: 32,
              //   width: 2,
              //   color: primaryColor(context),
              // ),
              Expanded(
                child: GCTile(
                    horizontalAlignment: MainAxisAlignment.end,
                    leading: SvgPicture.asset(
                      svg_gp,
                      width: 24,
                    ),
                    label: 'earningGP'.tr,
                    value:
                        "${decimalFormatter(controller.weeklyEarning)} ${'gp'.tr}"),
              ),
            ],
          ),
        ),
        28.height,
        AspectRatio(
          aspectRatio: 2,
          child: Obx(
            () => BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: 0,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.toY.round().toString(),
                        TextStyle(
                          color: primaryColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),

                titlesData: titlesData,
                borderData: borderData,
                maxY: controller.getMaxToYValue(),
                gridData: FlGridData(show: false),
                barGroups: controller.getBarData,
                // barGroups: [
                //   BarChartGroupData(
                //     x: 0,
                //     barRods: [
                //       BarChartRodData(
                //         toY: 8,
                //         color: primaryColor(context),
                //       )
                //     ],
                //     showingTooltipIndicators: [0],
                //   ),
                //   BarChartGroupData(
                //     x: 1,
                //     barRods: [
                //       BarChartRodData(
                //         toY: 10,
                //         color: primaryColor(context),
                //       )
                //     ],
                //     showingTooltipIndicators: [0],
                //   ),
                //   BarChartGroupData(
                //     x: 2,
                //     barRods: [
                //       BarChartRodData(
                //         toY: 14,
                //         color: primaryColor(context),
                //       )
                //     ],
                //     showingTooltipIndicators: [0],
                //   ),
                //   BarChartGroupData(
                //     x: 3,
                //     barRods: [
                //       BarChartRodData(
                //         toY: 15,
                //         color: primaryColor(context),
                //       )
                //     ],
                //     showingTooltipIndicators: [0],
                //   ),
                //   BarChartGroupData(
                //     x: 4,
                //     barRods: [
                //       BarChartRodData(
                //         toY: 13,
                //         color: primaryColor(context),
                //       )
                //     ],
                //     showingTooltipIndicators: [0],
                //   ),
                //   BarChartGroupData(
                //     x: 5,
                //     barRods: [
                //       BarChartRodData(
                //         toY: 10,
                //         color: primaryColor(context),
                //       )
                //     ],
                //     showingTooltipIndicators: [0],
                //   ),
                //   BarChartGroupData(
                //     x: 6,
                //     barRods: [
                //       BarChartRodData(
                //         toY: 16,
                //         color: primaryColor(context),
                //       )
                //     ],
                //     showingTooltipIndicators: [0],
                //   ),
                // ],
              ),
            ),
          ),
        ),
        4.height,
      ],
    );
  }
}
