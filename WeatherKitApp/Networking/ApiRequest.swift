//
//  ApiRequest.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation

enum ErrorType {
    case fetchingNoInternet
    case fetchingUnknown
    
    var errorTitle: String {
        switch self {
        default:
            return "Request Failed"
        }
    }
    
    var errorMessage: String {
        switch self {
        case .fetchingNoInternet:
            return "No internet connection. Please connect and try again"
        case .fetchingUnknown:
            return "Something went wrong. Please try again"
        }
    }
}

class ApiRequest {
    
    public static let shared = ApiRequest()
    
    func request(path: String, method: HTTPMethod, queryParams: [String: String], completionHandler: @escaping (Data?, ErrorType?, Error?)->Void) {
        handleRequest(url: ApiManager.shared.baseUrl + path, method: method, queryParams: queryParams, completionHandler: completionHandler)
    }
    
    private func handleRequest(url: String, method: HTTPMethod, queryParams: [String: String], completionHandler: @escaping (Data?, ErrorType?, Error?)->Void) {
        guard NetworkManager.isConnectedToNetwork() else {
            completionHandler(nil, .fetchingNoInternet, nil)
            return
        }
        var components = URLComponents(string: url)!
        components.queryItems = queryParams.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        if let authToken = ApiManager.shared.getAuthToken() {
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        print("Making request to: \(String(describing: components.url))")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, .fetchingUnknown, error)
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            completionHandler(data, nil, nil)
        }
        task.resume()
    }
}
