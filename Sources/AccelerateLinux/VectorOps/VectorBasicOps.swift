#if canImport(Accelerate)
@_exported import Accelerate
#else

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

/// Calculates the absolute value of each element in the supplied double-precision vector using the specified stride.
/// - Parameters:
///   - __A: The input vector A.
///   - __IA: The distance between the elements in the input vector A.
///   - __C: On output, the absolute values of the elements in the input vector.
///   - __IC: The distance between the elements in the output vector C.
///   - __N: The number of elements that the function processes.
public func vDSP_vabsD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[i * __IC] = abs(__A[i * __IC])
        i += 1
    }
}

/// Calculates the negative value of each element in the supplied double-precision vector using specified stride.
/// - Parameters:
///   - __A: The input vector A.
///   - __IA: The distance between the elements in the input vector A.
///   - __C: On output, the negative values of the elements in the input vector.
///   - __IC: The distance between the elements in the output vector C.
///   - __N: The number of elements that the function processes.
public func vDSP_vnegD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[i * __IC] = -__A[i * __IC]
        i += 1
    }
}

/// Computes the squared value of each element in the supplied double-precision vector.
public func vDSP_vsqD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[i * __IC] = __A[i * __IC] * __A[i * __IC]
        i += 1
    }
}

/// Calculates the dot product of two double-precision vectors.
/// - Parameters:
///   - __A: The input vector A.
///   - __IA: The distance between the elements in the input vector A.
///   - __B: The input vector B.
///   - __IB: The distance between the elements in the input vector B.
///   - __C: On output, the dot product of the two vectors.
///   - __N: The number of elements to process.
public func vDSP_dotprD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __B: UnsafePointer<Double>,
    _ __IB: vDSP_Stride,
    _ __C: UnsafeMutablePointer<Double>,
    _ __N: vDSP_Length
) {
    #warning("This could be implemented via BLAS (`cblas_ddot`) but we'd have to use OPENBLAS_USE64BITINT to make sure we don't overflow")
    var i = 0
    while i < __N {
        __C.pointee += __A[i * Int(__IA)] * __B[i * Int(__IB)]
        i += 1
    }

}
#endif
