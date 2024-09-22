import 'package:flutter/material.dart';
import 'dart:async';

class RebuildWidget extends StatefulWidget {
  final Widget Function(BuildContext, Key) builder;
  final Duration refreshInterval;

  const RebuildWidget(
      {super.key, required this.builder, required this.refreshInterval});

  @override
  State<RebuildWidget> createState() => _RebuildWidgetState();
}

class _RebuildWidgetState extends State<RebuildWidget> {
  Timer? _timer;
  Key _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.refreshInterval, (timer) {
      setState(() {
        _key = UniqueKey();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _key);
  }
}
