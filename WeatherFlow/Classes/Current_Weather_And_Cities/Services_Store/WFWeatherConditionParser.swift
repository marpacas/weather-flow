//
//  WFWeatherConditionParser.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import Foundation


enum WeatherConditionResult {
    case success(WFWeatherCondition)
    case error(String)
}

class WFWeatherConditionParser {
    
    var JSONObjectToParse: AnyObject?

    init(JSONObjectToParse: AnyObject) {
        self.JSONObjectToParse = JSONObjectToParse
        
    }
    
    
    func parseJSONObject() -> WeatherConditionResult {
        if let JSONObject = self.JSONObjectToParse {
            let JSONDictionary = JSONObject as? [String: AnyObject]
            if let dictionary: [String: AnyObject] = JSONDictionary {
                let code = dictionary ["cod"] as? Int
                if (code == 200) {
                    let weatherObject = dictionary["weather"] as? [AnyObject]
                    let firstObject = weatherObject?[0] as? [String: AnyObject]
                    let description = firstObject?["description"] as? String
                    let icon = firstObject?["icon"] as? String
                    let iconURL = "\(Constants.WeatherMapAPI.iconBaseURL)\(icon!).png"

                    let mainObject = dictionary["main"] 
                    let temperature = mainObject?["temp"] as? Float
                    let humidity = mainObject?["humidity"] as? Int
                    return .success(WFWeatherCondition(conditionDescription: description!, humidity: humidity!, temperature: temperature!, iconURL: iconURL))
                }
                else {
                    let message = dictionary ["message"] as? String
                    if let errorMessage = message {
                        return .error(errorMessage)
                    }
                    else {
                        return .error("JSON inválido")
                    }
                }
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
