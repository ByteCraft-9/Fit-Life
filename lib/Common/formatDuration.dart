import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

List<SetStruct> createSets() {
  SetStruct set1 = SetStruct(reps: 10, weight: 145);
  return [set1];
}

String formatDuration(int milliseconds) {
  Duration duration = Duration(milliseconds: milliseconds);
  int twoDigitMinutes = duration.inMinutes.remainder(60);
  int twoDigitSeconds = duration.inSeconds.remainder(60);
  String twoDigitMinutesStr = twoDigitMinutes.toString().padLeft(2, '0');
  String twoDigitSecondsStr = twoDigitSeconds.toString().padLeft(2, '0');
  return "$twoDigitMinutesStr:$twoDigitSecondsStr";
}

List<String> chartLabel() {
  return ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
}

List<int> getFrequency(List<DateTime> workouts) {
  List<int> frequency = List.filled(7, 0);
  for (var workout in workouts) {
    int day0fWeek = workout.weekday;
    frequency[day0fWeek - 1]++;
  }
  return frequency;
}
