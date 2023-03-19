//
//  AppCache.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation

class AppCache {
    static let shared = AppCache()
    
    let saveKey = "WEATHER_MODEL"
    
    func getWeatherModel() -> WeatherModel? {
        if let encoded = UserDefaults.standard.object(forKey: saveKey) as? Data {
            let decoder = JSONDecoder()
            if let weather = try? decoder.decode(WeatherModel.self, from: encoded) {
                return weather
            }
        }
        return nil
    }
    
    func setWeatherModel(_ model: WeatherModel?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: saveKey)
        }
    }
    
    func clearWeatherModel() {
        UserDefaults.standard.removeObject(forKey: saveKey)
    }
}
