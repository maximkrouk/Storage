//
//  StorageProvider.swift
//  Convenience
//
//  Created by Maxim Krouk on 8/4/19.
//

import Convenience
import Foundation

public protocol StorageProvider: class {
    associatedtype Value
    
    // MARK: - Subscripts
    
    /// Allows you to interact with selected storage provider just as simple as to a collection.
    ///
    /// - Parameter key: Stored value will be accessable by this key.
    subscript<Key: RawRepresentable>(_ key: Key) -> Value? where Key.RawValue == String { get set }
    
    /// Allows you to interact with selected storage provider just as simple as to a collection.
    ///
    /// It's a bad practice to use plain strings in your application, variables or constants are better,
    /// but string based enums are mush cleaner, try them, or ignore the warning if you have to use strings.
    ///
    /// If you want to silence the warning globaly, you may do this:
    /// (NOT RECOMMENDED)
    /// ```
    /// extension String: RawRepresentable {
    ///     public init(rawValue: String) { self = rawValue }
    ///     public var rawValue: String { self }
    /// }
    /// ```
    @available(*, deprecated, message: "Use your semantic string based enums as a parameter to this subscript.")
    subscript(_ key: String) -> Value? { get set }
    
    
    // MARK: - Respectable getters and setters
    
    /// Data getter.
    ///
    /// Loads value from selected storage provider.
    ///
    /// - Returns: Stored data obect if pesent, nil if not.
    func get<Key: RawRepresentable>(for key: Key) -> Value? where Key.RawValue == String
    
    /// Data setter.
    ///
    /// Saves value to the selected storage provider.
    /// - Returns: .success if the operation was successfull, .failure otherwise.
    @discardableResult
    func set<Key: RawRepresentable>(_ value: Value?, for key: Key) -> Result<Void> where Key.RawValue == String
    
    /// Data eraser.
    ///
    /// Deletes value from the selected storage provider.
    /// - Returns: .success if the operation was successfull, .failure otherwise.
    @discardableResult
    func delete<Key: RawRepresentable>(for key: Key) -> Result<Void> where Key.RawValue == String
    
    // MARK: - Deprecated getters and setters
    
    /// Data getter.
    ///
    /// Loads value from selected storage provider.
    ///
    /// It's a bad practice to use plain strings in your application, variables or constants are better,
    /// but string based enums are mush cleaner, try them, or ignore the warning if you have to use strings.
    ///
    /// If you want to silence the warning globaly, you may do this:
    /// (NOT RECOMMENDED)
    /// ```
    /// extension String: RawRepresentable {
    ///     public init(rawValue: String) { self = rawValue }
    ///     public var rawValue: String { self }
    /// }
    /// ```
    ///
    /// - Returns: Stored data obect if pesent, nil if not.
    @available(*, deprecated, message: "Use get(for:) method or subscript instead.")
    func get(forKey key: String) -> Value?

    
    /// Data setter.
    ///
    /// Saves value to the selected storage provider.
    ///
    /// It's a bad practice to use plain strings in your application, variables or constants are better,
    /// but string based enums are mush cleaner, try them, or ignore the warning if you have to use strings.
    ///
    /// If you want to silence the warning globaly, you may do this:
    /// (NOT RECOMMENDED)
    /// ```
    /// extension String: RawRepresentable {
    ///     public init(rawValue: String) { self = rawValue }
    ///     public var rawValue: String { self }
    /// }
    /// ```
    ///
    /// - Returns: .success if the operation was successfull, .failure otherwise.
    @available(*, deprecated, message: "Use get(for:) method or subscript instead.")
    @discardableResult
    func set(_ value: Value?, forKey key: String) -> Result<Void>
    
    /// Data eraser.
    ///
    /// Deletes value from the selected storage provider.
    ///
    /// It's a bad practice to use plain strings in your application, variables or constants are better,
    /// but string based enums are mush cleaner, try them, or ignore the warning if you have to use strings.
    ///
    /// If you want to silence the warning globaly, you may do this:
    /// (NOT RECOMMENDED)
    /// ```
    /// extension String: RawRepresentable {
    ///     public init(rawValue: String) { self = rawValue }
    ///     public var rawValue: String { self }
    /// }
    /// ```
    ///
    /// - Returns: .success if the operation was successfull, .failure otherwise.
    @available(*, deprecated, message: "Use delete(for:) method instead.")
    @discardableResult
    func delete(forKey key: String) -> Result<Void>
    
}

extension StorageProvider {
    
    public subscript<Key: RawRepresentable>(_ key: Key) -> Value? where Key.RawValue == String {
        get { self[key~] }
        set { self[key~] = newValue }
    }
    
    @available(*, deprecated, message: "Use your semantic string based enums as a parameter to this subscript.")
    public subscript(_ key: String) -> Value? {
        get { get(forKey: key) }
        set { set(newValue, forKey: key) }
    }
    
    public func get<Key: RawRepresentable>(for key: Key) -> Value? where Key.RawValue == String {
        get(forKey: key~)
    }

    @discardableResult
    public func set<Key: RawRepresentable>(_ value: Value?, for key: Key) -> Result<Void> where Key.RawValue == String {
        set(value, forKey: key~)
    }

    @discardableResult
    public func delete<Key: RawRepresentable>(for key: Key) -> Result<Void> where Key.RawValue == String {
        delete(forKey: key~)
    }
    
}

