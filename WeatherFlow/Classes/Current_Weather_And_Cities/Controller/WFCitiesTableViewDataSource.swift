//
//  WFCitiesTableViewDataSource.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import UIKit


class WFCitiesTableViewDataSource : NSObject,UITableViewDataSource {
    
    var citiesList: Array<WFCity>
    
    init(citiesList: Array<WFCity>) {
        self.citiesList = citiesList
        super.init()
        
    }

    convenience override init() {
        self.init(citiesList:[WFCity(name: "", identification: 0, location: nil, country: "")])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCellIdentifier", for: indexPath)
        
        
        cell.textLabel?.text = citiesList[indexPath.row].name;
        
        return cell
    }
}
