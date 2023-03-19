//
//  WeatherViewModel.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation
import CoreLocation
import WeatherKit

class WeatherViewModel: ObservableObject {
    private let service = WeatherService.shared

    var repository: WeatherRepository;
    
    @Published var isLoading: Bool = false

    @Published var weatherModel: WeatherModel?
    @Published var error: ErrorType?

    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func getWeatherDaily(lat: CLLocationDegrees, lon: CLLocationDegrees, dataset: DataSetWeather) {
        isLoading = true
        repository.getWeatherDaily(lat: lat, lon: lon, dataset: [.currentWeather, .forecastDaily]) { [weak self] fetchedWeather, errType in
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
