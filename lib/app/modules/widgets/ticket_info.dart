import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketInfo extends GetView {
  final int index;
  final String ticketId;
  final String fullName;
  final String amountPaid;
  final String scannedTimestamp;

  TicketInfo({
    required this.index,
    required this.ticketId,
    required this.fullName,
    required this.amountPaid,
    required this.scannedTimestamp,
  });

  @override
  Widget build(BuildContext context) {
    final dateAndTime = scannedTimestamp.split(' '); // Split the timestamp into date and time
    final scannedDate = dateAndTime[0];
    final scannedTime = dateAndTime[1];


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom greenish small circle on top
        if (index > 0) GrayBar(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GreenCircle(), // Custom greenish small circle
            // Remove the SizedBox to eliminate space
            const SizedBox(
              width: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ticket Number/ID: ${ticketId}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Price: ${amountPaid}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            // Add flexible space to push the left and middle columns together
            Expanded(child: Container()),
            // Right column with date and time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  scannedDate,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  scannedTime,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}


class GreenCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors
            .green, // You can change the color to your desired shade of green
      ),
    );
  }
}

class GrayBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 50,
      color: Colors
          .grey[300], // You can change the color to your desired shade of gray
    );
  }
}
