//
//  EasyTimerTimeInterval.swift
//  EasyTimerTimeInterval
//
//  Created by Niklas Fahl on 3/2/16.
//  Copyright © 2016 Niklas Fahl. All rights reserved.
//

import Foundation

// Powered by Swifty Timer Extension - radex
extension Double {
    public var millisecond: TimeInterval  { return self / 1000 }
    public var second: TimeInterval       { return self }
    public var minute: TimeInterval       { return self * 60 }
    public var hour: TimeInterval         { return self * 3600 }
    public var day: TimeInterval          { return self * 3600 * 24 }
}

extension Int {
    public var millisecond: TimeInterval  { return Double(self) / 1000 }
    public var second: TimeInterval       { return Double(self) }
    public var minute: TimeInterval       { return Double(self) * 60 }
    public var hour: TimeInterval         { return Double(self) * 3600 }
    public var day: TimeInterval          { return Double(self) * 3600 * 24 }
}
