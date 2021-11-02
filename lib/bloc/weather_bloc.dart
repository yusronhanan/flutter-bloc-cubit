import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cubit_bloc_tutorial/data/model/weather.dart';
import 'package:flutter_cubit_bloc_tutorial/data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      // add async* to use yield
      // TODO: implement event handler
      if (event is GetWeather) {
        try {
          emit(WeatherLoading());
          final weather = await _weatherRepository.fetchWeather(event.cityName);
          emit(WeatherLoaded(weather));
        } on NetworkException {
          emit(WeatherError("Couldn't fetch weather data. Network Error"));
        }
      }
    });
  }
}
