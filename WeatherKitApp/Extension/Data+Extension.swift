//
//  Data+Extension.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import Foundation

extension Date {
    func getWeekDay() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEE"
           let weekDay = dateFormatter.string(from: self)
           return weekDay
     }
    
    func getHour() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH"
           let hour = dateFormatter.string(from: self)
           return hour
     }
    
    func getReadableDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let readableDate = dateFormatter.string(from: self)
        return readableDate

    }

}
