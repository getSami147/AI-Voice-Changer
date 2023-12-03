import 'dart:ffi';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/colors.dart';
import 'package:voice_maker/utils/constant.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/authView/logIn.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel2.dart';

class LineChartClass extends StatelessWidget {
  Map<String, dynamic> weekendObj;
  var month;
  var istime;
  int? maxVal;
  LineChartClass(
      {super.key, required this.month, required this.weekendObj, required this.istime,this.maxVal});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 6,
        maxY: maxVal.toString().toDouble(),
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // leftTitles: AxisTitles(
        //   sideTitles: leftTitles(),
        // ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

//  Widget leftTitleWidgets(double value, TitleMeta meta) {
//   const style = TextStyle(
//     fontSize: 12,
//   );
//   String text;

//   if (value.toInt() == maxVal! / 1) {
//     text = istime == "Last 7 days"?weekendObj["sun"].toString(): '\$${month["monthCount"][0]["count"].toString()}';
//   } else if (value.toInt() == maxVal! / 2) {
//     text = istime == "Last 7 days"?weekendObj["mon"].toString():'\$${month["monthCount"][5]["count"].toString()}';
//   } else if (value.toInt() == maxVal! / 3) {
//     text =istime == "Last 7 days"?weekendObj["tue"].toString(): '\$${month["monthCount"][10]["count"].toString()}';
//   } else if (value.toInt() == maxVal! / 4) {
//     text = istime == "Last 7 days"?weekendObj["web"].toString():'\$${month["monthCount"][15]["count"].toString()}';
//   } else if (value.toInt() == maxVal! / 5) {
//     text = istime == "Last 7 days"?weekendObj["thur"].toString():'\$${month["monthCount"][20]["count"].toString()}';
//   } else if (value.toInt() == maxVal! / 6) {
//     text = istime == "Last 7 days"?weekendObj["fri"].toString():'\$${month["monthCount"][25]["count"].toString()}';
//   } else if (value.toInt() == maxVal! / 7) {
//     text = istime == "Last 7 days"?weekendObj["sat"].toString():'\$${month["monthCount"][29]["count"].toString()}';
//   } else {
//     return Container();
//   }

//   return Text(text, style: style, textAlign: TextAlign.center);
// }


  // SideTitles leftTitles() => SideTitles(
  //       getTitlesWidget: leftTitleWidgets,
  //       showTitles: true,
  //       interval: 1,
  //       reservedSize: 40,
  //     );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = istime == "Last 7 days"
            ? "Sun"
            : month["monthCount"][1]["date"].toString();
        break;
      case 1:
        text = istime == 'Last 7 days'
            ? 'Mon'
            : month["monthCount"][5]["date"].toString();
        break;
      case 2:
        text = istime == 'Last 7 days'
            ? 'Tue'
            : month["monthCount"][10]["date"].toString();
        break;
      case 3:
        text = istime == 'Last 7 days'
            ? 'Wed'
            : month["monthCount"][15]["date"].toString();
        break;
      case 4:
        text = istime == 'Last 7 days'
            ? 'Thur'
            : month["monthCount"][20]["date"].toString();
        break;
      case 5:
        text = istime == 'Last 7 days'
            ? 'Fri'
            : month["monthCount"][25]["date"].toString();
        break;
      case 6:
        text = istime == 'Last 7 days'
            ? 'Sat'
            : month["monthCount"][29]["date"].toString();
        break;
      default:
        return const SizedBox();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(
        show: true,
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: colorPrimary.withOpacity(0.4), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        color: colorPrimary,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(
              0,
              istime == "Last 7 days"
                  ? weekendObj["sun"].toString().toDouble()
                  : month["monthCount"][0]["count"].toString().toDouble()),
          FlSpot(
              1,
              istime == "Last 7 days"
                  ? weekendObj["mon"].toString().toDouble()
                  : month["monthCount"][1]["count"].toString().toDouble()),
          FlSpot(
              2,
              istime == "Last 7 days"
                  ? weekendObj["tue"].toString().toDouble()
                  : month["monthCount"][2]["count"].toString().toDouble()),
          FlSpot(
              3,
              istime == "Last 7 days"
                  ? weekendObj["wed"].toString().toDouble()
                  : month["monthCount"][3]["count"].toString().toDouble()),
          FlSpot(
              4,
              istime == "Last 7 days"
                  ? weekendObj["thur"].toString().toDouble()
                  : month["monthCount"][4]["count"].toString().toDouble()),
          FlSpot(
              5,
              istime == "Last 7 days"
                  ? weekendObj["fri"].toString().toDouble()
                  : month["monthCount"][5]["count"].toString().toDouble()),
          FlSpot(
              6,
              istime == "Last 7 days"
                  ? weekendObj["sat"].toString().toDouble()
                  : month["monthCount"][6]["count"].toString().toDouble()),
        ],
      );
}

// Mian Class...............................
class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<StatefulWidget> createState() => OverviewScreenState();
}

class OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    // print("object");
    // var timeValue = 'Last 7 days';
    return Scaffold(
      appBar: CustomAppBar(
        title: "Overview",
        backbutton: true,
        backPressed: () {
          finish(context);
        },
      ),
      body: FutureBuilder(
        future: HomeViewModel().getOverview(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomLoadingIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: text(snapshot.error.toString(),
                    maxLine: 5, isCentered: true));
          } else {
            var counts = snapshot.data["counts"];
            Map<String, dynamic> weekendObj = snapshot.data["weekendObj"];
            var month = snapshot.data["month"];
            // Find the Max value....
            int maxValue = 0;
            weekendObj.forEach((key, value) {
              if (value is int && value > maxValue) {
                maxValue = value;
              }
            });

            return Column(
              children: [
                Column(
                  children: [
                    Row(children: [
                      Expanded(
                          child: CountContainer(
                        count: counts["today"].toString(),
                        usedTime: "Credit Used Today",
                      )),
                      const SizedBox(
                        width: spacing_middle,
                      ),
                      Expanded(
                          child: CountContainer(
                        count: counts["week"].toString(),
                        usedTime: "Used Last week",
                      )),
                    ]).paddingTop(spacing_twinty),
                    Row(children: [
                      Expanded(
                          child: CountContainer(
                        count: counts["month"].toString(),
                        usedTime: "Used Last Month",
                      )),
                      const SizedBox(
                        width: spacing_middle,
                      ),
                      Expanded(
                          child: CountContainer(
                        count: counts["remainingCoins"].toString(),
                        usedTime: "RemainingCoins",
                      )),
                    ]).paddingTop(spacing_middle),
                  ],
                ).paddingSymmetric(horizontal: spacing_twinty),
                Consumer<UserViewModel2>(
                  builder: (BuildContext context, val, Widget? child) {
                    return Expanded(
                      child: Card(
                        elevation: 0,
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 16, left: 6),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 37,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            svg_lineChart,
                                            height: 20,
                                            width: 20,
                                            fit: BoxFit.contain,
                                            color: colorPrimary,
                                          ),
                                          const SizedBox(
                                            width: spacing_middle,
                                          ),
                                          text('Credit Usage',
                                              fontSize: textSizeSMedium,
                                              fontWeight: FontWeight.w600)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: DropdownButton(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          dropdownColor: color_white,
                                          elevation: 0,
                                          value: val.timeValue,
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: 'Last 7 days',
                                              child: text('last 7 days',
                                                  fontSize: textSizeSmall),
                                            ),
                                            DropdownMenuItem<String>(
                                              value: 'Last Month',
                                              child: text('Last Month',
                                                  fontSize: textSizeSmall),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            val.changeDropdownValue(value);
                                          },
                                        ).paddingTop(spacing_twinty),
                                      ),
                                    ],
                                  ).paddingSymmetric(
                                      horizontal: spacing_twinty),
                                  const SizedBox(
                                    height: 37,
                                  ),
                                  Expanded(
                                    child: LineChartClass(
                                      month: month,
                                      weekendObj: weekendObj,
                                      istime: val.timeValue,
                                      maxVal:maxValue,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ).paddingTop(spacing_twinty),
                    );
                  },
                ).paddingSymmetric(horizontal: spacing_standard_new),
              ],
            );
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CountContainer extends StatelessWidget {
  String? count;
  String? usedTime;
  CountContainer({required this.count, required this.usedTime, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: colorPrimaryS.withOpacity(.2),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SvgPicture.asset(
              drawer_ic_Coins,
              height: 30,
              width: 30,
            ),
            const SizedBox(
              width: spacing_middle,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(count,
                    fontSize: textSizeLargeMedium, fontWeight: FontWeight.w500),
                text(usedTime, fontSize: textSizeSmall),
              ],
            ),
          ],
        ).paddingSymmetric(
            horizontal: spacing_middle, vertical: spacing_twinty));
  }
}
