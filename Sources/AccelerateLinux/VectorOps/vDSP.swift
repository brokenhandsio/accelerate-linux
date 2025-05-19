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
    @inlinable
    @inline(__always)
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
    @inlinable
    @inline(__always)
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
    @inlinable
    @inline(__always)
    public static func sum<U>(_ vector: U) -> Double where U: AccelerateBuffer, U.Element == Double {
        if vector.count == 0 { return 0.0 }

        if vector.count <= 8 {
            var sum: Double = 0.0
            vector.withUnsafeBufferPointer { buffer in
                var i = 0
                while i < vector.count {
                    sum += buffer[i]
                    i += 1
                }
            }
            return sum
        }

        vector.withUnsafeBufferPointer { buffer in
            guard let baseAddress = buffer.baseAddress else { return 0.0 }

            let count = buffer.count
            var sum1: Double = 0.0
            var sum2: Double = 0.0
            var sum3: Double = 0.0
            var sum4: Double = 0.0
            var sum5: Double = 0.0
            var sum6: Double = 0.0
            var sum7: Double = 0.0
            var sum8: Double = 0.0

            let vectorCount = count - (count % 8)
            for i in stride(from: 0, to: vectorCount, by: 8) {
                sum1 += baseAddress[i]
                sum2 += baseAddress[i + 1]
                sum3 += baseAddress[i + 2]
                sum4 += baseAddress[i + 3]
                sum5 += baseAddress[i + 4]
                sum6 += baseAddress[i + 5]
                sum7 += baseAddress[i + 6]
                sum8 += baseAddress[i + 7]
            }

            var remainingSum: Double = 0.0
            for i in vectorCount..<count {
                remainingSum += baseAddress[i]
            }

            return sum1 + sum2 + sum3 + sum4 + sum5 + sum6 + sum7 + sum8 + remainingSum
        }
    }

    /// Returns the double-precision element-wise subtraction of two vectors.
    /// - Parameters:
    ///   - vectorA: The first input vector, A.
    ///   - vectorB: The second input vector, B.
    /// - Returns: The output vector, C.
    @inlinable
    @inline(__always)
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

    /// Returns the double-precision element-wise product of two vectors.
    /// - Parameters:
    ///   - vectorA: The first input vector, A.
    ///   - vectorB: The second input vector, B.
    /// - Returns: The output vector, C.
    @inlinable
    @inline(__always)
    public static func multiply<T, U>(
        _ vectorA: T,
        _ vectorB: U
    ) -> [Double] where T: AccelerateBuffer, U: AccelerateBuffer, T.Element == Double, U.Element == Double {
        .init(unsafeUninitializedCapacity: vectorA.count) { buffer, initializedCount in
            vectorA.withUnsafeBufferPointer { aPtr in
                vectorB.withUnsafeBufferPointer { bPtr in
                    var i = 0
                    while i < vectorA.count {
                        buffer[i] = aPtr[i] * bPtr[i]
                        i += 1
                    }
                    initializedCount = vectorA.count
                }
            }
        }
    }

    /// Returns the single-precision element-wise product of two vectors.
    /// - Parameters:
    ///   - vectorA: The first input vector, A.
    ///   - vectorB: The second input vector, B.
    /// - Returns: The output vector, C.
    @inlinable
    @inline(__always)
    public static func multiply<T, U>(
        _ vectorA: T,
        _ vectorB: U
    ) -> [Float] where T: AccelerateBuffer, U: AccelerateBuffer, T.Element == Float, U.Element == Float {
        .init(unsafeUninitializedCapacity: vectorA.count) { buffer, initializedCount in
            vectorA.withUnsafeBufferPointer { aPtr in
                vectorB.withUnsafeBufferPointer { bPtr in
                    var i = 0
                    while i < vectorA.count {
                        buffer[i] = aPtr[i] * bPtr[i]
                        i += 1
                    }
                    initializedCount = vectorA.count
                }
            }
        }
    }

    /// Returns the double-precision element-wise product of a vector and a scalar value.
    /// - Parameters:
    ///   - scalar: The input scalar value, B.
    ///   - vector: The input vector, A.
    /// - Returns: The output vector, C.
    @inlinable
    @inline(__always)
    public static func multiply<U>(
        _ scalar: Double,
        _ vector: U
    ) -> [Double] where U: AccelerateBuffer, U.Element == Double {
        .init(unsafeUninitializedCapacity: vector.count) { buffer, initializedCount in
            vector.withUnsafeBufferPointer { vPtr in
                var i = 0
                while i < vector.count {
                    buffer[i] = vPtr[i] * scalar
                    i += 1
                }
                initializedCount = vector.count
            }
        }
    }
}
#endif
