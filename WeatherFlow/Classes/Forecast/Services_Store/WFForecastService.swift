//
//  WFForecastService.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import Foundation
import AwesomeCache

fileprivate let forecastCacheKey = "ForecastCacheKey"

class WFForecastService {
    
    func getForecast(forCity city: String, inCountry country: String, completionHandler: @escaping (ForecastListResult) -> Void) {
        
        
        let weatherMapURLComponents = self.setUpURLComponents(forCity: city, inCountry: country)
        
        let forecastTask = URLSession.shared.dataTask(with: weatherMapURLComponents.url!) { data, response, error in
            if let taskError = error {
                completionHandler(.error(taskError.localizedDescription))
            }
            else {
                if let taskData = data {
                    let JSONObject = try? JSONSerialization.jsonObject(with: taskData, options: [])
                    if let JSONDictionary = JSONObject as? [String: AnyObject] {
                            let list = JSONDictionary ["list"] as?  [AnyObject]
                            let forecastListParser = WFForecastListParser(JSONObjectToParse: list as AnyObject)
                            completionHandler(forecastListParser.parseJSONObject())
                    }
                    else {
                        completionHandler(.error("No se recibieron datos"))
                       
                    }
                    
                }
                else {
                    completionHandler(.error("No se recibieron datos"))
                    
                }
            }
        }
        forecastTask.resume()
        return
    }
    
    private func setUpURLComponents(forCity city: String, inCountry country: String) -> URLComponents {
        
        var weatherMapURLComponents = URLComponents(string: "\(Constants.WeatherMapAPI.baseURL)/forecast")!
        let queryItems = [URLQueryItem(name: "appid", value: Constants.WeatherMapAPI.APIKey), URLQueryItem(name: "units", value: Constants.WeatherMapAPI.units), URLQueryItem(name: "language", value: Constants.WeatherMapAPI.language), URLQueryItem(name: "q", value:"\(city),\(country)")]
        weatherMapURLComponents.queryItems = queryItems
        return weatherMapURLComponents
        
    }
    
}
