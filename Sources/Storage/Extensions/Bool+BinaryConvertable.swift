//
//  Bool+BinaryConvertable.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/25/19.
//

import Foundation

extension Bool: BinaryConvertable {
    
    public init?(from data: Data) {
        guard let value = data.first else { return nil }
        self = value != 0
    }
    
    /// Returns data, initialized with [0] if self is false, or with [1] otherwise.
    public var data: Data { Data([self ? 1 : 0]) }
    
}
