//
//  WFForecastTableViewCell.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import UIKit

class WFForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var forecastDateLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var forecastConditionLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
