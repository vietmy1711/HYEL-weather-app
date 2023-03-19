//
//  WeatherRepository.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation
import CoreLocation

class WeatherRepository: ObservableObject {
    func getWeatherDaily(lat: CLLocationDegrees, lon: CLLocationDegrees, completionHandler: @escaping (WeatherModel?, ErrorType?) -> Void) {
        let dataset = "forecastDaily,currentWeather"
        ApiRequest.shared.request(path: "\(lat)/\(lon)", method: .GET, queryParams: ["dataSets": dataset]) { data, errType, error in
            guard let data = data else {
                if let model = AppCache.shared.getWeatherModel() {
                    completionHandler(model, errType)
                    return
                }

                completionHandler(nil, errType)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let weatherModel = try jsonDecoder.decode(WeatherModel.self, from: data)
                AppCache.shared.setWeatherModel(weatherModel)
                completionHandler(weatherModel, errType)
            } catch let parsingError {
                print("Error: \(parsingError)")
                if let model = AppCache.shared.getWeatherModel() {
                    completionHandler(model, errType)
                    return
                }
                completionHandler(nil, errType)
            }
        }
    }
    
    func getWeatherHourly(lat: CLLocationDegrees, lon: CLLocationDegrees, day: Day, completionHandler: @escaping (WeatherModel?, ErrorType?) -> Void) {
        let dataset = "forecastHourly"
        ApiRequest.shared.request(path: "\(lat)/\(lon)", method: .GET, queryParams: ["dataSets": dataset, "dailyStart": day.forecastStart ?? ""]) { data, errType, error in
            guard let data = data else {
                completionHandler(nil, errType)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let weatherModel = try jsonDecoder.decode(WeatherModel.self, from: data)
                completionHandler(weatherModel, errType)
            } catch let parsingError {
                print("Error: \(parsingError)")
                completionHandler(nil, errType)
            }
        }
    }
    
}
