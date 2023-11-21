List<int> getWeekDays() {
  List<int> list = [];
  int current = DateTime.now().weekday;
  for (var i = current; i >= 1; i--) {
    list.add(i);
  }
  for (var i = 7; i > current; i--) {
    list.add(i);
  }
  return list.reversed.toList();
}

List<int> getMonthDays() {
  List<int> list = [];
  int current = DateTime.now().day;
  for (var i = current; i >= 1; i--) {
    list.add(i);
  }
  for (var i = 31; i > current; i--) {
    list.add(i);
  }
  return list.reversed.toList();
}

List<int> getYearMonths() {
  List<int> list = [];
  int current = DateTime.now().month;
  for (var i = current; i >= 1; i--) {
    list.add(i);
  }
  for (var i = 21; i > current; i--) {
    list.add(i);
  }
  return list.reversed.toList();
}
