//
//  Data+BinaryConvertable.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/25/19.
//

import Foundation

extension Data: BinaryConvertable {
    
    public init?(from data: Data) { self = data }
    
    public var data: Data { self }
    
}
