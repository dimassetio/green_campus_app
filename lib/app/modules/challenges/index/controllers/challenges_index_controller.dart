import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/activity_model.dart';
import 'package:green_campus_app/app/data/models/challenge_model.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class ChallengesIndexController extends GetxController {
  //TODO: Implement ChallengesIndexController
  RxList<ChallengeModel> openChallenges = RxList();

  Stream<List<ChallengeModel>> streamChallenges() {
    return ChallengeModel()
        .collectionReference
        .where(ChallengeModel.IS_ACTIVE, isEqualTo: true)
        .orderBy(ChallengeModel.DATE_CREATED, descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ChallengeModel.fromSnapshot(e)).toList());
  }

  RxList<ActivityModel> recentActivities = RxList();

  var _limitActivity = 5.obs;
  int get limitActivity => this._limitActivity.value;
  set limitActivity(int value) => this._limitActivity.value = value;

  Stream<List<ActivityModel>> streamActivities() {
    return ActivityModel(userId: authC.user.id!)
        .collectionReference
        .orderBy(ActivityModel.TIME, descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ActivityModel.fromSnapshot(e)).toList());
  }

  List<DateTime> get getLast7Days =>
      List.generate(7, (index) => DateTime.now().add(Duration(days: -index)))
          .reversed
          .toList();

  List<BarChartGroupData> get getBarData => List.generate(
        7,
        (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: recentActivities
                  .where(
                      (element) => isSameDay(element.time, getLast7Days[index]))
                  .length
                  .toDouble(),
              color: primaryColor(Get.context),
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );

  double getMaxToYValue() {
    List<BarChartGroupData> barData = getBarData;
    double maxToY = barData
        .map((data) => data.barRods.first.toY)
        .reduce((value, element) => element > value ? element : value);
    return maxToY * 1;
  }

  List<ActivityModel> get weeklyActivities => recentActivities
      .where(
        (element) =>
            element.time
                ?.isAfter(DateTime.now().add(const Duration(days: -6))) ??
            false,
      )
      .toList();

  int get weeklyCompletedChallenge => weeklyActivities.length;
  int get weeklyEarning => weeklyActivities.sumBy((p0) => p0.rewards ?? 0);

  @override
  void onInit() {
    super.onInit();
    openChallenges.bindStream(streamChallenges());
    recentActivities.bindStream(streamActivities());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
