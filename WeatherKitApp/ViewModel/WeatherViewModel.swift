//
//  WeatherViewModel.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    var repository: WeatherRepository;
    
    @Published var isLoading: Bool = false

    @Published var weatherModel: WeatherModel?
    @Published var error: ErrorType?
    
    @Published var selectedValue: (CLLocationDegrees, CLLocationDegrees, Day)?
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func getWeatherDaily(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        isLoading = true
        error = nil
        repository.getWeatherDaily(lat: lat, lon: lon) { [weak self] fetchedWeather, errType in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async { [weak strongSelf] in
                guard let strongSelf = strongSelf else { return }
                strongSelf.isLoading = false
                strongSelf.error = errType
                strongSelf.weatherModel = fetchedWeather
            }
        }
    }
    
    func weekDayClicked(lat: CLLocationDegrees, lon: CLLocationDegrees, day: Day) {
        selectedValue = (lat, lon, day)
    }
}
