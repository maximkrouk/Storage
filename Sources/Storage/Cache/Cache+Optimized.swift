//
//  Cache+Optimized.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/27/19.
//

import Foundation

extension Cache.Optimized.Entry: Codable where Key: Codable, Value: Codable {}

private extension Cache {

    final class Optimized<Key: Hashable, Value> {
        private let storage = NSCache<WrappedKey, Entry>()
            private let dateProvider: () -> Date
            private let entryLifetime: TimeInterval
            private let keyTracker = KeyTracker()

            init(dateProvider: @escaping () -> Date = Date.init,
                 entryLifetime: TimeInterval = 12 * 60 * 60,
                 maximumEntryCount: Int = 50) {
                self.dateProvider = dateProvider
                self.entryLifetime = entryLifetime
                storage.countLimit = maximumEntryCount
                storage.delegate = keyTracker
            }

        func removeValue(forKey key: Key) {
            storage.removeObject(forKey: WrappedKey(key))
        }
    }

}

private extension Cache.Optimized {
    func entry(forKey key: Key) -> Entry? {
        guard let entry = storage.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }

        return entry
    }

    func insert(_ entry: Entry) {
        storage.setObject(entry, forKey: WrappedKey(entry.key))
        keyTracker.keys.insert(entry.key)
    }
}

extension Cache.Optimized: Codable where Key: Codable, Value: Codable {
    convenience init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach(insert)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(entry))
    }
}

private extension Cache.Optimized {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let object = object.cast(to: WrappedKey.self) else {
                return false
            }

            return object.key == key
        }
    }

    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys = Set<Key>()

        func cache(_ cache: NSCache<AnyObject, AnyObject>,
                   willEvictObject object: Any) {
                guard let entry = object as? Entry else { return }
                keys.remove(entry.key)
            }
        }

    final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date

        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}
