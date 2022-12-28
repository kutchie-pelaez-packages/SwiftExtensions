extension Dictionary {
    public func unwrapped<V>() -> [Key: V] where Value == Optional<V> {
        compactMapValues { $0 == nil ? nil : $0! }
    }

    public func appending(_ other: [Key : Value]?) -> [Key : Value] {
        guard let other else { return self }

        return merging(other) { first, _ in first }
    }

    public mutating func append(_ other: [Key : Value]?) {
        self = appending(other)
    }

    public func overriding(with other: [Key : Value]?) -> [Key : Value] {
        guard let other else { return self }

        return merging(other) { _, last in last }
    }

    public mutating func override(with other: [Key : Value]?) {
        self = overriding(with: other)
    }
}
