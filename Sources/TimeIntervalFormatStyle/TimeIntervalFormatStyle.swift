//
//  TimeIntervalFormatStyle.swift
//  TimeIntervalFormatStyle
//
//  Created by Sommer Panage on 3/6/22.
//

import Foundation

public extension TimeInterval {
    struct TimeIntervalFormatStyle {
        
        private var showMilliseconds: Bool = false
        
        /// Constructer to allow extensions to set formatting
        /// - Parameter showMilliseconds: Shows millieconds. Ex: 1:03:44:789 . Default == `false`
        init(_ showMilliseconds: Bool) {
            self.showMilliseconds = showMilliseconds
        }
    }

    struct OptionalTimeIntervalFormatStyle {

        private var showMilliseconds: Bool = false

        /// Constructer to allow extensions to set formatting
        /// - Parameter showMilliseconds: Shows millieconds. Ex: 1:03:44:789 . Default == `false`
        init(_ showMilliseconds: Bool) {
            self.showMilliseconds = showMilliseconds
        }
    }
}

extension TimeInterval.TimeIntervalFormatStyle: ParseableFormatStyle {
    /// A `ParseStrategy` that can be used to parse this `FormatStyle`'s output
    public var parseStrategy: TimeIntervalParseStrategy {
        return TimeIntervalParseStrategy()
    }
    public func format(_ value: TimeInterval) -> String {
      return TimeInterval.OptionalTimeIntervalFormatStyle.format_ti(value, showMilliseconds)
    }
}

extension TimeInterval.OptionalTimeIntervalFormatStyle: ParseableFormatStyle {

    /// A `ParseStrategy` that can be used to parse this `FormatStyle`'s output
    public var parseStrategy: OptionalTimeIntervalParseStrategy {
        return OptionalTimeIntervalParseStrategy()
    }
    
    /// Returns a string based on an input time interval. String format may include milliseconds or not
    /// Example: "2:33:29.632" aka 2 hours, 33 minutes, 29.632 seconds
    static public func format_ti(_ value: TimeInterval, _ showMilliseconds:Bool) -> String {
      let sign = (value<0) ? "-" : ""
      let val = abs(value)
      let hour = Int((val / TimeInterval.secondsPerHour).rounded(.towardZero))
      let minute = Int((val / TimeInterval.secondsPerMinute).truncatingRemainder(dividingBy: TimeInterval.minutesPerHour))
      let second = Int(val.truncatingRemainder(dividingBy: TimeInterval.secondsPerMinute))
      if showMilliseconds {
        let millisecond = Int((val * TimeInterval.millisecondsPerSecond).truncatingRemainder(dividingBy: TimeInterval.millisecondsPerSecond))
        return String(format:"%@%d:%02d:%02d.%03d", sign, hour, minute, second, millisecond) // ex: 10:04:09.689
      } else {
        return String(format:"%@%d:%02d:%02d", sign, hour, minute, second) // ex: 10:04:09
      }
    }
    public func format(_ value: TimeInterval?) -> String {
      if (value != nil) {
        return Double.OptionalTimeIntervalFormatStyle.format_ti(value!, showMilliseconds)
      } else {
        return ""
      }
    }
}
