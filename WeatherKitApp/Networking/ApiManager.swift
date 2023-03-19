//
//  ApiManager.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation

class SavedKeys{
    public static let accessToken = "access_token"
    public static var accessKey: String {
        return ProcessInfo.processInfo.environment["AUTH_TOKEN"] ?? ""
    }
}

class ApiManager {
    public static let shared = ApiManager()
    
    let baseUrl = "https://weatherkit.apple.com/api/v1/weather/en/"
        
    func getAuthToken() -> String? {
        return ProcessInfo.processInfo.environment["AUTH_TOKEN"] ?? ""
    }
}
