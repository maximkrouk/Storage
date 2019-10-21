//
//  Cache+Persistent.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/5/19.
//

import Convenience
import Foundation

public extension Cache {
    
    final class Persistent: StorageManager {
        private let lock = NSLock()
        private let fileManager = FileManager.default
        private var folderName: String?
        public var directory: URL {
            modification(of: cacheDirectory) {
                let bundleId = Bundle.main.bundleIdentifier.unwrap(default: "ConvenienceTempDir")
                let group = folderName.isNil ? "" : "/\(folderName.unwrap())"
                $0.appendPathComponent("\(bundleId + group)")
            }
        }
        
        public init(_ group: String? = nil) {
            self.folderName = group
            if !fileManager.fileExists(atPath: directory.path) {
                try! fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            }
        }
        
        public func data(forKey key: String) -> Result<Data> {
            lock.execute {
                guard let hash = key.sha256 else {
                    return .failure(PlainError("Could not get sha1 hash from key: [\(key)]"))
                }
                guard let data = fileManager.contents(atPath: url(for: hash).path) else {
                    return .failure(PlainError("No data found for key: [\(key)]"))
                }
                return .success(data)
            }
        }

        @discardableResult
        public func save(data: Data, forKey key: String) -> Result<Void> {
            lock.execute {
                guard let hash = key.sha256 else {
                    return .failure(PlainError("Could not get sha1 hash from key: [\(key)]"))
                }
                unsafeDelete(key: hash)
                let path = url(for: hash).path
                let result = fileManager.createFile(atPath: path, contents: data, attributes: nil)
                return result ?
                    .success(()) :
                    .failure(PlainError("File already exists for key: [\(key)]. Failed to rewrite."))
            }
        }
        
        @discardableResult
        public func delete(key: String) -> Result<Void> {
            lock.execute {
                guard let hash = key.sha256 else {
                    return .failure(PlainError("Could not get sha256 hash from key: [\(key)]"))
                }
                return unsafeDelete(key: hash)
            }
        }

        @discardableResult
        public func clear() -> Result<Void> {
            lock.execute {
                do {
                    let contents = try fileManager.contentsOfDirectory(atPath: directory.path)
                    contents.forEach { try? fileManager.removeItem(atPath: $0) }
                    return .success(())
                } catch {
                    return .failure(error)
                }
            }
        }
        
        @discardableResult
        private func unsafeDelete(key: String) -> Result<Void> {
            do {
                let path = url(for: key).path
                if fileManager.fileExists(atPath: path) { try fileManager.removeItem(atPath: path) }
                return .success(())
            } catch {
                return .failure(error)
            }
        }
    }
    
}

private extension Cache.Persistent {
    
    var cacheDirectory: URL {
        try! fileManager.url(for: .cachesDirectory,
                             in: .userDomainMask,
                             appropriateFor: nil,
                             create: false)
    }
    
    func url(for key: String) -> URL { directory.appendingPathComponent("\(key).tmp", isDirectory: false) }
    
}
