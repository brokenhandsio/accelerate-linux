#if canImport(Accelerate)
@_exported import Accelerate
#else
import CBLAS

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

/// Performs an out-of-place multiplication of two double-precision real matrices.
/// - Parameters:
///   - __A: The M x P left-hand side input matrix.
///   - __IA: The distance between the elements in the left-hand side input matrix.
///   - __B: The P x N right-hand side input matrix.
///   - __IB: The distance between the elements in the right-hand side input matrix.
///   - __C: The M x N output matrix.
///   - __IC: The distance between the elements in the output matrix.
///   - __M: The number of rows in matrices A and C.
///   - __N: The number of columns in matrices B and C.
///   - __P: The number of columns in matrix A and the number of rows in matrix B.
public func vDSP_mmulD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __B: UnsafePointer<Double>,
    _ __IB: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __M: vDSP_Length,
    _ __N: vDSP_Length,
    _ __P: vDSP_Length
) {
    var a = __A
    for i in 0..<__M {
        var b = __B
        for _ in 0..<__P {
            var c = __C.advanced(by: Int(i) * __IC * Int(__N))
            for _ in 0..<__N {
                c.pointee += a.pointee * b.pointee
                b = b.advanced(by: __IB)
                c = c.advanced(by: __IC)
            }
            a = a.advanced(by: __IA)
        }
    }
}
#endif  // canImport(Accelerate)
