import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/subhomanagement/home_mngmt_controller.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/subhomanagement/home_mngmt_state.dart';

final homeMngmtProvider =
    StateNotifierProvider.autoDispose<HomeMngmtController, HomeMngmtState>(
      (ref) => HomeMngmtController(),
    );
