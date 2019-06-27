//
//  WFForecastListParser.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import Foundation

enum ForecastListResult {
    case success(Array<WFForecast>)
    case error(String)
}

class WFForecastListParser {
    
    var JSONObjectToParse: AnyObject?
    
    init(JSONObjectToParse: AnyObject) {
        self.JSONObjectToParse = JSONObjectToParse
        
    }
    
    
    func parseJSONObject() -> ForecastListResult {
        if let JSONObject = self.JSONObjectToParse {
            let JSONArray = JSONObject as? [AnyObject]
             if let forecastArray = JSONArray {
                var forecastToFill = Array<WFForecast>()
                for  element in forecastArray {
                    let forecastParser = WFForecastParser(JSONObjectToParse: element as AnyObject)
                    let forecastResult = forecastParser.parseJSONObject()
                    switch forecastResult {
                        
                        case .error(let errorMessage):
                            return .error("JSON inválido \(errorMessage)")
                            
                        case .success(let forecast):
                            forecastToFill.append(forecast)
                        
                    }
 
                }
                return .success(forecastToFill)
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
