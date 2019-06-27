//
//  WFCurrentWeatherTableViewDataSource.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import UIKit
import SDWebImage

class WFCurrentWeatherTableViewDataSource : NSObject,UITableViewDataSource {
    
    var currentWeather = WFWeatherCondition(conditionDescription: "", humidity: 0, temperature:0.0, iconURL: "")
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ForecastUI.weatherCellIdentifier, for: indexPath) as! WFWeatherTableViewCell
        
        cell.conditionLabel.text = self.currentWeather.conditionDescription!.capitalized
        let formattedTemperature = String(format: "%.0f %@",self.currentWeather.temperature!, "ºC")
        cell.temperatureLabel.text = formattedTemperature
        cell.humidityLabel.text = "\(self.currentWeather.humidity!) %"
        if let iconURL = self.currentWeather.iconURL {
            cell.conditionImageview.sd_setImage(with: URL(string:iconURL), placeholderImage:nil)
        }
        
        return cell
    }
}
