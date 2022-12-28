extension StringProtocol {
    public func firstCharacterUppercased() -> String {
        prefix(1).uppercased() + dropFirst()
    }

    public func firstCharacterLowercased() -> String {
        prefix(1).lowercased() + dropFirst()
    }

    public func indented(_ count: Int) -> String {
        Array(repeating: " ", count: count).joined() + self
    }

    public func surrounded(by string: some StringProtocol) -> String {
        surroundedBy(string, string)
    }

    public func surroundedBy(_ lhs: some StringProtocol, _ rhs: some StringProtocol) -> String {
        [lhs.description, self.description, rhs.description].joined()
    }
}
