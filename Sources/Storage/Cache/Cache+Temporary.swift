//
//  Cache+Temporary.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/5/19.
//

import Convenience
import Foundation

public extension Cache {
    
    final class Temporary: StorageManager {
        private let storage = NSCache<NSString, Item>()
        
        public func data<Key: Hashable>(forKey key: Key) -> Result<Data> {
            guard let data = storage.object(forKey: key.hashValue.string.nsString)?.content else {
                return .failure(PlainError("No data found for key: [\(key)]"))
            }
            return .success(data)
        }
                
        public func save<Key: Hashable>(data: Data, forKey key: Key) -> Result<Void> {
            storage.setObject(.init(content: data), forKey: key.hashValue.string.nsString)
            return .success(())
        }
                
        public func delete<Key: Hashable>(key: Key) -> Result<Void> {
            storage.removeObject(forKey: key.hashValue.string.nsString)
            return .success(())
        }
        
        public func clear() -> Result<Void> {
            storage.removeAllObjects()
            return .success(())
        }
    }
    
}

extension Cache.Temporary {
    
    /// A wrapper for data.
    class Item {
        var content: Data
        init(content: Data) { self.content = content }
    }
    
}
