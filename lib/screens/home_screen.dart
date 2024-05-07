import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/ui/ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherBlocBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBlocBloc>(context);
  }

  Future<void> refresh() async {
    WeatherBlocBloc().add(UpdateWeather());
    _weatherBloc.add(UpdateWeather());
  }

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        onRefresh: () async {
          refresh();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
            child: SizedBox(
              // height: mqSize.height,
              child: Stack(
                children: [
                  const ColorsBackground(),
                  BlocConsumer<WeatherBlocBloc, WeatherBlocState>(
                    listener: (BuildContext context, WeatherBlocState state) {
                      if (state is WeatherBlocFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.toString())));
                      }
                    },
                    builder: (context, state) {
                      if (state is WeatherBlocSuccess) {
                        return SizedBox(
                          width: mqSize.width,
                          height: mqSize.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '📡 ${state.weather.areaName}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: Image.asset(
                                  'assets/${state.weather.weatherIcon}.png',
                                  scale: 0.35,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Text(
                                  '${state.weather.temperature!.celsius!.toStringAsFixed(2)}℃',
                                  style: const TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Center(
                                child: Text(
                                  state.weather.weatherDescription![0]
                                          .toUpperCase() +
                                      state.weather.weatherDescription!
                                          .substring(1)
                                          .toLowerCase(),
                                  style: const TextStyle(
                                    // textBaseline: TextBaseline.alphabetic,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  DateFormat('MMM d, EEEE ∘ HH:mm')
                                      .format(state.weather.date!),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/sunrise.png',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Sunrise'),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            DateFormat('HH:mm')
                                                .format(state.weather.sunset!),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/sunset.png',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Sunset'),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            DateFormat('HH:mm')
                                                .format(state.weather.sunrise!),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(color: Colors.grey),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/thermometer-hot.png',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Temp Max'),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${state.weather.tempMax!.celsius!.toStringAsFixed(2)}℃',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/thermometer-cold.png',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Temp Min'),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${state.weather.tempMin!.celsius!.toStringAsFixed(2)}℃',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
