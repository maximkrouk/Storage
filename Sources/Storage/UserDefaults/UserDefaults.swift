//
//  Storage+UserDefaults.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/5/19.
//

import Foundation

public typealias UserDefaults = Foundation.UserDefaults

extension UserDefaults {
    
    public typealias Provider = BaseStorageProvider
    
}


extension UserDefaults {
    
    /// Returns `UserDefaults.default.data` instance.
    public static var data: Provider<Data> { .init(storageManager: Manager.default) }
    
    /// Returns `UserDefaults.default.bool` instance.
    public static var bool: Provider<Bool> { .init(storageManager: Manager.default) }
    
    /// Returns `UserDefaults.default.string` instance.
    public static var string: Provider<String> { .init(storageManager: Manager.default) }
    
}
