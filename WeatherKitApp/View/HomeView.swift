//
//  HomeView.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import SwiftUI

extension Double {
    func roundedToIntString() -> String {
        String(Int(self))
    }
}


struct HomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    @StateObject private var weatherViewModel = WeatherViewModel(repository: WeatherRepository())
    
    
    var body: some View {
        VStack {
            if weatherViewModel.isLoading {
                LoadingView()
            } else {
                ZStack {
                    LinearGradient(colors: [.blue, .gray], startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Today").bold().font(.title).foregroundColor(.white)
                        Text(weatherViewModel.weatherModel?.currentWeather?.temperature?.roundedToIntString() ?? "").font(.system(size: 72)).foregroundColor(.white)
                        Text(weatherViewModel.weatherModel?.currentWeather?.conditionCode ?? "").font(.headline).foregroundColor(.white).padding(.horizontal, 10)
                        Text("H:\(weatherViewModel.weatherModel?.forecastDaily?.days?.first?.temperatureMax?.roundedToIntString() ?? "-")° L:\(weatherViewModel.weatherModel?.forecastDaily?.days?.first?.temperatureMin?.roundedToIntString() ?? "-")°").foregroundColor(.white)
                        ScrollView {
                            HStack {
                                Text("10-Day Forecast").foregroundColor(.white).font(.caption).bold()
                                Spacer()
                            }
                            WeatherDailyView(weekDay: "Today", iconName: "cloud.sun.fill", tempHigh: weatherViewModel.weatherModel?.forecastDaily?.days?.first?.temperatureMax, tempLow: weatherViewModel.weatherModel?.forecastDaily?.days?.first?.temperatureMin)
                            if weatherViewModel.weatherModel?.forecastDaily?.days?.count ?? 0 >= 10 {
                                ForEach(1..<10) { i in
                                    WeatherDailyView(weekDay: weatherViewModel.weatherModel?.forecastDaily?.days?[i].forecastStart?.getDate()?.getTodayWeekDay(), iconName: weatherViewModel.weatherModel?.forecastDaily?.days?[i].conditionCode?.getNameImageWeather(), tempHigh: weatherViewModel.weatherModel?.forecastDaily?.days?[i].temperatureMax, tempLow: weatherViewModel.weatherModel?.forecastDaily?.days?[i].temperatureMin)
                                }
                            }
                        }.padding(.all, 16)
                    }
                }
            }
        }.task {
            guard let location = locationManager.location else { return }
            weatherViewModel.getWeatherDaily(lat: location.latitude, lon: location.longitude, dataset: .forecastDaily)
        }.errorAlert(error: weatherViewModel.error) {
            guard let location = locationManager.location else { return }
            weatherViewModel.getWeatherDaily(lat: location.latitude, lon: location.longitude, dataset: .forecastDaily)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
