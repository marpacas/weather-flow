//
//  WFForecastParser.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import Foundation


enum ForecastResult {
    case success(WFForecast)
    case error(String)
}


class WFForecastParser {
    
    var JSONObjectToParse: AnyObject?
    
    init(JSONObjectToParse: AnyObject) {
        self.JSONObjectToParse = JSONObjectToParse
        
    }
    
    
    func parseJSONObject() -> ForecastResult {
        if let JSONObject = self.JSONObjectToParse {
            let JSONDictionary = JSONObject as? [String: AnyObject]
            if let dictionary = JSONDictionary {
                let textDate = dictionary["dt_txt"] as? String
                let weatherObject = dictionary["weather"] as? [AnyObject]
                let firstObject = weatherObject?[0] as? [String: AnyObject]
                let description = firstObject?["description"] as? String
                let icon = firstObject?["icon"] as? String
                let iconURL = "\(Constants.WeatherMapAPI.iconBaseURL)\(icon!).png"
                
                let mainObject = dictionary["main"] as? [String: AnyObject]
                let temperature = mainObject?["temp"] as? Float
                let minTemperature = mainObject?["temp_min"] as? Float
                let maxTemperature = mainObject?["temp_max"] as? Float

                let humidity = mainObject?["humidity"] as? Int
                let weatherCondition = WFWeatherCondition(conditionDescription: description, humidity: humidity, temperature: temperature, iconURL: iconURL)
                 return .success(WFForecast(textDate: textDate, condition: weatherCondition, minTemperature: minTemperature, maxTemperature: maxTemperature))
            }
            else {
                return .error("JSON inválido")
            }
            
        }
        else {
            return .error("No hay datos")
        }
    }
    
}
