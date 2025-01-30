part of 'reservation_cubit.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}

final class ReservationLoading extends ReservationState {}

final class ReservationsLoaded extends ReservationState {
  final List<String> seats;
  final DateTime? selectedDate;
  final String? selectedTime;

  ReservationsLoaded({
    required this.seats,
    this.selectedDate,
    this.selectedTime,
  });
}

final class ReservationFailed extends ReservationState {
  final String message;

  ReservationFailed({required this.message});
}
