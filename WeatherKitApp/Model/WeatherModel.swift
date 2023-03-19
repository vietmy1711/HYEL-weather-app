//
//  WeatherModel.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let forecastDaily: ForecastDaily?
    let currentWeather: CurrentWeather?
    let forecastHourly: ForecastHourly?
}

// MARK: - ForecastDaily
struct ForecastDaily: Codable {
    let name: String?
    let metadata: Metadata?
    let days: [Day]?
}

// MARK: - Day
struct Day: Codable {
    let forecastStart, forecastEnd: String?
    let conditionCode: String?
    let temperatureMax, temperatureMin: Double?
}

// MARK: - Metadata
struct Metadata: Codable {
    let attributionURL: String?
    let expireTime: String?
    let latitude, longitude: Double?
    let readTime, reportedTime: String?
    let units: String?
    let version: Int?
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let name: String?
    let metadata: Metadata?
    let asOf: String?
    let conditionCode: String?
    let temperature: Double?
}

// MARK: - ForecastHourly
struct ForecastHourly: Codable {
    let name: String?
    let metadata: Metadata?
    let hours: [Hour]?
}

// MARK: - Hour
struct Hour: Codable {
    let forecastStart: String?
    let conditionCode: String?
    let temperature: Double?

}


