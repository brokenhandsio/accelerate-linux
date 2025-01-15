#if canImport(Accelerate)
@_exported import Accelerate
#else
import FoundationEssentials

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
    var i = 1
    while i < __N {
        __C.pointee = max(__C.pointee, __A[Int(i) * __I])
        i += 1
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
    var i = 1
    while i < __N {
        __C.pointee = min(__C.pointee, __A[Int(i) * __I])
        i += 1
    }
}

/// Calculates the double-precision element-wise sum of two vectors, using the specified stride.
/// - Parameters:
///   - __A: The first input vector, A.
///   - __IA: The distance between the elements in the first input vector.
///   - __B: The second input vector, B.
///   - __IB: The distance between the elements in the second input vector.
///   - __C: The output vector, C.
///   - __IC: The distance between the elements in the output vector.
///   - __N: The number of elements that the function processes.
public func vDSP_vaddD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __B: UnsafePointer<Double>,
    _ __IB: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[Int(i) * __IC] = __A[Int(i) * __IA] + __B[Int(i) * __IB]
        i += 1
    }
}

/// Calculates the double-precision element-wise subtraction of two vectors, using the specified stride.
/// - Parameters:
///   - __B: The first input vector, B.
///   - __IB: The distance between the elements in the first input vector.
///   - __A: The second input vector, A.
///   - __IA: The distance between the elements in the second input vector.
///   - __C: The output vector, C.
///   - __IC: The distance between the elements in the output vector.
///   - __N: The number of elements that the function processes.
public func vDSP_vsubD(
    _ __B: UnsafePointer<Double>,
    _ __IB: vDSP_Stride,
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[Int(i) * __IC] = __A[Int(i) * __IA] - __B[Int(i) * __IB]
        i += 1
    }
}

/// Calculates the double-precision element-wise product of two vectors, using the specified stride.
/// - Parameters:
///   - __A: The first input vector, A.
///   - __IA: The distance between the elements in the first input vector.
///   - __B: The second input vector, B.
///   - __IB: The distance between the elements in the second input vector.
///   - __C: The output vector, C.
///   - __IC: The distance between the elements in the output vector.
///   - __N: The number of elements that the function processes.
public func vDSP_vmulD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __B: UnsafePointer<Double>,
    _ __IB: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[Int(i) * __IC] = __A[Int(i) * __IA] * __B[Int(i) * __IB]
        i += 1
    }
}

/// Raises each element in an array to the power of the corresponding element in a second array of double-precision values.
/// - Parameters:
///   - _: The output array, z.
///   - _: The exponent input array, y.
///   - _: The base input array, x.
///   - _: The number of elements in the arrays.
public func vvpow(
    _ z: UnsafeMutablePointer<Double>,
    _ y: UnsafePointer<Double>,
    _ x: UnsafePointer<Double>,
    _ n: UnsafePointer<Int32>
) {
    // Exponentiation by squaring
    func expBySquaring(_ b: Double, elevatedTo n: Double) -> Double {
        func aux(_ y: Double, _ b: Double, _ n: Double) -> Double {
            switch n {
            case let x where x < 0: aux(y, 1 / b, -n)
            case 0: y
            case let x where x.truncatingRemainder(dividingBy: 2) == 0: aux(y, b * b, n / 2)
            default: aux(b * y, b * b, (n - 1) / 2)
            }
        }
        return aux(1, b, n)
    }

    var i = 0
    while i < n.pointee {
        z[i] = expBySquaring(x[i], elevatedTo: y[i])
        i += 1
    }
}

/// Populates a double-precision vector with zeros.
/// - Parameters:
///   - __C: Double-precision real output vector.
///   - __IC: Address stride for C.
///   - __N: The number of elements to process.
public func vDSP_vclrD(
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var zero: Double = 0
    vDSP_vfillD(&zero, __C, __IC, __N)
}

/// Populates a double-precision vector with a specified scalar value.
public func vDSP_vfillD(
    _ __A: UnsafePointer<Double>,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[i * __IC] = __A.pointee
        i += 1
    }
}
#endif
