import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

class LeaderboardItemWidget extends StatelessWidget {
  final List<BarChartGroupData> data;
  final List<String> titles;

  LeaderboardItemWidget({Key? key, required this.data, required this.titles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.deepPurple500,
          width: 2.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        padding: EdgeInsets.all(5.h),
        decoration: AppDecoration.outlinePurple.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        width: 330,
        height: 200,
        child: Container(
          width: 330,
          height: 330,
          decoration: BoxDecoration(
            color: appTheme.deepPurple500,
            borderRadius: BorderRadius.circular(
              5.h,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Universitetstävlingen",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 26,
                      ),
                ),
                Text(
                  "Totala mängd poäng",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                ),
                Expanded(
                  child: BarChart(BarChartData(
                    gridData: FlGridData(show: false),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 200000,
                    barTouchData: BarTouchData(enabled: false),
                    barGroups: data,
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                        reservedSize: 35,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          );
                          switch (value.toInt()) {
                            case 0:
                              return SideTitleWidget(
                                  child: Text(titles[0], style: style),
                                  axisSide: AxisSide.bottom);
                            case 1:
                              return SideTitleWidget(
                                  child: Text(titles[1], style: style),
                                  axisSide: AxisSide.bottom);
                            case 2:
                              return SideTitleWidget(
                                  child: Text(titles[2], style: style),
                                  axisSide: AxisSide.bottom);
                            case 3:
                              return SideTitleWidget(
                                  child: Text(titles[3], style: style),
                                  axisSide: AxisSide.bottom);
                            default:
                              return SideTitleWidget(
                                  child: Text("error", style: style),
                                  axisSide: AxisSide.bottom);
                          }
                        },
                      )),
                    ),
                  )),
                ),
                SizedBox(
                  height: 1.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
