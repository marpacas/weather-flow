//
//  WFForecastTableViewDataSource.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import UIKit
import SDWebImage

class WFForecastTableViewDataSource : NSObject,UITableViewDataSource {
    
    var forecastForCity: Array<WFForecast> = []
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastForCity.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ForecastUI.forecastCellIdentifier, for: indexPath) as! WFForecastTableViewCell
        
        let forecast = self.forecastForCity[indexPath.row]
        
        cell.forecastDateLabel.text = forecast.textDate!
        cell.forecastConditionLabel.text = forecast.condition?.conditionDescription!.capitalized
        let minFormattedTemperature = String(format: "%.0f %@",forecast.minTemperature!, "ºC")
        cell.minimumTemperatureLabel.text = minFormattedTemperature
        let maxFormattedTemperature = String(format: "%.0f %@",forecast.maxTemperature!, "ºC")
        cell.maximumTemperatureLabel.text = maxFormattedTemperature
        if let iconURL = forecast.condition!.iconURL {
            cell.forecastImageView.sd_setImage(with: URL(string:iconURL), placeholderImage:nil)
        }

 //       cell.humidityLabel.text = "\(self.currentWeather.humidity!) %"
        
        
        return cell
    }
}
