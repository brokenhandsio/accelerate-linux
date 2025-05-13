#if canImport(Accelerate)
@_exported import Accelerate
#else

/// Converts a double-precision vector to a single-precision vector.
/// - Parameters:
///   - __A: The input vector.
///   - __IA: The distance between the elements in the input vector.
///   - __C: The output vector.
///   - __IC: The distance between the elements in the output vector.
///   - __N: The number of elements that the function processes.
@inlinable
@inline(__always)
public func vDSP_vdpsp(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Float>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[i * __IC] = Float(__A[i * __IA])
        i += 1
    }
}

/// Converts a single-precision vector to a double-precision vector.
/// - Parameters:
///   - __A: The input vector.
///   - __IA: The distance between the elements in the input vector.
///   - __C: The output vector.
///   - __IC: The distance between the elements in the output vector.
///   - __N: The number of elements that the function processes.
@inlinable
@inline(__always)
public func vDSP_vspdp(
    _ __A: UnsafePointer<Float>,
    _ __IA: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[i * __IC] = Double(__A[i * __IA])
        i += 1
    }
}
#endif
