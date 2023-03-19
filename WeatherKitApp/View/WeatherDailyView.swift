//
//  WeatherDailyView.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import SwiftUI

struct WeatherDailyView: View {
    var weekDay: String?
    var iconName: String?
    var tempHigh: Double?
    var tempLow: Double?
    
    var body: some View {
        HStack {
            Text(weekDay ?? "").foregroundColor(.white).bold()
            Spacer()
            Image(systemName: iconName ?? "cloud.sun.fill")
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .padding()
            Text("L:\(tempLow?.roundedToIntString() ?? "-")°").padding(8).foregroundColor(.white).frame(width: 80).bold()
            Text("H:\(tempHigh?.roundedToIntString() ?? "-")°").padding(8).foregroundColor(.white).frame(width: 80).bold()
        }
    }
}

struct WeatherDailyView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDailyView()
    }
}
