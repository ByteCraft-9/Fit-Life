// ignore_for_file: use_super_parameters

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

export 'package:fl_chart/fl_chart.dart'
    show BarAreaData, FlDotData, LineChartBarData, BarChartAlignment;

class FlutterFlowBarChart extends StatelessWidget {
  const FlutterFlowBarChart({
    Key? key,
    required this.barData,
    required this.xLabels,
    required this.xAxisLabelInfo,
    required this.yAxisLabelInfo,
    required this.axisBounds,
    this.stacked = false,
    this.barWidth,
    this.barBorderRadius,
    this.barSpace,
    this.groupSpace,
    this.alignment = BarChartAlignment.center,
    this.chartStylingInfo = const ChartStylingInfo(),
  }) : super(key: key);

  final List<FFBarChartData> barData;
  final List<String> xLabels;
  final AxisLabelInfo xAxisLabelInfo;
  final AxisLabelInfo yAxisLabelInfo;
  final AxisBounds axisBounds;
  final bool stacked;
  final double? barWidth;
  final BorderRadius? barBorderRadius;
  final double? barSpace;
  final double? groupSpace;
  final BarChartAlignment alignment;
  final ChartStylingInfo chartStylingInfo;

  Map<int, List<double>> get dataMap => xLabels.asMap().map((key, value) =>
      MapEntry(key, barData.map((data) => data.data[key]).toList()));

  List<BarChartGroupData> get groups => dataMap.entries.map((entry) {
        final groupInt = entry.key;
        final groupData = entry.value;
        return BarChartGroupData(
            x: groupInt,
            barsSpace: barSpace,
            barRods: groupData.asMap().entries.map((rod) {
              final rodInt = rod.key;
              final rodSettings = barData[rodInt];
              final rodValue = rod.value;
              return BarChartRodData(
                toY: rodValue,
                color: rodSettings.color,
                width: barWidth,
                borderRadius: barBorderRadius,
                borderSide: BorderSide(
                  width: rodSettings.borderWidth,
                  color: rodSettings.borderColor,
                ),
              );
            }).toList());
      }).toList();

  List<BarChartGroupData> get stacks => dataMap.entries.map((entry) {
        final groupInt = entry.key;
        final stackData = entry.value;
        return BarChartGroupData(
          x: groupInt,
          barsSpace: barSpace,
          barRods: [
            BarChartRodData(
              toY: sum(stackData),
              width: barWidth,
              borderRadius: barBorderRadius,
              rodStackItems: stackData.asMap().entries.map((stack) {
                final stackInt = stack.key;
                final stackSettings = barData[stackInt];
                final start =
                    stackInt == 0 ? 0.0 : sum(stackData.sublist(0, stackInt));
                return BarChartRodStackItem(
                  start,
                  start + stack.value,
                  stackSettings.color,
                  BorderSide(
                    width: stackSettings.borderWidth,
                    color: stackSettings.borderColor,
                  ),
                );
              }).toList(),
            )
          ],
        );
      }).toList();

  double sum(List<double> list) => list.reduce((a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          handleBuiltInTouches: chartStylingInfo.enableTooltip,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (BarChartGroupData group) =>
                chartStylingInfo.tooltipBackgroundColor ?? Colors.blueGrey,
          ),
        ),
        alignment: alignment,
        gridData: FlGridData(show: chartStylingInfo.showGrid),
        borderData: FlBorderData(
          border: Border.all(
            color: chartStylingInfo.borderColor,
            width: chartStylingInfo.borderWidth,
          ),
          show: chartStylingInfo.showBorder,
        ),
        titlesData: getTitlesData(
          xAxisLabelInfo,
          yAxisLabelInfo,
          getXTitlesWidget: (val, _) => Text(
            xLabels[val.toInt()],
            style: xAxisLabelInfo.labelTextStyle,
          ),
        ),
        barGroups: stacked ? stacks : groups,
        groupsSpace: groupSpace,
        minY: axisBounds.minY,
        maxY: axisBounds.maxY,
        backgroundColor: chartStylingInfo.backgroundColor,
      ),
    );
  }
}

class ChartStylingInfo {
  const ChartStylingInfo({
    this.backgroundColor = Colors.white,
    this.showGrid = false,
    this.enableTooltip = false,
    this.tooltipBackgroundColor,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
    this.showBorder = true,
  });

  final Color backgroundColor;
  final bool showGrid;
  final bool enableTooltip;
  final Color? tooltipBackgroundColor;
  final Color borderColor;
  final double borderWidth;
  final bool showBorder;
}

class AxisLabelInfo {
  const AxisLabelInfo({
    this.title = '',
    this.titleTextStyle,
    this.showLabels = false,
    this.labelTextStyle,
    this.labelInterval,
    this.labelFormatter = const LabelFormatter(),
    this.reservedSize,
  });

  final String title;
  final TextStyle? titleTextStyle;
  final bool showLabels;
  final TextStyle? labelTextStyle;
  final double? labelInterval;
  final LabelFormatter labelFormatter;
  final double? reservedSize;
}

class LabelFormatter {
  const LabelFormatter({
    this.numberFormat,
  });

  final String Function(double)? numberFormat;
  NumberFormat get defaultFormat => NumberFormat()..significantDigits = 2;
}

class AxisBounds {
  const AxisBounds({this.minX, this.minY, this.maxX, this.maxY});

  final double? minX;
  final double? minY;
  final double? maxX;
  final double? maxY;
}

class FFBarChartData {
  const FFBarChartData({
    required this.yData,
    required this.color,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
  });

  final List<dynamic> yData;
  final Color color;
  final double borderWidth;
  final Color borderColor;

  List<double> get data => _dataToDouble(yData).map((e) => e ?? 0.0).toList();
}

List<double?> _dataToDouble(List<dynamic> data) {
  if (data.isEmpty) {
    return [];
  }
  if (data.first is double) {
    return data.map((d) => d as double).toList();
  }
  if (data.first is int) {
    return data.map((d) => (d as int).toDouble()).toList();
  }
  if (data.first is DateTime) {
    return data
        .map((d) => (d as DateTime).millisecondsSinceEpoch.toDouble())
        .toList();
  }
  if (data.first is String) {
    // First try to parse as doubles
    if (double.tryParse(data.first as String) != null) {
      return data.map((d) => double.tryParse(d as String)).toList();
    }
    if (int.tryParse(data.first as String) != null) {
      return data.map((d) => int.tryParse(d as String)?.toDouble()).toList();
    }
    if (DateTime.tryParse(data.first as String) != null) {
      return data
          .map((d) =>
              DateTime.tryParse(d as String)?.millisecondsSinceEpoch.toDouble())
          .toList();
    }
  }
  return [];
}

FlTitlesData getTitlesData(
  AxisLabelInfo xAxisLabelInfo,
  AxisLabelInfo yAxisLabelInfo, {
  Widget Function(double, TitleMeta)? getXTitlesWidget,
}) =>
    FlTitlesData(
      bottomTitles: AxisTitles(
        axisNameWidget: xAxisLabelInfo.title.isEmpty
            ? null
            : Text(
                xAxisLabelInfo.title,
                style: xAxisLabelInfo.titleTextStyle,
              ),
        axisNameSize: xAxisLabelInfo.titleTextStyle?.fontSize != null
            ? xAxisLabelInfo.titleTextStyle!.fontSize! + 12
            : 0.0,
        sideTitles: SideTitles(
          getTitlesWidget: (val, _) => getXTitlesWidget != null
              ? getXTitlesWidget(val, _)
              : Text(
                  formatLabel(xAxisLabelInfo.labelFormatter, val),
                  style: xAxisLabelInfo.labelTextStyle,
                ),
          showTitles: xAxisLabelInfo.showLabels,
          interval: xAxisLabelInfo.labelInterval,
          reservedSize: xAxisLabelInfo.reservedSize ?? 0.0,
        ),
      ),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        axisNameWidget: yAxisLabelInfo.title.isEmpty
            ? null
            : Text(
                yAxisLabelInfo.title,
                style: yAxisLabelInfo.titleTextStyle,
              ),
        axisNameSize: yAxisLabelInfo.titleTextStyle?.fontSize != null
            ? yAxisLabelInfo.titleTextStyle!.fontSize! + 12
            : 0.0,
        sideTitles: SideTitles(
          getTitlesWidget: (val, _) => Text(
            formatLabel(yAxisLabelInfo.labelFormatter, val),
            style: yAxisLabelInfo.labelTextStyle,
          ),
          showTitles: yAxisLabelInfo.showLabels,
          interval: yAxisLabelInfo.labelInterval,
          reservedSize: yAxisLabelInfo.reservedSize ?? 0.0,
        ),
      ),
    );

String formatLabel(LabelFormatter formatter, double value) {
  if (formatter.numberFormat != null) {
    return formatter.numberFormat!(value);
  }
  return formatter.defaultFormat.format(value);
}
