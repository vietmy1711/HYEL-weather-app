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
                if (weatherModel.forecastHourly == nil && weatherModel.currentWeather == nil && weatherModel.forecastDaily == nil) {
                    // We don't get an error code from our response status code, we have to decode this
                    if let errorModel = try? jsonDecoder.decode(ApiErrorModel.self, from: data) {
                        switch errorModel.status {
                        case HTTPResponseStatusCode.unauthorize.rawValue:
                            completionHandler(nil, .unauthorized)
                        default:
                            completionHandler(nil, .fetchingUnknown)
                        }
                        print("Status: \(errorModel.status ?? -1) Error: \(errorModel.error ?? "Unknown") Path: \(errorModel.path ?? "Unknown")")
                        return
                    }
                    
                    completionHandler(nil, errType)
                    return
                }
                AppCache.shared.setWeatherModel(weatherModel)
                completionHandler(weatherModel, errType)
            } catch let parsingError {
                print("Error: \(parsingError)")
                if let model = AppCache.shared.getWeatherModel() {
                    completionHandler(model, errType ?? .fetchingUnknown)
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
