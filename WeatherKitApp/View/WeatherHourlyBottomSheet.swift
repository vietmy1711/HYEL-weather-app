//
//  WeatherHourlyBottomSheet.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import SwiftUI
import CoreLocation

struct WeatherHourlyBottomSheet: View {
    @StateObject private var hourlyViewModel: HourlyViewModel = HourlyViewModel(repository: WeatherRepository())
    
    var day: Day
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees

    var body: some View {
        ZStack{
            LinearGradient(colors: [.cyan, .gray], startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Forecase hourly for").bold().foregroundColor(.white).font(.headline)
                Text(day.forecastStart?.getDate()?.getReadableDate() ?? "").bold().foregroundColor(.white).font(.title)
                if hourlyViewModel.isLoading {
                    LoadingView()
                } else {
                    ScrollView {
                        if hourlyViewModel.weatherModel?.forecastHourly?.hours?.count ?? 0 >= 24 {
                            ForEach(1..<24) { i in
                                WeatherHourlyItemView(hour: hourlyViewModel.weatherModel?.forecastHourly?.hours?[i].forecastStart?.getDate()?.getHour(), condition: hourlyViewModel.weatherModel?.forecastHourly?.hours?[i].conditionCode,iconName: hourlyViewModel.weatherModel?.forecastHourly?.hours?[i].conditionCode?.getNameImageWeather(), temp: hourlyViewModel.weatherModel?.forecastHourly?.hours?[i].temperature)
                            }
                        }
                    }
                }
            }.padding(16)
        }.task {
            hourlyViewModel.getWeatherHourly(lat: lat, lon: lon, day: day)
        }.errorAlert(error: hourlyViewModel.error) {
            hourlyViewModel.getWeatherHourly(lat: lat, lon: lon, day: day)
        }
    }
}

//struct WeatherHourlyBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherHourlyBottomSheet()
//    }
//}
