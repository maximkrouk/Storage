//
//  Storage+Keychain.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/4/19.
//

import Foundation
import Security

public struct Keychain {
    public typealias Provider = BaseStorageProvider
    
    /// Returns `Keychain.default.data` instance.
    public static var data: Provider<Data> { .init(storageManager: Manager.default) }
    
    /// Returns `Keychain.default.bool` instance.
    public static var bool: Provider<Bool> { .init(storageManager: Manager.default) }
    
    /// Returns `Keychain.default.string` instance.
    public static var string: Provider<String> { .init(storageManager: Manager.default) }
    
}
