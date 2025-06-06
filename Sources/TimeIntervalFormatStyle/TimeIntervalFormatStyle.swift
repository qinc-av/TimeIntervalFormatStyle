//
//  TimeIntervalFormatStyle.swift
//  TimeIntervalFormatStyle
//
//  Created by Sommer Panage on 3/6/22.
//

import Foundation

public extension TimeInterval {
  enum TimeFormat : Codable {
    case hour_min_sec
    case min_sec
    case hour_min_sec_ms
    case min_sec_ms
  }

  struct TimeIntervalFormatStyle {
    private var timeFormat: TimeInterval.TimeFormat = .hour_min_sec
      /// Constructer to allow extensions to set formatting
      /// - Parameter showMilliseconds: Shows millieconds. Ex: 1:03:44:789 . Default == `false`
    init(_ format: TimeInterval.TimeFormat) {
          self.timeFormat = format
        }
    }

    struct OptionalTimeIntervalFormatStyle {
      private var timeFormat: TimeInterval.TimeFormat = .hour_min_sec
      /// Constructer to allow extensions to set formatting
      /// - Parameter showMilliseconds: Shows millieconds. Ex: 1:03:44:789 . Default == `false`
      init(_ format: TimeInterval.TimeFormat) {
        self.timeFormat = format
      }
    }
}

extension TimeInterval.TimeIntervalFormatStyle: ParseableFormatStyle {
    /// A `ParseStrategy` that can be used to parse this `FormatStyle`'s output
    public var parseStrategy: TimeIntervalParseStrategy {
        return TimeIntervalParseStrategy()
    }
    public func format(_ value: TimeInterval) -> String {
      return TimeInterval.OptionalTimeIntervalFormatStyle.format_ti(value, timeFormat)
    }
}

extension TimeInterval.OptionalTimeIntervalFormatStyle: ParseableFormatStyle {

    /// A `ParseStrategy` that can be used to parse this `FormatStyle`'s output
    public var parseStrategy: OptionalTimeIntervalParseStrategy {
        return OptionalTimeIntervalParseStrategy()
    }
    
    /// Returns a string based on an input time interval. String format may include milliseconds or not
    /// Example: "2:33:29.632" aka 2 hours, 33 minutes, 29.632 seconds
    static public func format_ti(_ value: TimeInterval, _ timeFormat:TimeInterval.TimeFormat) -> String {
      let sign = (value<0) ? "-" : ""
      let val = abs(value)
      let hour = Int((val / TimeInterval.secondsPerHour).rounded(.towardZero))
      let h_minute = Int((val / TimeInterval.secondsPerMinute).truncatingRemainder(dividingBy: TimeInterval.minutesPerHour))
      let t_minute = Int((val / TimeInterval.secondsPerMinute))
      let second = Int(val.truncatingRemainder(dividingBy: TimeInterval.secondsPerMinute))
      switch timeFormat {
      case .hour_min_sec:
        return String(format:"%@%d:%02d:%02d", sign, hour, h_minute, second) // ex: 10:04:09
        break;

      case .min_sec:
        return String(format:"%@%02d:%02d", sign, t_minute, second) // ex: 10:04:09
        break;

      case .hour_min_sec_ms:
        let millisecond = Int((val * TimeInterval.millisecondsPerSecond).truncatingRemainder(dividingBy: TimeInterval.millisecondsPerSecond))
        return String(format:"%@%d:%02d:%02d.%03d", sign, hour, h_minute, second, millisecond) // ex: 10:04:09.689

      case .min_sec_ms:
        let millisecond = Int((val * TimeInterval.millisecondsPerSecond).truncatingRemainder(dividingBy: TimeInterval.millisecondsPerSecond))
        return String(format:"%@%02d:%02d.%03d", sign, t_minute, second, millisecond) // ex: 10:04:09.689
      }
    }

    public func format(_ value: TimeInterval?) -> String {
      if (value != nil) {
        return Double.OptionalTimeIntervalFormatStyle.format_ti(value!, timeFormat)
      } else {
        return ""
      }
    }
}
