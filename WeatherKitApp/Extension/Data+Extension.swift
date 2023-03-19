//
//  Data+Extension.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation

extension Date {
    func getTodayWeekDay()-> String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEE"
           let weekDay = dateFormatter.string(from: self)
           return weekDay
     }
}
