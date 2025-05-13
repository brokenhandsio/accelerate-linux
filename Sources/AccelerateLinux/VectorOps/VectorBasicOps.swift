#if canImport(Accelerate)
@_exported import Accelerate
#else
import CLAPACK
import Glibc

/// Calculates the double-precision maximum value of a vector.
/// - Parameters:
///  - __A: The vector to be examined.
///  - __I: The stride of the vector.
///  - __C: The maximum value.
///  - __N: The number of elements in the vector.
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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

/// Calculates the double-precision vector test limit using the specified stride.
@inlinable
@inline(__always)
public func vDSP_vlimD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __B: UnsafePointer<Double>,
    _ __C: UnsafePointer<Double>,
    _ __D: UnsafeMutablePointer<Double>,
    _ __ID: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __D[i * __ID] = __C.pointee * ((__B.pointee <= __A[i * __IA]) ? 1 : -1)
        i += 1
    }
}

/// Calculates and counts the elements of a double-precision vector clipped to the specified range.
/// - Parameters:
///   - __A: The input vector.
///   - __IA: The stride for the input vector.
///   - __B: A pointer to the scalar low-clipping threshold. If the low-clipping threshold is greater than the high-clipping threshold, the function calculates an undefined result.
///   - __C: A pointer to the scalar high-clipping threshold. If the high-clipping threshold is less than the low-clipping threshold, the function calculates an undefined result.
///   - __D: The output vector.
///   - __ID: The stride for the output vector.
///   - __N: The number of elements that the function clips to the specified range.
///   - __NLow: On output, the number of elements clipped to the low-clipping threshold.
///   - __NHigh: On output, the number of elements clipped to the high-clipping threshold.
@inlinable
@inline(__always)
public func vDSP_vclipcD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __B: UnsafePointer<Double>,
    _ __C: UnsafePointer<Double>,
    _ __D: UnsafeMutablePointer<Double>,
    _ __ID: vDSP_Stride,
    _ __N: vDSP_Length,
    _ __NLow: UnsafeMutablePointer<vDSP_Length>,
    _ __NHigh: UnsafeMutablePointer<vDSP_Length>
) {
    var i = 0
    while i < __N {
        if __A[i * __IA] < __B.pointee {
            __D[i * __ID] = __B.pointee
            __NLow.pointee += 1
        } else if __A[i * __IA] > __C.pointee {
            __D[i * __ID] = __C.pointee
            __NHigh.pointee += 1
        } else {
            __D[i * __ID] = __A[i * __IA]
        }
        i += 1
    }
}

/// Performs running sum integration over a double-precision vector.
/// - Parameters:
///   - __A: Double-precision real input vector.
///   - __IA: Address stride for A.
///   - __S: Points to double-precision real input scalar: weighting factor.
///   - __C: Double-precision real output vector.
///   - __IC: Stride for C
///   - __N: The number of elements to process.
/// Integrates vector A using a running sum from vector C.
/// Vector A is weighted by scalar *S and added to the previous output point.
/// The first element from vector A is not used in the sum.
@inlinable
@inline(__always)
public func vDSP_vrsumD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __S: UnsafePointer<Double>,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    if __N <= 0 { return }

    let s = __S.pointee
    var sum = 0.0
    __C[0] = 0.0

    for i in 1..<__N {
        let aIdx = Int(i) * __IA
        let cIdx = Int(i) * __IC

        sum += __A[aIdx] * s
        __C[cIdx] = sum
    }
}

/// Performs an in-place sort of a double-precision vector.
/// - Parameters:
///   - __C: The vector that the function sorts in-place.
///   - __N: The number of elements in the vector.
///   - __Order: A value that specifies the sort order. Pass 1 to specify ascending order, or -1 for descending order.
#warning("If the array is bigger than Int.max, vDSP_vsortD will do nothing. Find a solution")
@inlinable
@inline(__always)
public func vDSP_vsortD(
    _ __C: UnsafeMutablePointer<Double>,
    _ __N: vDSP_Length,
    _ __Order: Int32
) {
    // If dealing with 32 bit use LAPACK
    #warning("Update this when we switch to 64 bit compat")
    if __N <= vDSP_Length(Int32.max) {
        var n = Int32(__N)
        var info = Int32(0)

        return dlasrt_(
            (__Order == 1) ? "I" : "D",
            &n,
            __C,
            &info,
            0
        )
    }

    let length = Int(__N - 1)
    guard length > 0 else { return }
    quicksort(__C, __N, __Order, p: 0, r: Int(__N - 1))
}

/// Generates a double-precision vector with monotonically incrementing or decrementing values using an initial value and increment.
/// - Parameters:
///   - __A: The initial value of the ramp.
///   - __B: The increment, or decrement if negative, between each generated element.
///   - __C: The output vector.
///   - __IC: The distance between the elements in the output vector.
///   - __N: The number of elements that the function processes.
@inlinable
@inline(__always)
public func vDSP_vrampD(
    _ __A: UnsafePointer<Double>,
    _ __B: UnsafePointer<Double>,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[i * __IC] = (__A.pointee + __B.pointee) * Double(i)
        i += 1
    }
}
/// Calculates the double-precision minimum of the corresponding values of two vectors using specified strides.
/// - Parameters:
///   - __A: Double-precision real input vector.
///   - __IA: Stride for A.
///   - __B: Double-precision real input vector.
///   - __IB: Stride for B.
///   - __C: Double-precision real output vector.
///   - __IC: Stride for C.
///   - __N: The number of elements to process.
/// This function compares the first N elements of A with corresponding elements of B,
/// leaving the lesser (or equal) values as corresponding elements of C:
/// ```
/// for (n = 0; n < N; ++n)
///    C[n] = A[n] <= B[n] ? A[n] : B[n];
/// ```
@inlinable
@inline(__always)
public func vDSP_vminD(
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
        __C[i * __IC] = __A[i * __IA] <= __B[i * __IB] ? __A[i * __IA] : __B[i * __IB]
        i += 1
    }
}

/// Calculates the double-precision maximum of the corresponding values of two vectors using specified strides.
/// - Parameters:
///   - __A: Double-precision real input vector.
///   - __IA: Stride for A.
///   - __B: Double-precision real input vector.
///   - __IB: Stride for B.
///   - __C: Double-precision real output vector.
///   - __IC: Stride for C.
///   - __N: The number of elements to process.
@inlinable
@inline(__always)
public func vDSP_vmaxD(
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
        __C[i * __IC] = __A[i * __IA] >= __B[i * __IB] ? __A[i * __IA] : __B[i * __IB]
        i += 1
    }
}

/// Calculates the double-precision element-wise division of two vectors, using the specified stride.
/// - Parameters:
///   - __B: The first input vector, B.
///   - __IB: The distance between the elements in the first input vector.
///   - __A: The second input vector, A.
///   - __IA: The distance between the elements in the second input vector.
///   - __C: The output vector, C.
///   - __IC: The distance between the elements in the output vector.
///   - __N: The number of elements that the function processes.
@inlinable
@inline(__always)
public func vDSP_vdivD(
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
        __C[i * __IC] = __A[i * __IA] / __B[i * __IB]
        i += 1
    }
}

/// Calculates the double-precision element-wise division of a vector and a scalar value, using the specified stride.
/// - Parameters:
///   - __A: The input vector, A.
///   - __IA: The distance between the elements in the input vector.
///   - __B: The scalar value, B.
///   - __C: The output vector, C.
///   - __IC: The distance between the elements in the output vector.
///   - __N: The number of elements that the function processes.
@inlinable
@inline(__always)
public func vDSP_vsdivD(
    _ __A: UnsafePointer<Double>,
    _ __IA: vDSP_Stride,
    _ __B: UnsafePointer<Double>,
    _ __C: UnsafeMutablePointer<Double>,
    _ __IC: vDSP_Stride,
    _ __N: vDSP_Length
) {
    var i = 0
    while i < __N {
        __C[i * __IC] = __A[i * __IA] / __B.pointee
        i += 1
    }
}

/// Calculates the sine of each element in an array of double-precision values.
/// - Parameters:
///   - y: The output array, y.
///   - x: The input array, x.
///   - n: The number of elements in the arrays.
///
/// If x is +/-0, the result preserves the signed zero.
/// If x is +/-inf, the result is NaN.
@inlinable
@inline(__always)
public func vvsin(
    _ y: UnsafeMutablePointer<Double>,
    _ x: UnsafePointer<Double>,
    _ n: UnsafePointer<Int32>
) {
    var i = 0
    while i < n.pointee {
        y[i] = sin(x[i])
        i += 1
    }
}

/// Calculates the square root of each element in an array of double-precision values.
/// - Parameters:
///   - y: The output array, y.
///   - x: The input array, x.
///   - n: The number of elements in the arrays.
@inlinable
@inline(__always)
public func vvsqrt(
    _ y: UnsafeMutablePointer<Double>,
    _ x: UnsafePointer<Double>,
    _ n: UnsafePointer<Int32>
) {
    var i = 0
    while i < n.pointee {
        y[i] = sqrt(x[i])
        i += 1
    }
}

/// Calculates e raised to the power of each element in an array of double-precision values.
/// - Parameters:
///   - y: The output array, y.
///   - x: The input array, x.
///   - n: The number of elements in the arrays.
@inlinable
@inline(__always)
public func vvexp(
    _ y: UnsafeMutablePointer<Double>,
    _ x: UnsafePointer<Double>,
    _ n: UnsafePointer<Int32>
) {
    var i = 0
    while i < n.pointee {
        y[i] = exp(x[i])
        i += 1
    }
}

/// Calculates the natural logarithm of each element in an array of double-precision values.
/// - Parameters:
///   - y: The output array, y.
///   - x: The input array, x.
///   - n: The number of elements in the arrays.
@inlinable
@inline(__always)
public func vvlog(
    _ y: UnsafeMutablePointer<Double>,
    _ x: UnsafePointer<Double>,
    _ n: UnsafePointer<Int32>
) {
    var i = 0
    while i < n.pointee {
        y[i] = log(x[i])
        i += 1
    }
}

@usableFromInline
func quicksort(
    _ vec: UnsafeMutablePointer<Double>,
    _ len: vDSP_Length,
    _ ord: Int32,
    p: Int,
    r: Int
) {
    func partition(
        _ vec: UnsafeMutablePointer<Double>,
        p: Int,
        r: Int,
        ord: Int32
    ) -> Int {
        let x = vec[r]
        var i = p - 1
        var j = p
        while j < r {
            if (ord == 1 && vec[j] < x) || (ord == -1 && vec[j] > x) {
                i += 1
                swap(&vec[Int(j)], &vec[Int(i)])
            }
            j += 1
        }
        i += 1
        swap(&vec[Int(i)], &vec[Int(r)])
        return i
    }

    if p < r {
        let q = partition(vec, p: p, r: r, ord: ord)
        quicksort(vec, len, ord, p: p, r: q - 1)
        quicksort(vec, len, ord, p: q + 1, r: r)
    }
}
#endif
