//
//  String+Extension.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation

extension String {
    func camelCaseToWords() -> String {
        return unicodeScalars.dropFirst().reduce(String(prefix(1))) {
            return CharacterSet.uppercaseLetters.contains($1)
            ? $0 + " " + String($1)
            : $0 + String($1)
        }
    }
    
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }
    
    func getNameImageWeather() -> String {
        switch self {
        case "Clear":
            return "sun.max.fill"
        case "MostlyClear":
            return "sun.min.fill"
        case "PartlyCloudy":
            return "cloud.sun.fill"
        case "MostlyCloudy":
            return "cloud.fill"
        case "Cloudy":
            return "cloud.fill"
        case "Hazy":
            return "sun.haze.fill"
        case "ScatteredThunderstorms":
            return "cloud.sun.bolt.fill"
        case "Drizzle":
            return "cloud.drizzle.fill"
        case "rain":
            return "cloud.rain.fill"
        case "HeavyRain":
            return "cloud.heavyrain.fill"
        case "Thunderstorms":
            return "cloud.bolt.rain.fill"
        default:
            return "sun.min.fill"
        }
    }
}
