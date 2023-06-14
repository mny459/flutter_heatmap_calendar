class HeatmapFirstDay {
  final int year;
  final int month;

  HeatmapFirstDay(this.year, this.month);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeatmapFirstDay &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          month == other.month;

  @override
  int get hashCode => year.hashCode ^ month.hashCode;

  @override
  String toString() {
    return 'HeatmapFirstDay{year: $year, month: $month}';
  }

}