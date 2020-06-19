//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Laxman Sahni on 18/06/20.
//  Copyright © 2020 Laxman Sahni. All rights reserved.
//

import XCTest
@testable import OpenWeather

class OpenWeatherTests: XCTestCase {
    var sut: URLSession!
    var weather: WeatherGetter!
    var view: ViewController!
    var weatherModel: WeatherModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = URLSession(configuration: .default)
        view = ViewController()
        weather = WeatherGetter(delegate: view)
        if let localData = self.readLocalFile(forName: "weather") {
            weatherModel = try? JSONDecoder().decode(WeatherModel.self, from: localData)
        }
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        weather = nil
        view = nil
    }

    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    
    func testTempMinIsComputed() {
      // 3. then
        XCTAssertEqual(weatherModel.main.tempMinCelsius, 15, "Score computed from guess is wrong")
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToOpenWeatherMapGetsHTTPStatusCode200() {
      // given
    let weatherURL = URL(string: "\(weather.openWeatherMapBaseURL)?APPID=\(weather.openWeatherMapAPIKey)&q=London")!
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
        let dataTask = sut.dataTask(with: weatherURL) { data, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }
}
