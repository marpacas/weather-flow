//
//  WFConstants.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import Foundation

enum Constants {
    
    enum WeatherMapAPI {
        static let APIKey = "5b899ecd7c84be227adbc6aa4d0d334c"
        static let language = "es"
        static let units = "metric"
        static let baseURL = "http://api.openweathermap.org/data/2.5/"
        static let iconBaseURL = "http://openweathermap.org/img/w/"
    }
    
    enum ForecastUI {
        static let weatherCellIdentifier = "WeatherCellIdentifier"
        static let weatherCellNib = "WFWeatherTableViewCell"
        static let forecastCellIdentifier = "ForecastCellIdentifier"
        static let forecastCellNib = "WFForecastTableViewCell"

    }
    
    
}
