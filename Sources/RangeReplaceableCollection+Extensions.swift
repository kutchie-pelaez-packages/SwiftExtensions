extension RangeReplaceableCollection {
    public func removingFirst(_ k: Int = 1) -> Self {
        let numberOfElementsToRemove = k.clamped(0...count)
        var copy = self
        copy.removeFirst(numberOfElementsToRemove)

        return copy
    }

    public func removing(at position: Index) -> Self {
        guard indices.contains(position) else { return self }

        var copy = self
        copy.remove(at: position)

        return copy
    }

    public func removingAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows -> Self {
        var copy = self
        try copy.removeAll(where: shouldBeRemoved)

        return copy
    }

    public mutating func prepend(_ newElement: Element) {
        insert(newElement, at: startIndex)
    }

    public mutating func prepend<C: Collection>(contentsOf newElements: C) where Element == C.Element {
        insert(contentsOf: newElements, at: startIndex)
    }

    public func prepending(_ newElement: Element) -> Self {
        inserting(newElement, at: startIndex)
    }

    public func prepending<C: Collection>(contentsOf newElements: C) -> Self where Element == C.Element {
        inserting(contentsOf: newElements, at: startIndex)
    }

    public func appending(_ newElement: Element) -> Self {
        var copy = self
        copy.append(newElement)

        return copy
    }

    public func appending<S: Sequence>(contentsOf newElements: S) -> Self where Element == S.Element {
        var copy = self
        copy.append(contentsOf: newElements)

        return copy
    }

    public func inserting(_ newElement: Element, at i: Index) -> Self {
        guard (startIndex...endIndex).contains(i) else { return self }

        var copy = self
        copy.insert(newElement, at: i)

        return copy
    }

    public func inserting<C: Collection>(
        contentsOf newElements: C,
        at i: Index
    ) -> Self where Element == C.Element {
        guard (startIndex...endIndex).contains(i) else { return self }

        var copy = self
        copy.insert(contentsOf: newElements, at: i)

        return copy
    }
}

extension RangeReplaceableCollection where Self: BidirectionalCollection {
    public func removingLast(_ k: Int = 1) -> Self {
        let numberOfElementsToRemove = k.clamped(0...count)
        var copy = self
        copy.removeLast(numberOfElementsToRemove)

        return copy
    }
}

extension RangeReplaceableCollection where Element: Equatable {
    public func reorderingElementFirst(where shouldBeReordered: (Element) throws -> Bool) rethrows -> Self {
        try removingAll(where: shouldBeReordered).prepending(contentsOf: try filter(shouldBeReordered))
    }

    public func reorderingElementFirst(_ element: Element) -> Self {
        reorderingElementFirst { $0 == element }
    }
}
