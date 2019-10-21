//
//  BinaryConvertable.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/25/19.
//

import Foundation

public protocol BinaryConvertable {
    
    init?(from data: Data)
    
    var data: Data { get }
    
}

public typealias BinaryCodable = Codable & BinaryConvertable

extension BinaryConvertable where Self: Codable {
    
    public init?(from data: Data) {
        guard let value = data.decode(to: Self.self).value else { return nil }
        self = value
    }
    
    var data: Data { try! JSONEncoder().encode(self) }
    
}
