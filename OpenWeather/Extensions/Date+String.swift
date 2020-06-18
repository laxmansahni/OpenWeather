//
//  Date+String.swift
//  OpenWeather
//
//  Created by Laxman Sahni on 19/06/20.
//  Copyright © 2020 Laxman Sahni. All rights reserved.
//

import Foundation

extension String {
  
  // A handy method for %-encoding strings containing spaces and other
  // characters that need to be converted for use in URLs.
  var urlEncoded: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
  }
  
}
