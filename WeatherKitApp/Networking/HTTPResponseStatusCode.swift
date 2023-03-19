//
//  HTTPResponseStatusCode.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation

enum HTTPResponseStatusCode: Int {
    case noInternet                     = -1
    case unknown                        = 0
    case ok                             = 200
    case badRequest                     = 400
    case notFound                       = 404
}
