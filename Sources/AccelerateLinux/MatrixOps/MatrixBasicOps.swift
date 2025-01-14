#if canImport(Accelerate)
@_exported import Accelerate
#else

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
