//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Foundation

public extension Int {
  func minutesToHoursAndMinutes() -> String {
    let hours = self / 60
    let minutes = self % 60
    let formattedString = String(format: "%dh %02dm", hours, minutes)
    return formattedString
  }
}
