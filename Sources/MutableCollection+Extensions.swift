extension MutableCollection {
    public subscript(safe index: Index?) -> Element? {
        get {
            guard let index else { return nil }

            return indices.contains(index) ? self[index] : nil
        }
        set {
            guard
                let index,
                indices.contains(index),
                let newValue
            else {
                return
            }

            self[index] = newValue
        }
    }
}
