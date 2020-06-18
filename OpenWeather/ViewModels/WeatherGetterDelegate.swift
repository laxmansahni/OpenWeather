//
//  WeatherGetterDelegate.swift
//  OpenWeather
//
//  Created by Laxman Sahni on 18/06/20.
//  Copyright © 2020 Laxman Sahni. All rights reserved.
//

import Foundation

// ===========================
// WeatherGetter should be used by a class or struct, and that class or struct
// should adopt this protocol and register itself as the delegate.
// The delegate's didGetWeather method is called if the weather data was
// acquired from OpenWeatherMap.org and successfully converted from JSON into
// a Swift dictionary.
// The delegate's didNotGetWeather method is called if either:
// - The weather was not acquired from OpenWeatherMap.org, or
// - The received weather data could not be converted from JSON into a dictionary.
protocol WeatherGetterDelegate {
  func didGetWeather(weatherModel: WeatherModel)
  func didNotGetWeather(error: Error)
}
