import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/mock_data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.RUSSIAN);
        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });

    on<UpdateWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        Position position = await Geolocator.getCurrentPosition();
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.RUSSIAN);
        Weather weather = await wf.currentWeatherByLocation(
            position.latitude, position.longitude);
        print(weather.date);
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
