import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/statisticaL_provider.dart';
import '../../../ulti/constant.dart';

class MoodPieChartWidget extends StatelessWidget {
  const MoodPieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StatisticalProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return Stack(
          children: [
            Opacity(
              opacity: provider.enableChart ? 1 : 0.3,
              child: AspectRatio(
                aspectRatio: 1.1,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 1,
                    centerSpaceRadius: 0,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sections: provider.moodPercents.asMap().map((index, moodPercent) {
                      return MapEntry(
                          index,
                          PieChartSectionData(
                            value: moodPercent,
                            title: '${moodPercent.round()}%',
                            radius: 160,
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                              shadows: [Shadow(color: Colors.black, blurRadius: 5)],
                            ),
                            color: Constant.moodColor[index],
                            badgeWidget: Constant.listEmoji[index].svg(width: 30),
                            badgePositionPercentageOffset: .8,
                          )
                      );
                    }).values.toList(),
                  ),
                ),
              ),
            ),
            if(!provider.enableChart)
            const Positioned(
              bottom: 150,
              left: 0,
              right: 0,
              child: Text('Cần thêm dữ liệu cho biểu đồ này. Xin vui lòng thêm nhật ký của bạn',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
              )
            )
          ],
        );
      },
    );
  }
}
