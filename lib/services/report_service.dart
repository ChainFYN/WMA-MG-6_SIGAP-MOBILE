import 'package:flutter/foundation.dart';
import '../models/report_model.dart';

class ReportService {
  static final ValueNotifier<List<ReportModel>> reportsNotifier = ValueNotifier<List<ReportModel>>([]);

  static List<ReportModel> get reports => reportsNotifier.value;

  static void addReport(ReportModel report) {
    reportsNotifier.value = [report, ...reportsNotifier.value];
  }

  static int get totalSubmitted => reportsNotifier.value.length;

  static int get totalWaiting => reportsNotifier.value.length;
}
