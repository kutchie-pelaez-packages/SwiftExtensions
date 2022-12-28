extension Result {
    public var success: Success? {
        if case .success(let success) = self {
            return success
        }

        return nil
    }

    public var failure: Failure? {
        if case .failure(let error) = self {
            return error
        }

        return nil
    }
}
