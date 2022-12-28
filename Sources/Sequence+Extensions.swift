extension Sequence {
    public func unwrapped<T>() -> [T] where Element == Optional<T> {
        compactMap { $0 }
    }

    public func unique<H: Hashable>(by elementToHashableMapping: (Element) throws -> H) rethrows -> [Element] {
        var seenElements = Set<H>()

        return try filter { element in
            let hashableElement = try elementToHashableMapping(element)

            guard !seenElements.contains(hashableElement) else {
                return false
            }

            seenElements.insert(hashableElement)

            return true
        }
    }

    public func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var result = [T]()

        for element in self {
            let transformedElement = try await transform(element)
            result.append(transformedElement)
        }

        return result
    }

    public func asyncFilter(_ isIncluded: (Element) async throws -> Bool) async rethrows -> [Element] {
        try await asyncMap { element in
            if try await isIncluded(element) {
                return element
            } else {
                return nil
            }
        }
        .unwrapped()
    }
}

extension Sequence where Element: Sequence {
    public func flatten() -> [Element.Element] {
        flatMap { $0 }
    }
}

extension Sequence where Element: Hashable {
    public func uniqued() -> [Element] {
        unique { $0 }
    }
}
