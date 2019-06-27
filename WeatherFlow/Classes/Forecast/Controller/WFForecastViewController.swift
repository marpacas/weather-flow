//
//  WFForecastViewController.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import UIKit

class WFForecastViewController: UIViewController {

    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

     @IBOutlet var forecastDataSource: WFForecastTableViewDataSource!

    var forecastForCity: Array<WFForecast> = [WFForecast()]
    
    var city = WFCity(name: "", identification: 0, location: nil, country: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = self.city.name;
        self.registerForecastCellNib()
        let forecastService = WFForecastService()
        self.activityIndicatorView.startAnimating()
        forecastService.getForecast(forCity: self.city.name, inCountry: self.city.country) { (forecastResult) in
            DispatchQueue.main.async {
                self.processForecastResult(forecastResult: forecastResult)
            }
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Defined functions
    
    private func registerForecastCellNib() {
        let forecastNib = UINib.init(nibName: Constants.ForecastUI.forecastCellNib, bundle: nil)
        self.forecastTableView.register(forecastNib, forCellReuseIdentifier: Constants.ForecastUI.forecastCellIdentifier)
    }

    private func processForecastResult(forecastResult: ForecastListResult) {
        
        self.activityIndicatorView.stopAnimating()
        switch forecastResult {
            
        case .error(let errorMessage):
            
            self.presentAlertError(errorMessage: errorMessage)
            
        case .success(let forecastForCity):
            
            self.forecastDataSource.forecastForCity = forecastForCity
            self.forecastTableView.reloadData()
        }
    }
    
    private func presentAlertError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: "Ocurrió un error al procesar la informacion del pronóstico para \(self.city.name).\n\(errorMessage)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}
