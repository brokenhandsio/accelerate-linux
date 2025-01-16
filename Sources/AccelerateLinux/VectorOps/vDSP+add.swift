#if canImport(Accelerate)
@_exported import Accelerate
#else

extension vDSP {
    /// Returns the double-precision element-wise sum of a vector and a scalar value.
    /// - Parameters:
    ///   - scalar: The input scalar value, B.
    ///   - vector: The input vector, A.
    /// - Returns: The output vector, C.
    public static func add<U>(
        _ scalar: Double,
        _ vector: U
    ) -> [Double] where U: AccelerateBuffer, U.Element == Double {
        .init(unsafeUninitializedCapacity: vector.count) { buffer, initializedCount in
            vector.withUnsafeBufferPointer { vecPtr in
                var i = 0
                while i < vector.count {
                    buffer[i] = scalar * vecPtr[i] + vecPtr[i]
                    i += 1
                }
                initializedCount = vector.count
            }
        }
    }
}

#endif
