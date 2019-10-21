# Storage

Every type of storage:

- Has the same interface.
- Extendable.
- Thread safe.

#### Interface:

Any storage provided via managers is accessible as key-value pairs. You may use strings, but you'll be getting warnings, because I deprecated this approach. Natively the framework advices you to use string based enums.

In exaples I'll be using this:

```swift
enum Auth: String {
    case username // .rawValue == "username"
    case isAdmin  // .rawValue == "isAdmin"
}
```

Avalible **Managers:**

- `Keychain`

  _Shortcut: KC_

- `UserDefaults`

  _Shortcut: UD_

- `Cache` [temporary / persistent]

  _Shortcut: CH_

You can easily extend Avalible managers with your own by writinfg an implementation and subscribing your managers to a `StorageManagerProtocol`

You should access any storage via providers. You may use them as static or singleton's properties.

- `[Manager].[Provider]`

Out-of-the-box **Providers:**

- `.data`
- `.bool`
- `.string`

**Providers** allow you to access storage:

- Via subscripts:
  - `provider[key]`
- Via methods:
  - `provider.get(for: key)`
  - `provider.set(value, for: key)`
- Via deprecated subscripts and methods:
  - `provider[stringKey]`
  - `provider.get(forKey: stringKey)`
  - `provider.set(value, forKey: stringKey)`

For convenience it would be nice to extend framework's `Storage.Provider` with your custom adapter subscripts:

```swift
extension Storage.Provider {
    subscript(key: Auth) -> Value? {    // Value is a Provider's assosiated type.
        get { get(for: key) }           // Just pass key to build-in getter,
        set { set(newValue, for: key) } // or key-value to build in setter.
    }
}
```

This will allow you to access storage not just like this:

- `Storage.[Manager].[Provider][Auth.username]`

but also like this:

- `Storage.[Manager].[Provider][.username]`

#### Keychain as an example:

- `Storage.Keychain.data.set(nil, forKey: "deletedItem")`
- `Storage.Keychain.data.get(forKey: "deletedItem") // nil`
- `Storage.Keychain.data["StringKeys"] = "Sucks c:".data(using: .utf8)`
- `Storage.Keychain.default.string[.username] = "Root"`
- `Storage.Keychain.default.bool[.isAdmin] = true`
- `Storage.KC.bool[.isAdmin] // true`