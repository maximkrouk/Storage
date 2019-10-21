//
//  String+BinaryConvertable.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/25/19.
//

import Foundation

extension String: BinaryConvertable {
    
    public init?(from data: Data) {
        guard let string = data.string(using: .utf8) else { return nil }
        self = string
    }
    
    public var data: Data { data(using: .utf8)! }
    
}
