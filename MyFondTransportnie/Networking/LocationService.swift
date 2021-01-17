//
//  LocationService.swift
//  MyFondTransportnie
//
//  Created by Mac on 08.01.2021.
//

import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
    }
}
