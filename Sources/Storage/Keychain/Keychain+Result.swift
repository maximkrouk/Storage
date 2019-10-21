//
//  Keychain+Result.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/4/19.
//

import Convenience
import Foundation
import Security

public extension Keychain.Manager {
    
    struct Result {
        /// Result code. Equal to noErr (0) if operation succeed.
        public var code: OSStatus
        
        /// Creates a new instance.
        ///
        /// - Parameter code: Result code, noErr (0) by default.
        public init(code: OSStatus = noErr) {
            self.code = code
        }
        
        public var isSuccess: Bool { code == noErr }
        public var result: Convenience.Result<Void> {
            isSuccess ?
                .success(()) :
                .failure(Storage.Keychain.Manager.Error(code: code))
        }
    }
    
}

