//
//  HomeView+Extension.swift
//  life tracking
//
//  Created by Rodrigo Santos on 24/07/20.
//  Copyright © 2020 Rodrigo Santos. All rights reserved.
//

import SwiftUI
import CoreLocation

extension HomeView {
    func bindCovid() {
        BingDataService.shared.fetchReports { regions, _ in
            guard let regions = regions else {
                return
            }
            
            for region in regions {
                let pin = self.createMapPins(coordinate: region.location.clLocation, title: region.localizedLongName, subTitle: region.report?.stat.shortDescription ?? "", color: .orange, country: region)
                self.pins.append(pin)
            }
            
        }
    }
    
    
    func createMapPins(coordinate: CLLocationCoordinate2D, title: String, subTitle: String, color: UIColor, country: Region) -> MapPin  {
        let pin: MapPin = MapPin(
            coordinate: coordinate,
            title: title,
            subtitle: subTitle,
            action: {},
            color: color,
            country: country
        )
        return pin
    }
    
    func getUser() {
        self.isLoading = true
        store.getPersonById() { (person) in
            self.isLoading = false
            self.user = person
        }
    }
    
    
}

