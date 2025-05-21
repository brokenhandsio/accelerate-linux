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
@_silgen_name("dgesv_")
public func dgesv_(
    _ __n: UnsafeMutablePointer<__CLPK_integer>!,
    _ __nrhs: UnsafeMutablePointer<__CLPK_integer>!,
    _ __a: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lda: UnsafeMutablePointer<__CLPK_integer>!,
    _ __ipiv: UnsafeMutablePointer<__CLPK_integer>!,
    _ __b: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __ldb: UnsafeMutablePointer<__CLPK_integer>!,
    _ __info: UnsafeMutablePointer<__CLPK_integer>!
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
@_silgen_name("dgesvd_")
public func dgesvd_(
    _ __jobu: UnsafeMutablePointer<CChar>!,
    _ __jobvt: UnsafeMutablePointer<CChar>!,
    _ __m: UnsafeMutablePointer<__CLPK_integer>!,
    _ __n: UnsafeMutablePointer<__CLPK_integer>!,
    _ __a: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lda: UnsafeMutablePointer<__CLPK_integer>!,
    _ __s: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __u: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __ldu: UnsafeMutablePointer<__CLPK_integer>!,
    _ __vt: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __ldvt: UnsafeMutablePointer<__CLPK_integer>!,
    _ __work: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lwork: UnsafeMutablePointer<__CLPK_integer>!,
    _ __info: UnsafeMutablePointer<__CLPK_integer>!
)

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
@_silgen_name("dgetrf_")
public func dgetrf_(
    _ __m: UnsafeMutablePointer<__CLPK_integer>!,
    _ __n: UnsafeMutablePointer<__CLPK_integer>!,
    _ __a: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lda: UnsafeMutablePointer<__CLPK_integer>!,
    _ __ipiv: UnsafeMutablePointer<__CLPK_integer>!,
    _ __info: UnsafeMutablePointer<__CLPK_integer>!
) -> Int32

/// Computes the inverse of a matrix using the LU factorization
/// computed by ``dgterf_``.
///
/// This method inverts U and then computes `inv(A)` by solving the system
/// `inv(A)*L = inv(U) for inv(A)`.
@inlinable
@_silgen_name("dgetri_")
public func dgetri_(
    _ __n: UnsafeMutablePointer<__CLPK_integer>!,
    _ __a: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lda: UnsafeMutablePointer<__CLPK_integer>!,
    _ __ipiv: UnsafeMutablePointer<__CLPK_integer>!,
    _ __work: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lwork: UnsafeMutablePointer<__CLPK_integer>!,
    _ __info: UnsafeMutablePointer<__CLPK_integer>!
) -> Int32

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
@_silgen_name("dgeev_")
public func dgeev_(
    _ __jobvl: UnsafeMutablePointer<CChar>!,
    _ __jobvr: UnsafeMutablePointer<CChar>!,
    _ __n: UnsafeMutablePointer<__CLPK_integer>!,
    _ __a: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lda: UnsafeMutablePointer<__CLPK_integer>!,
    _ __wr: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __wi: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __vl: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __ldvl: UnsafeMutablePointer<__CLPK_integer>!,
    _ __vr: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __ldvr: UnsafeMutablePointer<__CLPK_integer>!,
    _ __work: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lwork: UnsafeMutablePointer<__CLPK_integer>!,
    _ __info: UnsafeMutablePointer<__CLPK_integer>!
) -> Int32

/// Computes the Cholesky factorization of a real symmetric positive definite matrix A.
///
/// The factorization has the form
///   A = U**T * U,  if UPLO = 'U', or
///   A = L * L**T,  if UPLO = 'L',
/// where U is an upper triangular matrix and L is lower triangular.
///
/// This is the block version of the algorithm, calling Level 3 BLAS.
@inlinable
@_silgen_name("dpotrf_")
public func dpotrf_(
    _ __uplo: UnsafeMutablePointer<CChar>!,
    _ __n: UnsafeMutablePointer<__CLPK_integer>!,
    _ __a: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lda: UnsafeMutablePointer<__CLPK_integer>!,
    _ __info: UnsafeMutablePointer<__CLPK_integer>!
) -> Int32

/// Solves a triangular system of the form
///   `A * X = B`  or  `A**T * X = B`,
/// where A is a triangular matrix of order N, and B is an N-by-NRHS matrix.
/// A check is made to verify that A is nonsingular.
@inlinable
@_silgen_name("dtrtrs_")
public func dtrtrs_(
    _ __uplo: UnsafeMutablePointer<CChar>!,
    _ __trans: UnsafeMutablePointer<CChar>!,
    _ __diag: UnsafeMutablePointer<CChar>!,
    _ __n: UnsafeMutablePointer<__CLPK_integer>!,
    _ __nrhs: UnsafeMutablePointer<__CLPK_integer>!,
    _ __a: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __lda: UnsafeMutablePointer<__CLPK_integer>!,
    _ __b: UnsafeMutablePointer<__CLPK_doublereal>!,
    _ __ldb: UnsafeMutablePointer<__CLPK_integer>!,
    _ __info: UnsafeMutablePointer<__CLPK_integer>!
) -> Int32
#endif  // canImport(Accelerate)
