//
//  WeatherHourlyItemView.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import SwiftUI

struct WeatherHourlyItemView: View {
    var hour: String?
    var condition: String?
    var iconName: String?
    var temp: Double?
    
    var body: some View {
        HStack {
            Text(hour ?? "").foregroundColor(.white).bold()
            Text(condition?.camelCaseToWords() ?? "").foregroundColor(.white).bold()
            Spacer()
            Image(systemName: iconName ?? "cloud.sun.fill")
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .padding()
            Image(systemName: "thermometer.medium")
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            Text("\(temp?.roundedToIntString() ?? "-")°").padding(8).foregroundColor(.white).frame(width: 50).bold()
        }
    }
}

struct WeatherHourlyItemView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHourlyItemView()
    }
}
