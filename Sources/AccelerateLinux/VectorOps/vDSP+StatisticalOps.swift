#if canImport(Accelerate)
@_exported import Accelerate
#else

extension vDSP {
    /// Returns the mean value of a double-precision vector.
    /// - Parameter vector: The source vector.
    public static func mean<U>(_ vector: U) -> Double where U: AccelerateBuffer, U.Element == Double {
        sum(vector) / Double(vector.count)
    }
}
#endif
