//
//  WFCurrentWeatherAndCitiesViewController.swift
//  WeatherFlow
//
//  Created by Martha Castillo on 6/25/19.
//
//

import UIKit

fileprivate let showForecastForCity = "ShowForecastForCitySegue"

class WFCurrentWeatherAndCitiesViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var currentWeatherTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet var currentWeatherDataSource: WFCurrentWeatherTableViewDataSource!
    
    @IBOutlet var citiesDataSource: WFCitiesTableViewDataSource!
    
     var citiesList: Array = [WFCity(name: "",identification: 0,location: nil,country: "")]
    var selectedCity: WFCity = WFCity(name: "", identification: 0, location: nil, country: "");

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpCities()
        self.citiesDataSource.citiesList = self.citiesList
        self.citiesTableView.reloadData()
        self.registerWeatherCellNib()
        self.getCurrentWeather()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Defined functions

    private func setUpCities () {
        self.citiesList = [WFCity(name: "Paris", identification: 0,location: nil, country: "fr"), WFCity(name: "Madrid",identification: 0, location: nil, country: "es"),WFCity(name: "Nueva York", identification: 0, location: nil,country: "us"), WFCity(name: "Lima", identification: 0, location: nil, country: "pe"), WFCity(name: "Roma", identification: 0, location: nil,country: "it")]
        
    }
    
    private func registerWeatherCellNib() {
        let weatherNib = UINib.init(nibName: Constants.ForecastUI.weatherCellNib, bundle: nil)
        self.currentWeatherTableView.register(weatherNib, forCellReuseIdentifier: Constants.ForecastUI.weatherCellIdentifier)
    }

    func getCurrentWeather() {
        let currentWeatherService = WFCurrentWeatherService()
        self.activityIndicatorView.startAnimating()
        currentWeatherService.getCurrentWeather(forCity: "Buenos Aires") { (result) in
            DispatchQueue.main.async {
                self.processWeatherResult(result: result)
            }
        }
        
    }

    private func processWeatherResult(result: WeatherConditionResult) {
        self.activityIndicatorView.stopAnimating()
        switch result {
            
            case .error(let errorMessage):
                
                self.presentAlertError(errorMessage: errorMessage)

            case .success(let weatherCondition):
                
                self.currentWeatherDataSource.currentWeather = weatherCondition
                self.currentWeatherTableView.reloadData()
            }
    }

    private func presentAlertError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: "Ocurrió un error al procesar la informacion del pronóstico actual.\n\(errorMessage)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func forecastForCurrentLocationAction(_ sender: UIButton) {
        self.selectedCity = WFCity(name: "Buenos Aires", identification: 0, location: nil, country: "ar")
        self.performSegue(withIdentifier: showForecastForCity, sender: sender)
    }

    @IBAction func updateCurrentWeatherAction(_ sender: Any) {
        self.getCurrentWeather()

    }

    // MARK: - Cities table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCity = self.citiesList[indexPath.row]
        self.performSegue(withIdentifier: showForecastForCity, sender: tableView)

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let forecastViewController = segue.destination as! WFForecastViewController
        forecastViewController.city = self.selectedCity
    }
    

}
