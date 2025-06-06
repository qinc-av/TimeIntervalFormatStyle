//
//  TimeInterval+ParseableFormatStyle.swift
//  TimeIntervalFormatStyle
//
//  Created by Sommer Panage on 3/4/22.
//

import Foundation

public extension TimeInterval {
    
    /// Get a formatted string from a format style
    /// - Parameter formatStyle: Time Interval Format Style
    /// - Returns: Formatted string
    func formatted(_ formatStyle: TimeIntervalFormatStyle) -> String {
        formatStyle.format(self)
    }
}

public extension FormatStyle where Self == TimeInterval.TimeIntervalFormatStyle {
    
    /// Format the given string as a time interval in the format 7:54:33.632 or similar
    /// - Parameter timeFormat: 
  static func timeInterval(timeFormat: TimeInterval.TimeFormat = .hour_min_sec ) -> TimeInterval.TimeIntervalFormatStyle {
        TimeInterval.TimeIntervalFormatStyle(timeFormat)
    }
  static func optionalTimeInterval(timeFormat: TimeInterval.TimeFormat = .hour_min_sec ) -> TimeInterval.OptionalTimeIntervalFormatStyle {
        TimeInterval.OptionalTimeIntervalFormatStyle(timeFormat)
    }
    
}
