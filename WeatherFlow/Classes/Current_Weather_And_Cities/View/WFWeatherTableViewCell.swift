//
//  WFWeatherTableViewCell.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import UIKit

class WFWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var conditionImageview: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
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
