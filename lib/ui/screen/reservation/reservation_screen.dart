import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/reservation/cubit/reservation_cubit.dart';

class ReservationScreen extends StatelessWidget {
  final String imagePath;

  ReservationScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      appBar: AppBar(
        title: const Text('Cinema Seat Selection'),
        backgroundColor: ColorPallete.colorPrimary,
        foregroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => ReservationCubit()..generateRandomBookedSeats(),
        child: BlocBuilder<ReservationCubit, ReservationState>(
          builder: (context, state) {
            if (state is ReservationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ReservationFailed) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            if (state is ReservationsLoaded) {
              final cubit = context.read<ReservationCubit>();

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          '${imagePath}',
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.cover,
                        ),

                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                const Text(
                                  'Select your seat',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorPallete.colorSecondary,
                                  ),
                                  child: SizedBox(
                                    height: 200,
                                    child: GridView.builder(
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 10,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemCount: state.seats.length,
                                      itemBuilder: (context, index) {
                                        final seatStatus = state.seats[index];
                                        return GestureDetector(
                                          onTap: () {
                                            cubit.selectSeat(index);
                                          },
                                          child: seatStatus == 'available'
                                              ? Image.asset('assets/images/available.png')
                                              : seatStatus == 'booked'
                                              ? Image.asset('assets/images/booked.png')
                                              : Image.asset(
                                              'assets/images/selected.png'),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDescription(),
                    const SizedBox(height: 24),
                    _buildDateSelector(cubit, state),
                    const SizedBox(height: 24),
                    _buildTimeSelector(cubit, state),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 100,
        padding: EdgeInsets.all(16),
        color: ColorPallete.colorPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'Rp. 50.000',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                ],
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPallete.colorOrange,
                ),
                onPressed: () {},
                child: Text(
                  "Buy Now",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                'assets/images/available.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Available',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Image.asset(
                'assets/images/booked.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Reserved',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Image.asset(
                'assets/images/selected.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Selected',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector(ReservationCubit cubit, ReservationsLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select date:',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 85,
          child: ListView.separated(
            itemCount: cubit.dates.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final date = cubit.dates[index];
              final isSelected = date == state.selectedDate;

              return GestureDetector(
                onTap: () {
                  cubit.selectDate(date);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? Colors.white : ColorPallete.colorSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('MMM').format(date),
                        style: TextStyle(
                          color: isSelected
                              ? ColorPallete.colorPrimary
                              : Colors.white,
                        ),
                      ),
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 20,
                          color: isSelected
                              ? ColorPallete.colorPrimary
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelector(ReservationCubit cubit, ReservationsLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select time:',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 45,
          child: ListView.separated(
            itemCount: cubit.times.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final time = cubit.times[index];
              final isSelected = time == state.selectedTime;

              return GestureDetector(
                onTap: () {
                  cubit.selectTime(time);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? Colors.white : ColorPallete.colorSecondary,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 18,
                      color:
                          isSelected ? ColorPallete.colorPrimary : Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
