//
//  WeatherGetter.swift
//  OpenWeather
//
//  Created by Laxman Sahni on 18/06/20.
//  Copyright © 2020 Laxman Sahni. All rights reserved.
//



import Foundation
 
class WeatherGetter {
  
  let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"
  let openWeatherMapAPIKey = "1c50a96eb009b91d632a5ff85081ba95"
  let openWeatherMapForecastBaseURL = "https://api.openweathermap.org/data/2.5/forecast"
    
  private var delegate: WeatherGetterDelegate
  // MARK: -
  init(delegate: WeatherGetterDelegate) {
       self.delegate = delegate
     }
    func getWeatherByCity(city: String) {
      let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        getWeather(weatherRequestURL: weatherRequestURL)
    }
    
    func getWeatherByLatLon(lat: String, lon: String) {
      let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&lat=\(lat)&lon=\(lon)")!
        getWeather(weatherRequestURL: weatherRequestURL)
    }
    
    func getForecastByLatLon(lat: String, lon: String) {
      let forecastRequestURL = NSURL(string: "\(openWeatherMapForecastBaseURL)?APPID=\(openWeatherMapAPIKey)&lat=\(lat)&lon=\(lon)")!
        getForecast(forecastRequestURL: forecastRequestURL)
    }
    
  private func getWeather(weatherRequestURL: NSURL) {
    
    // This is a pretty simple networking task, so the shared session will do.
    let session = URLSession.shared
    let request = NSMutableURLRequest(url: weatherRequestURL as URL)
    // The data task retrieves the data.
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        // We got some kind of error while trying to get data from the se
        self.delegate.didNotGetWeather(error: error!)
      } else {
        // We got a response from the server!
        let weatherModel = try? JSONDecoder().decode(WeatherModel.self, from: data!)
        self.delegate.didGetWeather(weatherModel: weatherModel!)
      }
    })
    
    // The data task is set up...launch it!
    dataTask.resume()
  }
  
    private func getForecast(forecastRequestURL: NSURL) {
       
       // This is a pretty simple networking task, so the shared session will do.
       let session = URLSession.shared
       let request = NSMutableURLRequest(url: forecastRequestURL as URL)
       // The data task retrieves the data.
       let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
         if (error != nil) {
           // We got some kind of error while trying to get data from the se
           self.delegate.didNotGetWeather(error: error!)
         } else {
           // We got a response from the server!
           let forecastModel = try? JSONDecoder().decode(ForecastModel.self, from: data!)
           self.delegate.didGetForecast(forecastModel: forecastModel!)
         }
       })
       
       // The data task is set up...launch it!
       dataTask.resume()
     }
}
