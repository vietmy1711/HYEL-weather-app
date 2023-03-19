//
//  HourlyViewModel.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation
import CoreLocation

class HourlyViewModel: ObservableObject {

    var repository: WeatherRepository;
    
    @Published var isLoading: Bool = false

    @Published var weatherModel: WeatherModel?
    @Published var error: ErrorType?
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
        
    func getWeatherHourly(lat: CLLocationDegrees, lon: CLLocationDegrees, day: Day) {
        isLoading = true
        error = nil
        repository.getWeatherHourly(lat: lat, lon: lon, day: day) { [weak self] fetchedWeather, errType in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async { [weak strongSelf] in
                guard let strongSelf = strongSelf else { return }
                strongSelf.isLoading = false
                strongSelf.error = errType
                strongSelf.weatherModel = fetchedWeather
            }
        }
    }
}
