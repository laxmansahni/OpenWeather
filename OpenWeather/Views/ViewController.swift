//
//  ViewController.swift
//  OpenWeather
//
//  Created by Laxman Sahni on 18/06/20.
//  Copyright © 2020 Laxman Sahni. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, WeatherGetterDelegate, UITextFieldDelegate {

    var weather: WeatherGetter!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getCityWeatherButton: UIButton!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var getCurrentLocationButton: UIButton!
    // static labels
    @IBOutlet weak var latitudeStaticLabel: UILabel!
    @IBOutlet weak var longitudeStaticLabel: UILabel!
    @IBOutlet weak var windStaticLabel: UILabel!
    @IBOutlet weak var minTempStaticLabel: UILabel!
    @IBOutlet weak var maxTempStaticLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weather = WeatherGetter(delegate: self)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // after showing the permission dialog, the program will continue executing the next line before the user has tap 'Allow' or 'Disallow'
        
        // Initialize UI
        // -------------
        cityLabel.text = ""
        weatherLabel.text = ""
        minTempLabel.text = ""
        maxTempLabel.text = ""
        windLabel.text = ""
        latitudeLabel.text = ""
        longitudeLabel.text = ""
        cityTextField.text = ""
        cityTextField.placeholder = "Enter minimum 3 cities & max 7 cities in , separated"
        cityTextField.delegate = self
        cityTextField.enablesReturnKeyAutomatically = true
        getCityWeatherButton.isEnabled = false
        
        hideStaticLabels(isHidden: true)
    }

    // MARK: -
    
    // MARK: WeatherGetterDelegate methods
    // -----------------------------------
    
    func didGetWeather(weatherModel: WeatherModel) {
      // This method is called asynchronously, which means it won't execute in the main queue.
      // ALl UI code needs to execute in the main queue, which is why we're wrapping the code
      // that updates all the labels in a dispatch_async() call.
         DispatchQueue.main.async  {
            self.hideStaticLabels(isHidden: false)
            self.getCurrentLocationButton.isEnabled = true
            self.cityLabel.text = weatherModel.name
            self.latitudeLabel.text = "\(weatherModel.coord.lat)"
            self.longitudeLabel.text = "\(weatherModel.coord.lon)"
            self.weatherLabel.text = weatherModel.weather.first?.weatherDescription
            self.minTempLabel.text = "\(Int(round(weatherModel.main.tempMinCelsius)))°C"
             self.maxTempLabel.text = "\(Int(round(weatherModel.main.tempMaxCelsius)))°C"
            self.windLabel.text = "\(weatherModel.wind.speed) m/s"
      }
    }

    func didGetForecast(forecastModel: ForecastModel) {
      // This method is called asynchronously, which means it won't execute in the main queue.
      // ALl UI code needs to execute in the main queue, which is why we're wrapping the code
      // that updates all the labels in a dispatch_async() call.
         DispatchQueue.main.async  {
            self.hideStaticLabels(isHidden: false)
            self.getCurrentLocationButton.isEnabled = true
            self.cityLabel.text = forecastModel.city.name
            self.latitudeLabel.text = "\(forecastModel.city.coord.lat)"
            self.longitudeLabel.text = "\(forecastModel.city.coord.lon)"
            self.weatherLabel.text = forecastModel.list.first?.weather.first?.weatherDescription.rawValue
            self.minTempLabel.text = "\(Int(round((forecastModel.list.first?.main.tempMinCelsius)!)))°C"
            self.maxTempLabel.text = "\(Int(round((forecastModel.list.first?.main.tempMaxCelsius)!)))°C"
            self.windLabel.text = "\(forecastModel.list.first?.wind.speed ?? 0.0) m/s"
      }
    }
    
    func didNotGetWeather(error: Error) {
      // This method is called asynchronously, which means it won't execute in the main queue.
      // ALl UI code needs to execute in the main queue, which is why we're wrapping the call
      // to showSimpleAlert(title:message:) in a dispatch_async() call.
       DispatchQueue.main.async  {
        self.showSimpleAlert(title: "Can't get the weather",
                             message: "The weather service isn't responding.")
      }
      print("didNotGetWeather error: \(error)")
    }
    
    // MARK: - Button events
     // ---------------------
    @IBAction func getWeatherClicked(_ sender: Any) {
        guard let text = cityTextField.text, !text.isEmpty else {
             return
           }
        let cities = cityTextField.text?.split(separator: ",")
        if cities!.count >= 3 && cities!.count < 7 {
            weather.getWeatherByCity(city: (String((cities?.first)!).urlEncoded))
        }
        else {
            self.showSimpleAlert(title: "Not enough cities", message: "Required number of cities is missing")
        }
            
    }
    
    // when user tap on a button to get location
    @IBAction func getCurrentLocationClicked(_ sender: Any) {
        cityTextField.text = ""
        getCityWeatherButton.isEnabled = false
        retriveCurrentLocation()
    }
    
    func retriveCurrentLocation(){
        let status = CLLocationManager.authorizationStatus()

        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            // show alert to user telling them they need to allow location data to use some feature of your app
            return
        }

        // if haven't show location permission dialog before, show it to user
        if(status == .notDetermined){
            locationManager.requestWhenInUseAuthorization()

            // if you want the app to retrieve location data even in background, use requestAlwaysAuthorization
            // locationManager.requestAlwaysAuthorization()
            return
        }
        
        // at this point the authorization status is authorized
        // request location data once
        locationManager.requestLocation()
      
    }
    
    // Enable the "Get weather for the city above" button
     // if the city text field contains any text,
     // disable it otherwise.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(
            in: range,
            with: string)
        getCityWeatherButton.isEnabled = prospectiveText.count > 0
        getCurrentLocationButton.isEnabled = !getCityWeatherButton.isEnabled
        return true
    }
    // Pressing the clear button on the text field (the x-in-a-circle button
     // on the right side of the field)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
           // Even though pressing the clear button clears the text field,
         // this line is necessary. I'll explain in a later blog post.
         textField.text = ""
         
        getCityWeatherButton.isEnabled = false
        getCurrentLocationButton.isEnabled = true
         return true
    }
    
    // Pressing the return button on the keyboard should be like
    // pressing the "Get weather for the city above" button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getWeatherClicked(getCityWeatherButton as Any)
        return true
    }
      // MARK: - Utility methods
      // -----------------------

    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(
          title: title,
          message: message,
          preferredStyle: .alert
        )
        let okAction = UIAlertAction(
          title: "OK",
          style:  .default,
          handler: nil
        )
        alert.addAction(okAction)
        present(
          alert,
          animated: true,
          completion: nil
        )
      }
    
    func hideStaticLabels(isHidden: Bool)  {
        latitudeStaticLabel.isHidden = isHidden
        longitudeStaticLabel.isHidden = isHidden
        windStaticLabel.isHidden = isHidden
        minTempStaticLabel.isHidden = isHidden
        maxTempStaticLabel.isHidden = isHidden
    }
      
    }

extension ViewController: CLLocationManagerDelegate {
  // handle delegate methods of location manager here
    // called when the authorization status is changed for the core location permission
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           print("location manager authorization status changed")
           
           switch status {
           case .authorizedAlways:
               print("user allow app to get location data when app is active or in background")
           case .authorizedWhenInUse:
               print("user allow app to get location data only when app is active")
           case .denied:
               print("user tap 'disallow' on the permission dialog, cant get location data")
           case .restricted:
               print("parental control setting disallow location data")
           case .notDetermined:
               print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
           @unknown default:
            print("the location permission isn't valid")
        }
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let location = locations.first {
            weather.getForecastByLatLon(lat: "\(location.coordinate.latitude)", lon: "\(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // might be that user didn't enable location service on the device
        // or there might be no GPS signal inside a building
      
        // might be a good idea to show an alert to user to ask them to walk to a place with GPS signal
    }
}

