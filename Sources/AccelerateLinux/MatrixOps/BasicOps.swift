#if canImport(Accelerate)
@_exported import Accelerate
#else
import CBLAS
import CLAPACK

/// Calculates the double-precision maximum value of a vector.
/// - Parameters:
///  - __A: The vector to be examined.
///  - __I: The stride of the vector.
///  - __C: The maximum value.
///  - __N: The number of elements in the vector.
public func vDSP_maxvD(
    _ __A: UnsafePointer<Double>,
    _ __I: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __N: vDSP_Length
) {
    __C.pointee = -Double.infinity
    guard __N > 0 else { return }
    for i in 1..<__N {
        __C.pointee = max(__C.pointee, __A[Int(i) * __I])
    }
}

/// Calculates the double-precision minimum value of a vector.
/// - Parameters:
///   - __A: The vector to be examined.
///   - __I: The stride of the vector.
///   - __C: The minimum value.
///   - __N: The number of elements in the vector.
public func vDSP_minvD(
    _ __A: UnsafePointer<Double>,
    _ __I: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __N: vDSP_Length
) {
    __C.pointee = Double.infinity
    guard __N > 0 else { return }
    for i in 1..<__N {
        __C.pointee = min(__C.pointee, __A[Int(i) * __I])
    }
}

/// Transposes a double-precision matrix.
/// - Parameters:
///   - __A: The input matrix.
///   - __IA: The stride between elements in the input matrix.
///   - __C: The output matrix.
///   - __IC: The stride between elements in the output matrix.
///   - __M: The number of rows in the output matrix and the number of columns in the input matrix.
///   - __N: The number of columns in the output matrix and the number of rows in the input matrix.
/// - Warning: This function doesn’t support in-place operation.
public func vDSP_mtransD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __M: vDSP_Length,
    _ __N: vDSP_Length
) {
    var __A = __A
    for i in 0..<__N {
        var __C = __C.advanced(by: Int(i) * __IC)
        for _ in 0..<__M {
            __C.pointee = __A.pointee
            __A = __A.advanced(by: __IA)
            __C = __C.advanced(by: Int(__N) * __IC)
        }
    }
}
#endif  // canImport(Accelerate)
