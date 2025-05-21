#if canImport(Accelerate)
@_exported import Accelerate
#else
import CBLAS

/// Multiplies two matrices (double-precision).
/// - Parameters:
///  - __Order: Specifies row-major (C) or column-major (Fortran) data ordering.
///  - __TransA: Specifies whether to transpose matrix A.
///  - __TransB: Specifies whether to transpose matrix B.
///  - __M: Number of rows in matrices A and C.
///  - __N: Number of columns in matrices B and C.
///  - __K: Number of columns in matrix A; number of rows in matrix B.
///  - __alpha: Scaling factor for the product of matrices A and B.
///  - __A: Matrix A.
///  - __lda: The size of the first dimension of matrix A; if you are passing a matrix A[m][n], the value should be m.
///  - __B: Matrix B.
///  - __ldb: The size of the first dimension of matrix B; if you are passing a matrix B[m][n], the value should be m.
///  - __beta: Scaling factor for matrix C.
///  - __C: Matrix C.
///  - __ldc: The size of the first dimension of matrix C; if you are passing a matrix C[m][n], the value should be m.
/// This function multiplies A * B and multiplies the resulting matrix by alpha. It then multiplies matrix C by beta.
/// It stores the sum of these two products in matrix C.
/// Thus, it calculates either
///     C←αAB + βC
/// or
///     C←αBA + βC
/// with optional use of transposed forms of A, B, or both.
@inlinable
@inline(__always)
public func cblas_dgemm(
    _ __Order: CBLAS_ORDER,
    _ __TransA: CBLAS_TRANSPOSE,
    _ __TransB: CBLAS_TRANSPOSE,
    _ __M: blasint,
    _ __N: blasint,
    _ __K: blasint,
    _ __alpha: Double,
    _ __A: UnsafePointer<Double>!,
    _ __lda: blasint,
    _ __B: UnsafePointer<Double>!,
    _ __ldb: blasint,
    _ __beta: Double,
    _ __C: UnsafeMutablePointer<Double>!,
    _ __ldc: blasint
) {
    CBLAS.cblas_dgemm(__Order, __TransA, __TransB, __M, __N, __K, __alpha, __A, __lda, __B, __ldb, __beta, __C, __ldc)
}
#endif  // canImport(Accelerate)
