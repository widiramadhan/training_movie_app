class TicketEntity {
  final String id;
  final String seat;
  final DateTime date;
  final double price;

  const TicketEntity({
    required this.id,
    required this.seat,
    required this.date,
    required this.price,
  });
}
