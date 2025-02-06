import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit() : super(TicketInitial());
}
