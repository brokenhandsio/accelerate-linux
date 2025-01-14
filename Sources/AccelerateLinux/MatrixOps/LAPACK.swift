#if canImport(Accelerate)
@_exported import Accelerate
#else
import CBLAS
import CLAPACK

/// DGESVD computes the singular value decomposition (SVD) of a real
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
#if ACCELERATE_NEW_LAPACK
@_silgen_name("dgesvd_")
public func dgesvd_(
    _ __jobu: UnsafeMutablePointer<CChar>!,
    _ __jobvt: UnsafeMutablePointer<CChar>!,
    _ __m: UnsafeMutablePointer<__LAPACK_int>!,
    _ __n: UnsafeMutablePointer<__LAPACK_int>!,
    _ __a: UnsafeMutablePointer<__LAPACK_doublereal>!,
    _ __lda: UnsafeMutablePointer<__LAPACK_int>!,
    _ __s: UnsafeMutablePointer<__LAPACK_doublereal>!,
    _ __u: UnsafeMutablePointer<__LAPACK_doublereal>!,
    _ __ldu: UnsafeMutablePointer<__LAPACK_int>!,
    _ __vt: UnsafeMutablePointer<__LAPACK_doublereal>!,
    _ __ldvt: UnsafeMutablePointer<__LAPACK_int>!,
    _ __work: UnsafeMutablePointer<__LAPACK_doublereal>!,
    _ __lwork: UnsafeMutablePointer<__LAPACK_int>!,
    _ __info: UnsafeMutablePointer<__LAPACK_int>!
)
#else
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
#endif  // ACCELERATE_NEW_LAPACK
#endif  // canImport(Accelerate)
