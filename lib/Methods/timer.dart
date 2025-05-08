import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/my_custom_text.dart';

class DeadlineTimer extends StatefulWidget {
  final String orderId;

  const DeadlineTimer({required this.orderId, super.key});

  @override
  DeadlineTimerState createState() => DeadlineTimerState();
}

class DeadlineTimerState extends State<DeadlineTimer> {
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _fetchDeadline();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _fetchDeadline() async {
    try {
      // Fetch the order from Firestore
      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .doc(widget.orderId)
          .get();

      if (orderSnapshot.exists && orderSnapshot['Delivery_Date'] != null) {
        // Convert Firestore Timestamp to DateTime
        Timestamp timestamp = orderSnapshot['Delivery_Date'];
        DateTime deadline = timestamp.toDate();

        // Start countdown
        if (mounted) {
          _startTimer(deadline);
        }
      }
    } catch (e) {
      debugPrint("Error fetching deadline: $e");
    }
  }

  void _startTimer(DateTime deadline) {
    _timer?.cancel(); // Cancel existing timer if any

    if (!mounted) return; // Ensure widget is still in the tree

    setState(() {
      _timeRemaining = deadline.difference(DateTime.now());
    });

    if (_timeRemaining.isNegative) {
      if (mounted) {
        setState(() {
          _timeRemaining = Duration.zero; // Deadline passed
        });
      }
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel(); // Stop the timer if the widget is no longer mounted
        return;
      }

      setState(() {
        _timeRemaining = deadline.difference(DateTime.now());

        if (_timeRemaining.isNegative) {
          _timeRemaining = Duration.zero;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _timeRemaining.inSeconds > 0
            ? MyCustomText(
                text:
                    "Time Left: ${_timeRemaining.inDays}d ${_timeRemaining.inHours.remainder(24)}h ${_timeRemaining.inMinutes.remainder(60)}m ${_timeRemaining.inSeconds.remainder(60)}s",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 118, 43, 180),
              )
            : MyCustomText(
                text: "Deadline Passed!",
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ));
  }
}
