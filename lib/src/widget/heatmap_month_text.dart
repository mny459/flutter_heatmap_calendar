import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/src/data/heatmap_first_day.dart';
import '../util/date_util.dart';

class HeatMapMonthText extends StatelessWidget {
  /// List value of every sunday's month information.
  ///
  /// From 1: January to 12: December.
  final List<HeatmapFirstDay>? firstDayInfos;

  /// The double value for space between labels.
  final double? size;

  /// The double value of font size.
  final double? fontSize;

  /// The color value of font color.
  final Color? fontColor;

  /// The margin value for correctly space between labels.
  final EdgeInsets? margin;

  const HeatMapMonthText({
    Key? key,
    this.firstDayInfos,
    this.fontSize,
    this.fontColor,
    this.size,
    this.margin,
  }) : super(key: key);

  /// The list of every month labels and fitted space.
  List<Widget> _labels() {
    List<Widget> items = [];
    // Set true if previous week was the first day of the month.
    bool _write = false;

    // Loop until check every given weeks.
    for (int label = 0; label < (firstDayInfos?.length ?? 0); label++) {
      final currentMonth = firstDayInfos![label];
      // If given week is first week of given datesets or
      // first week of month, create labels
      if (label == 0 ||
          (label > 0 && currentMonth != firstDayInfos![label - 1])) {
        _write = true;
        var monthText = DateUtil.SHORT_MONTH_LABEL[currentMonth.month];
        final cellWidth = (size ?? 20) + (margin?.right ?? 2);
        final marginLeft = margin?.left ?? 2;
        final marginRight = margin?.right ?? 2;
        var width = cellWidth * 2;

        if (currentMonth.month == 1) {
          monthText = '$monthText ${currentMonth.year}';
          width = cellWidth * 5 + 4 * marginLeft;
        }

        // Add Text without width margin if first week is end of the month.
        // Otherwise, add Text with width margin.
        items.add(
          firstDayInfos!.length == 1 ||
                  (label == 0 && currentMonth != firstDayInfos![label + 1])
              ? _renderText(monthText)
              : Container(
                  width: width,
                  margin: EdgeInsets.only(left: marginLeft, right: marginRight),
                  child: _renderText(monthText),
                ),
        );
      } else if (_write) {
        // If given week is the next week of labeled week.
        // do nothing.
        _write = false;
      } else {
        // Else create empty box.
        if (currentMonth.month != 1) {
          items.add(Container(
            margin: EdgeInsets.only(
                left: margin?.left ?? 2, right: margin?.right ?? 2),
            width: size ?? 20,
          ));
        }
      }
    }

    return items;
  }

  Widget _renderText(String text) {
    return Text(
      text,
      textScaleFactor: 1.0,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _labels(),
    );
  }
}
