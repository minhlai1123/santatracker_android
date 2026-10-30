import 'package:flutter/foundation.dart';

abstract class NetworkStatusProvider implements ValueListenable<bool> {
  bool get isOffline;
}

class SimulatedNetworkStatusProvider extends ValueNotifier<bool>
    implements NetworkStatusProvider {
  SimulatedNetworkStatusProvider({bool initialIsOffline = false})
    : super(initialIsOffline);

  @override
  bool get isOffline => value;

  void setOffline(bool offline) {
    if (value != offline) {
      value = offline;
    }
  }
}
