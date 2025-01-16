#if canImport(Accelerate)
@_exported import Accelerate
#else
/// An enumeration that acts as a namespace for Swift overlays to vDSP.
public enum vDSP {
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

    /// Returns the double-precision element-wise sum of two vectors.
    /// - Parameters:
    ///   - vectorA: The first input vector, A.
    ///   - vectorB: The second input vector, B.
    /// - Returns: The output vector, C.
    public static func add<T, U>(
        _ vectorA: T,
        _ vectorB: U
    ) -> [Double] where T: AccelerateBuffer, U: AccelerateBuffer, T.Element == Double, U.Element == Double {
        precondition(vectorA.count == vectorB.count, "Vectors must have the same count.")
        return .init(unsafeUninitializedCapacity: vectorA.count) { buffer, initializedCount in
            vectorA.withUnsafeBufferPointer { vecAPtr in
                vectorB.withUnsafeBufferPointer { vecBPtr in
                    var i = 0
                    while i < vectorA.count {
                        buffer[i] = vecAPtr[i] + vecBPtr[i]
                        i += 1
                    }
                    initializedCount = vectorA.count
                }
            }
        }
    }

    /// Returns the double-precision vector sum.
    /// - Parameter vector: The vector to sum.
    public static func sum<U>(_ vector: U) -> Double where U: AccelerateBuffer, U.Element == Double {
        vector.withUnsafeBufferPointer { ptr in
            var sum: Double = 0
            var i = ptr.startIndex
            while i < ptr.endIndex {
                sum += ptr[i]
                i += 1
            }
            return sum
        }
    }

    /// Returns the double-precision element-wise subtraction of two vectors.
    /// - Parameters:
    ///   - vectorA: The first input vector, A.
    ///   - vectorB: The second input vector, B.
    /// - Returns: The output vector, C.
    public static func subtract<T, U>(
        _ vectorA: U,
        _ vectorB: T
    ) -> [Double] where T: AccelerateBuffer, U: AccelerateBuffer, T.Element == Double, U.Element == Double {
        .init(unsafeUninitializedCapacity: vectorA.count) { buffer, initializedCount in
            vectorA.withUnsafeBufferPointer { aPtr in
                vectorB.withUnsafeBufferPointer { bPtr in
                    var i = 0
                    while i < vectorA.count {
                        buffer[i] = aPtr[i] - bPtr[i]
                        i += 1
                    }
                    initializedCount = vectorA.count
                }
            }
        }
    }
}
#endif
