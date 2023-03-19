//
//  ApiErrorModel.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation

// MARK: - ApiErrorModel
struct ApiErrorModel: Codable {
    let status: Int?
    let error: String?
    let path: String?
}
