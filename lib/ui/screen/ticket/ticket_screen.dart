import 'package:flutter/material.dart';
import 'package:movie/domain/entities/ticket.dart';

class TicketScreen extends StatelessWidget {
  final TicketEntity ticket;
  const TicketScreen({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
