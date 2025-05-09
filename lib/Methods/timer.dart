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
    bool isDeadlinePassed = _timeRemaining.inSeconds <= 0;

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
       // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDeadlinePassed
                ? [Colors.redAccent, Colors.red.shade700]
                : [Colors.deepPurple, Colors.cyan],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isDeadlinePassed
                  ? Icons.warning_amber_rounded
                  : Icons.timer_outlined,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: MyCustomText(
                text: isDeadlinePassed
                    ? "Deadline Passed!"
                    : "⏳ ${_timeRemaining.inDays}d ${_timeRemaining.inHours.remainder(24)}h "
                        "${_timeRemaining.inMinutes.remainder(60)}m ${_timeRemaining.inSeconds.remainder(60)}s",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
