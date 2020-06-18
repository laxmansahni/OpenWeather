//
//  ViewController.swift
//  OpenWeather
//
//  Created by Laxman Sahni on 18/06/20.
//  Copyright © 2020 Laxman Sahni. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherGetterDelegate, UITextFieldDelegate {

    var weather: WeatherGetter!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getCityWeatherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weather = WeatherGetter(delegate: self)
        // Initialize UI
        // -------------
        cityLabel.text = "simple weather"
        weatherLabel.text = ""
        minTempLabel.text = ""
        maxTempLabel.text = ""
        windLabel.text = ""
        cityTextField.text = ""
        cityTextField.placeholder = "Enter minimum 3 cities & max 7 cities in , separated"
        cityTextField.delegate = self
        cityTextField.enablesReturnKeyAutomatically = true
        getCityWeatherButton.isEnabled = false
    }

    // MARK: -
    
    // MARK: WeatherGetterDelegate methods
    // -----------------------------------
    
    func didGetWeather(weatherModel: WeatherModel) {
      // This method is called asynchronously, which means it won't execute in the main queue.
      // ALl UI code needs to execute in the main queue, which is why we're wrapping the code
      // that updates all the labels in a dispatch_async() call.
         DispatchQueue.main.async  {
            self.cityLabel.text = weatherModel.name
            self.weatherLabel.text = weatherModel.weather.first?.weatherDescription
            self.minTempLabel.text = "\(Int(round(weatherModel.main.tempMinCelsius)))°C"
             self.maxTempLabel.text = "\(Int(round(weatherModel.main.tempMaxCelsius)))°C"
            self.windLabel.text = "\(weatherModel.wind.speed) m/s"
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
    
    // Enable the "Get weather for the city above" button
     // if the city text field contains any text,
     // disable it otherwise.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(
            in: range,
            with: string)
        getCityWeatherButton.isEnabled = prospectiveText.count > 0
         print("Count: \(prospectiveText.count)")
        return true
    }
    // Pressing the clear button on the text field (the x-in-a-circle button
     // on the right side of the field)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
           // Even though pressing the clear button clears the text field,
         // this line is necessary. I'll explain in a later blog post.
         textField.text = ""
         
        getCityWeatherButton.isEnabled = false
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
      
    }



