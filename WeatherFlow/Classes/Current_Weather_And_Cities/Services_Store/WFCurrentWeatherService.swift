//
//  WFCurrentWeatherService.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import Foundation
import AwesomeCache

fileprivate let weatherCacheKey = "WeatherCacheKey"
fileprivate let cachedWeatherKey = "cachedWeatherKey"


class WFCurrentWeatherService {
    
    func getCurrentWeather(forCity city: String, completionHandler: @escaping (WeatherConditionResult) -> Void) {        
        
        let weatherMapURLComponents = self.setUpURLComponents(forCity: city)
        
        let currentWeatherTask = URLSession.shared.dataTask(with: weatherMapURLComponents.url!) { data, response, error in
            if let taskError = error {
                completionHandler(.error(taskError.localizedDescription))
            }
            else {
                if let taskData = data {
                    let JSONObject = try? JSONSerialization.jsonObject(with: taskData, options: [])
                    let currentWetherParser = WFWeatherConditionParser(JSONObjectToParse: JSONObject as AnyObject)
                    completionHandler(currentWetherParser.parseJSONObject())

                }
                else {
                    completionHandler(.error("No se recibieron datos"))

                }
            }
        }
        currentWeatherTask.resume()
        return
    }
    
    private func setUpURLComponents(forCity city: String) -> URLComponents {
        
        var weatherMapURLComponents = URLComponents(string: "\(Constants.WeatherMapAPI.baseURL)/weather")!
        let queryItems = [URLQueryItem(name: "appid", value: Constants.WeatherMapAPI.APIKey), URLQueryItem(name: "units", value: Constants.WeatherMapAPI.units), URLQueryItem(name: "language", value: Constants.WeatherMapAPI.language), URLQueryItem(name: "q", value: city)]
        weatherMapURLComponents.queryItems = queryItems
        return weatherMapURLComponents

    }
    
}
