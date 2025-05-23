#if canImport(Accelerate)
@_exported import Accelerate
#else
import CLAPACK

/// DGESV computes the solution to a real system of linear equations
///     A * X = B,
/// where A is an N-by-N matrix and X and B are N-by-NRHS matrices.
/// The LU decomposition with partial pivoting and row interchanges is
/// used to factor A as
///     A = P * L * U,
/// where P is a permutation matrix, L is unit lower triangular, and U is
/// upper triangular.  The factored form of A is then used to solve the
/// system of equations A * X = B.
@inlinable
@_extern(c, "dgesv_")
public func dgesv_(
    _ n: UnsafePointer<__LAPACK_int>,
    _ nrhs: UnsafePointer<__LAPACK_int>,
    _ a: UnsafeMutablePointer<Double>?,
    _ lda: UnsafePointer<__LAPACK_int>,
    _ ipiv: UnsafeMutablePointer<__LAPACK_int>?,
    _ b: UnsafeMutablePointer<Double>?,
    _ ldb: UnsafePointer<__LAPACK_int>,
    _ info: UnsafeMutablePointer<__LAPACK_int>
)

/// Computes the singular value decomposition (SVD) of a real
/// M-by-N matrix A, optionally computing the left and/or right singular
/// vectors. The SVD is written
///
///    `A = U * SIGMA * transpose(V)`
///
/// where SIGMA is an M-by-N matrix which is zero except for its
/// min(m,n) diagonal elements, U is an M-by-M orthogonal matrix, and
/// V is an N-by-N orthogonal matrix.  The diagonal elements of SIGMA
/// are the singular values of A; they are real and non-negative, and
/// are returned in descending order. The first min(m,n) columns of
/// U and V are the left and right singular vectors of A.
///
/// Note: that the routine returns V**T, not V.
@inlinable
@_extern(c, "dgesvd_")
public func dgesvd_(
    _ jobu: UnsafePointer<CChar>,
    _ jobvt: UnsafePointer<CChar>,
    _ m: UnsafePointer<__LAPACK_int>,
    _ n: UnsafePointer<__LAPACK_int>,
    _ a: UnsafeMutablePointer<Double>?,
    _ lda: UnsafePointer<__LAPACK_int>,
    _ s: UnsafeMutablePointer<Double>?,
    _ u: UnsafeMutablePointer<Double>?,
    _ ldu: UnsafePointer<__LAPACK_int>,
    _ vt: UnsafeMutablePointer<Double>?,
    _ ldvt: UnsafePointer<__LAPACK_int>,
    _ work: UnsafeMutablePointer<Double>,
    _ lwork: UnsafePointer<__LAPACK_int>,
    _ info: UnsafeMutablePointer<__LAPACK_int>)

/// Computes an LU factorization of a general M-by-N matrix A
/// using partial pivoting with row interchanges.
///
/// The factorization has the form
///    A = P * L * U
/// where P is a permutation matrix, L is lower triangular with unit
/// diagonal elements (lower trapezoidal if m > n), and U is upper
/// triangular (upper trapezoidal if m < n).
///
/// This is the right-looking Level 3 BLAS version of the algorithm.
@inlinable
@_extern(c, "dgetrf_")
public func dgetrf_(
    _ m: UnsafePointer<__LAPACK_int>,
    _ n: UnsafePointer<__LAPACK_int>,
    _ a: UnsafeMutablePointer<Double>?,
    _ lda: UnsafePointer<__LAPACK_int>,
    _ ipiv: UnsafeMutablePointer<__LAPACK_int>?,
    _ info: UnsafeMutablePointer<__LAPACK_int>
)

/// Computes the inverse of a matrix using the LU factorization
/// computed by ``dgterf_``.
///
/// This method inverts U and then computes `inv(A)` by solving the system
/// `inv(A)*L = inv(U) for inv(A)`.
@inlinable
@_extern(c, "dgetri_")
public func dgetri_(
    _ n: UnsafePointer<__LAPACK_int>,
    _ a: UnsafeMutablePointer<Double>?,
    _ lda: UnsafePointer<__LAPACK_int>,
    _ ipiv: UnsafePointer<__LAPACK_int>?,
    _ work: UnsafeMutablePointer<Double>,
    _ lwork: UnsafePointer<__LAPACK_int>,
    _ info: UnsafeMutablePointer<__LAPACK_int>
)

/// Computes for an N-by-N real nonsymmetric matrix A, the
/// eigenvalues and, optionally, the left and/or right eigenvectors.
///
/// The right eigenvector v(j) of A satisfies
///                  `A * v(j) = lambda(j) * v(j)`
/// where lambda(j) is its eigenvalue.
/// The left eigenvector u(j) of A satisfies
///               `u(j)**H * A = lambda(j) * u(j)**H`
/// where `u(j)**H` denotes the conjugate-transpose of `u(j)`.
///
/// The computed eigenvectors are normalized to have Euclidean norm
/// equal to 1 and largest component real.
@inlinable
@_extern(c, "dgeev_")
public func dgeev_(
    _ __jobvl: UnsafeMutablePointer<CChar>!,
    _ __jobvr: UnsafeMutablePointer<CChar>!,
    _ __n: UnsafeMutablePointer<__LAPACK_int>!,
    _ __a: UnsafeMutablePointer<Double>!,
    _ __lda: UnsafeMutablePointer<__LAPACK_int>!,
    _ __wr: UnsafeMutablePointer<Double>!,
    _ __wi: UnsafeMutablePointer<Double>!,
    _ __vl: UnsafeMutablePointer<Double>!,
    _ __ldvl: UnsafeMutablePointer<__LAPACK_int>!,
    _ __vr: UnsafeMutablePointer<Double>!,
    _ __ldvr: UnsafeMutablePointer<__LAPACK_int>!,
    _ __work: UnsafeMutablePointer<Double>!,
    _ __lwork: UnsafeMutablePointer<__LAPACK_int>!,
    _ __info: UnsafeMutablePointer<__LAPACK_int>!
)

/// Computes the Cholesky factorization of a real symmetric positive definite matrix A.
///
/// The factorization has the form
///   A = U**T * U,  if UPLO = 'U', or
///   A = L * L**T,  if UPLO = 'L',
/// where U is an upper triangular matrix and L is lower triangular.
///
/// This is the block version of the algorithm, calling Level 3 BLAS.
@inlinable
@_extern(c, "dpotrf_")
public func dpotrf_(
    _ uplo: UnsafePointer<CChar>,
    _ n: UnsafePointer<__LAPACK_int>,
    _ a: UnsafeMutablePointer<Double>?,
    _ lda: UnsafePointer<__LAPACK_int>,
    _ info: UnsafeMutablePointer<__LAPACK_int>
)

/// Solves a triangular system of the form
///   `A * X = B`  or  `A**T * X = B`,
/// where A is a triangular matrix of order N, and B is an N-by-NRHS matrix.
/// A check is made to verify that A is nonsingular.
@inlinable
@_extern(c, "dtrtrs_")
public func dtrtrs_(
    _ uplo: UnsafePointer<CChar>,
    _ trans: UnsafePointer<CChar>,
    _ diag: UnsafePointer<CChar>,
    _ n: UnsafePointer<__LAPACK_int>,
    _ nrhs: UnsafePointer<__LAPACK_int>,
    _ a: UnsafePointer<Double>?,
    _ lda: UnsafePointer<__LAPACK_int>,
    _ b: UnsafeMutablePointer<Double>?,
    _ ldb: UnsafePointer<__LAPACK_int>,
    _ info: UnsafeMutablePointer<__LAPACK_int>
)
#endif  // canImport(Accelerate)
