//
//  MainView.swift
//  WeatherKitApp
//
//  Created by GJ376GXGQ0 on 19/03/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var locationManager = LocationManager()
    var body: some View {
        ZStack {
            VStack {
                if let location = locationManager.location {
                    Text("\(location.latitude) \(location.longitude)")
                } else {
                    if locationManager.isLocationServiceApproved {
                        LoadingView()
                    } else {
                        WelcomeView().environmentObject(locationManager)
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
