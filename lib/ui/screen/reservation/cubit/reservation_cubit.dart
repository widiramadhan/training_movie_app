import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/repositories/movie_repository.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit() : super(ReservationInitial());

  final repository = MovieRepository();

  final List<String> _seats = List.generate(60, (index) => 'available');
  final List<DateTime> dates = _generateDates();
  final List<String> times = ['18:00', '19:00', '20:00', '21:00'];

  DateTime? selectedDate;
  String? selectedTime;

  void generateRandomBookedSeats() {
    final random = Random();
    final bookedSeats = List.generate(10, (_) => random.nextInt(_seats.length));
    for (int index in bookedSeats) {
      _seats[index] = 'booked';
    }
    emit(ReservationsLoaded(seats: List<String>.from(_seats)));
  }

  void selectSeat(int index) {
    if (_seats[index] != 'booked') {
      for (int i = 0; i < _seats.length; i++) {
        if (_seats[i] == 'selected') {
          _seats[i] = 'available';
        }
      }
      _seats[index] = 'selected';
      emit(ReservationsLoaded(
          seats: List<String>.from(_seats),
          selectedDate: selectedDate,
          selectedTime: selectedTime));
    }
  }

  static List<DateTime> _generateDates() {
    final List<DateTime> dates = [];
    final now = DateTime.now();
    for (int i = 0; i <= 30; i++) {
      dates.add(now.add(Duration(days: i)));
    }
    return dates;
  }

  void selectDate(DateTime date) {
    print(date);
    print(dates);
    if (dates.contains(date)) {
      selectedDate = date;
      emit(ReservationsLoaded(
          seats: List<String>.from(_seats),
          selectedDate: selectedDate,
          selectedTime: selectedTime));
    }
  }

  void selectTime(String time) {
    if (times.contains(time)) {
      selectedTime = time;
      emit(ReservationsLoaded(
          seats: List<String>.from(_seats),
          selectedDate: selectedDate,
          selectedTime: selectedTime));
    }
  }
}
