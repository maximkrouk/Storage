//
//  Keychain+Error.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/4/19.
//

import Foundation

extension Keychain.Manager {
    
    struct Error: Swift.Error {
        let code: OSStatus?
        let customDescription: String? = .none
        var localizedDescription: String {
            guard let code = code else { return customDescription ?? "Unknown error" }
            return "Keychain error. OSStatus code: \(code)"
        }
    }
    
}
