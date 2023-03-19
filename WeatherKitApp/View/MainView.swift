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
                if let _ = locationManager.location {
                    HomeView().environmentObject(locationManager)
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

extension View {
    func errorAlert(error: ErrorType?, buttonTitle: String = "Ok", recoveryButtonTitle: String = "Retry", recovery: @escaping () -> Void) -> some View {
        return alert(error?.errorTitle ?? "", isPresented: .constant(error != nil)) {
            Button(buttonTitle) {
            }
            Button(recoveryButtonTitle) {
                recovery()
            }

        } message: {
            Text(error?.errorMessage ?? "")
        }

//        return alert(isPresented: true, error: <#_?#>) { _ in
//            Button(error.errorTitle) {
//
//            }
//        } message: { error in
//            Text(error.recoverySuggestion ?? "")
//        }
    }
}
