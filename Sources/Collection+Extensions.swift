extension Collection {
    public var isNotEmpty: Bool { !isEmpty }

    public subscript(safe index: Index?) -> Element? {
        guard let index else { return nil }

        return indices.contains(index) ? self[index] : nil
    }

    public func split(
        maxSplits: Int = .max,
        by shouldSplitBetween: (Element, Element) throws-> Bool
    ) rethrows -> [SubSequence] {
        guard count > 1 else { return [prefix(1)] }

        var pivots = [startIndex, index(endIndex, offsetBy: -1)]

        for (offset, _) in enumerated() {
            guard offset < count - 1 else { break }

            let currentIndex = index(startIndex, offsetBy: offset)
            let nextIndex = index(startIndex, offsetBy: offset + 1)

            if try shouldSplitBetween(self[currentIndex], self[nextIndex]) {
                pivots.insert(currentIndex, at: pivots.count - 1)
            }
        }

        var result = [SubSequence]()
        for (offset, pivot) in pivots.enumerated() {
            guard offset < pivots.count - 1 && maxSplits > offset else { break }

            let startIndex: Index
            if offset == 0 {
                startIndex = pivot
            } else {
                startIndex = index(pivot, offsetBy: 1)
            }
            let endIndex = pivots[offset + 1]

            result.append(self[startIndex...endIndex])
        }

        return result
    }
}

extension Collection where Element == Character {
    public func camelCaseSplitted(maxSplits: Int = .max) -> [SubSequence] {
        split(maxSplits: maxSplits) { $0.isLowercase && $1.isUppercase }
    }

    public func snakeCaseSplitted(maxSplits: Int = .max, omittingEmptySubsequences: Bool = true) -> [SubSequence] {
        split(separator: "_", maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences)
    }
}
