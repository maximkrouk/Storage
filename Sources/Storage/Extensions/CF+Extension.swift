//
//  CFString+Extension.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/4/19.
//

import Foundation
import Security

public extension CFString {
    
    /// Returns self as String.
    var string: String { self as String }
    
}

public extension CFBoolean {
    
    /// Returns true if self is equal to kCFBooleanTrue, false otherwise.
    var bool: Bool { self == kCFBooleanTrue }
    
}

extension Bool {
    
    /// Returns kCFBooleanTrue or kCFBooleanFalse depending on self.
    var cfBoolean: CFBoolean { self ? kCFBooleanTrue : kCFBooleanFalse }
    
}
