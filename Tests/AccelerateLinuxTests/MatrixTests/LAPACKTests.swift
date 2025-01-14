#if ACCELERATE_NEW_LAPACK
import AccelerateLinux
import Foundation
import Testing

@Suite("LAPACK Tests")
struct LAPACKTests {
    // https://www.intel.com/content/www/us/en/docs/onemkl/code-samples-lapack/2022-1/dgesv-example-c.html
    @Test("dgesv_")
    func test_dgesv_() {
        let N = 5
        let NRHS = 3
        let LDA = N
        let LDB = N

        var n = __LAPACK_int(N)
        var nrhs = __LAPACK_int(NRHS)
        var lda = __LAPACK_int(LDA)
        var ldb = __LAPACK_int(LDB)
        var info = __LAPACK_int(0)

        var ipiv = [__LAPACK_int](repeating: 0, count: Int(N))
        var a: [__LAPACK_doublereal] = [
            6.80, -2.11, 5.66, 5.97, 8.23, -6.05, -3.30,
            5.36, -4.44, 1.08, -0.45, 2.58, -2.70, 0.27,
            9.04, 8.32, 2.71, 4.35, -7.17, 2.14, -9.67,
            -5.14, -7.26, 6.08, -6.87,
        ]

        var b: [__LAPACK_doublereal] = [
            4.02, 6.19, -8.22, -7.57, -3.03, -1.56, 4.00, -8.67,
            1.75, 2.86, 9.81, -4.09, -4.57, -8.61, 8.99,
        ]

        dgesv_(&n, &nrhs, &a, &lda, &ipiv, &b, &ldb, &info)

        if info > 0 {
            Issue.record(
                "The diagonal element of the triangular factor of A, U, is zero. The factorization has been completed, but the factor U is exactly singular, so the solution could not be computed."
            )
            return
        }

        #expect(
            b.map {
                ($0 * pow(10, 2)).rounded() / pow(10, 2)
            } == [-0.80, -0.70, 0.59, 1.32, 0.57, -0.39, -0.55, 0.84, -0.10, 0.11, 0.96, 0.22, 1.90, 5.36, 4.04]
        )
    }

    // https://www.intel.com/content/www/us/en/docs/onemkl/code-samples-lapack/2022-1/dgesvd-example-c.html
    @Test("dgesvd_")
    func test_dgesvd_() {
        let M = 6
        let N = 5
        let LDA = M
        let LDU = M
        let LDVT = N

        var m = __LAPACK_int(M)
        var n = __LAPACK_int(N)
        var lda = __LAPACK_int(LDA)
        var ldu = __LAPACK_int(LDU)
        var ldvt = __LAPACK_int(LDVT)
        var info = __LAPACK_int(0)
        var lwork = __LAPACK_int(-1)
        var wkopt = __LAPACK_doublereal(0)

        var a: [__LAPACK_doublereal] = [
            8.79, 6.11, -9.15, 9.57, -3.49, 9.84, 9.93, 6.91,
            -7.93, 1.64, 4.02, 0.15, 9.83, 5.04, 4.86, 8.83,
            9.80, -8.99, 5.45, -0.27, 4.85, 0.74, 10.00, -6.02,
            3.16, 7.98, 3.01, 5.80, 4.27, -5.31,
        ]

        var s = [__LAPACK_doublereal](repeating: 0, count: Int(min(m, n)))
        var u = [__LAPACK_doublereal](repeating: 0, count: Int(ldu * m))
        var vt = [__LAPACK_doublereal](repeating: 0, count: Int(ldvt * n))

        let jobu = "A"
        let jobvt = "A"

        jobu.withCString { jobuPtr in
            jobvt.withCString { jobvtPtr in
                let mutableJobuPtr = UnsafeMutablePointer(mutating: jobuPtr)
                let mutableJobvtPtr = UnsafeMutablePointer(mutating: jobvtPtr)

                dgesvd_(mutableJobuPtr, mutableJobvtPtr, &m, &n, &a, &lda, &s, &u, &ldu, &vt, &ldvt, &wkopt, &lwork, &info)
            }
        }

        lwork = __LAPACK_int(wkopt)
        var work = [__LAPACK_doublereal](repeating: 0, count: Int(lwork))

        jobu.withCString { jobuPtr in
            jobvt.withCString { jobvtPtr in
                let mutableJobuPtr = UnsafeMutablePointer(mutating: jobuPtr)
                let mutableJobvtPtr = UnsafeMutablePointer(mutating: jobvtPtr)

                dgesvd_(mutableJobuPtr, mutableJobvtPtr, &m, &n, &a, &lda, &s, &u, &ldu, &vt, &ldvt, &work, &lwork, &info)
            }
        }

        if info > 0 {
            Issue.record("The algorithm computing SVD failed to converge.")
            return
        }

        #expect(
            s.map {
                ($0 * pow(10, 2)).rounded() / pow(10, 2)
            } == [27.47, 22.64, 8.56, 5.99, 2.01]
        )

        // Note: if we care about orthogonality of U and V we should check those too
    }
}
#endif
