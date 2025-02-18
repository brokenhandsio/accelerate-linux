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

        var n = __CLPK_integer(N)
        var nrhs = __CLPK_integer(NRHS)
        var lda = __CLPK_integer(LDA)
        var ldb = __CLPK_integer(LDB)
        var info = __CLPK_integer(0)

        var ipiv = [__CLPK_integer](repeating: 0, count: Int(N))
        var a: [__CLPK_doublereal] = [
            6.80, -2.11, 5.66, 5.97, 8.23, -6.05, -3.30,
            5.36, -4.44, 1.08, -0.45, 2.58, -2.70, 0.27,
            9.04, 8.32, 2.71, 4.35, -7.17, 2.14, -9.67,
            -5.14, -7.26, 6.08, -6.87,
        ]

        var b: [__CLPK_doublereal] = [
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

        var m = __CLPK_integer(M)
        var n = __CLPK_integer(N)
        var lda = __CLPK_integer(LDA)
        var ldu = __CLPK_integer(LDU)
        var ldvt = __CLPK_integer(LDVT)
        var info = __CLPK_integer(0)
        var lwork = __CLPK_integer(-1)
        var wkopt = __CLPK_doublereal(0)

        var a: [__CLPK_doublereal] = [
            8.79, 6.11, -9.15, 9.57, -3.49, 9.84, 9.93, 6.91,
            -7.93, 1.64, 4.02, 0.15, 9.83, 5.04, 4.86, 8.83,
            9.80, -8.99, 5.45, -0.27, 4.85, 0.74, 10.00, -6.02,
            3.16, 7.98, 3.01, 5.80, 4.27, -5.31,
        ]

        var s = [__CLPK_doublereal](repeating: 0, count: Int(min(m, n)))
        var u = [__CLPK_doublereal](repeating: 0, count: Int(ldu * m))
        var vt = [__CLPK_doublereal](repeating: 0, count: Int(ldvt * n))

        let jobu = "A"
        let jobvt = "A"

        jobu.withCString { jobuPtr in
            jobvt.withCString { jobvtPtr in
                let mutableJobuPtr = UnsafeMutablePointer(mutating: jobuPtr)
                let mutableJobvtPtr = UnsafeMutablePointer(mutating: jobvtPtr)

                dgesvd_(mutableJobuPtr, mutableJobvtPtr, &m, &n, &a, &lda, &s, &u, &ldu, &vt, &ldvt, &wkopt, &lwork, &info)
            }
        }

        lwork = __CLPK_integer(wkopt)
        var work = [__CLPK_doublereal](repeating: 0, count: Int(lwork))

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

    // https://numericalalgorithmsgroup.github.io/LAPACK_Examples/examples/doc/dgetrf_example.html
    @Test("dgetrf_")
    func test_dgetrf_() {
        let M = 4
        let N = 4
        let LDA = M

        var m = __CLPK_integer(M)
        var n = __CLPK_integer(N)
        var lda = __CLPK_integer(LDA)
        var info = __CLPK_integer(0)

        var ipiv = [__CLPK_integer](repeating: 0, count: Int(min(m, n)))

        var a: [__CLPK_doublereal] = [
            1.80, 5.25, 1.58, -1.11,
            2.88, -2.95, -2.69, -0.66,
            2.05, -0.95, -2.90, -0.59,
            -0.89, -3.80, -1.04, 0.80,
        ]

        _ = dgetrf_(&m, &n, &a, &lda, &ipiv, &info)

        #expect(
            a.map {
                ($0 * pow(10, 2)).rounded() / pow(10, 2)
            } == [
                5.25, 0.34, 0.30, -0.21,
                -2.95, 3.89, -0.46, -0.33,
                -0.95, 2.38, -1.51, 0.00,
                -3.8, 0.41, 0.29, 0.13,
            ]
        )
    }

    // https://numericalalgorithmsgroup.github.io/LAPACK_Examples/examples/doc/dgetri_example.html
    @Test("dgetri_")
    func test_dgetri_() {
        let M = 4
        let N = 4
        let LDA = M

        var m = __CLPK_integer(M)
        var n = __CLPK_integer(N)
        var lda = __CLPK_integer(LDA)
        var info = __CLPK_integer(0)

        var ipiv = [__CLPK_integer](repeating: 0, count: Int(min(m, n)))

        var a: [__CLPK_doublereal] = [
            1.80, 5.25, 1.58, -1.11,
            2.88, -2.95, -2.69, -0.66,
            2.05, -0.95, -2.90, -0.59,
            -0.89, -3.80, -1.04, 0.80,
        ]

        // A is nonsymmetric and must be factorized first
        _ = dgetrf_(&m, &n, &a, &lda, &ipiv, &info)

        var work = [__CLPK_doublereal](repeating: 0.0, count: Int(m))
        var lwork = __CLPK_integer(64 * n)

        _ = dgetri_(&n, &a, &lda, &ipiv, &work, &lwork, &info)

        #expect(
            a.map {
                ($0 * pow(10, 2)).rounded() / pow(10, 2)
            } == [
                1.77, -0.12, 0.18, 2.49,
                0.58, -0.45, 0.45, 0.76,
                0.08, 0.41, -0.67, -0.04,
                4.82, -1.71, 1.48, 7.61,
            ]
        )
    }

    // https://www.intel.com/content/www/us/en/docs/onemkl/code-samples-lapack/2025-0/dgeev-example-c.html
    @Test("dgeev_")
    func test_dgeev_() {
        let N = 5
        let LDA = N
        let LDVL = N
        let LDVR = N

        var n = __CLPK_integer(N)
        var lda = __CLPK_integer(LDA)
        var ldvl = __CLPK_integer(LDVL)
        var ldvr = __CLPK_integer(LDVR)
        var info = __CLPK_integer(0)
        var lwork = __CLPK_integer(0)
        var wkopt = __CLPK_doublereal(0)
        var work = [__CLPK_doublereal](repeating: 0, count: Int(lwork))

        var a: [__CLPK_doublereal] = [
            -1.01, 3.98, 3.30, 4.43, 7.31,
            0.86, 0.53, 8.26, 4.96, -6.43,
            -4.60, -7.04, -3.89, -7.66, -6.16,
            3.31, 5.29, 8.20, -7.33, 2.47,
            -4.81, 3.55, -1.51, 6.18, 5.58,
        ]

        var wr = [__CLPK_doublereal](repeating: 0, count: Int(n))
        var wi = [__CLPK_doublereal](repeating: 0, count: Int(n))
        var vl = [__CLPK_doublereal](repeating: 0, count: Int(ldvl * n))
        var vr = [__CLPK_doublereal](repeating: 0, count: Int(ldvr * n))

        let jobvl = "N"
        let jobvr = "V"

        jobvl.withCString { jobvlPtr in
            jobvr.withCString { jobvrPtr in
                let mutableJobvlPtr = UnsafeMutablePointer(mutating: jobvlPtr)
                let mutableJobvrPtr = UnsafeMutablePointer(mutating: jobvrPtr)

                lwork = -1
                _ = dgeev_(
                    mutableJobvlPtr, mutableJobvrPtr, &n, &a, &lda, &wr, &wi, &vl, &ldvl, &vr, &ldvr, &wkopt, &lwork, &info
                )

                lwork = __CLPK_integer(wkopt)
                work = [__CLPK_doublereal](repeating: 0, count: Int(lwork))

                _ = dgeev_(
                    mutableJobvlPtr, mutableJobvrPtr, &n, &a, &lda, &wr, &wi, &vl, &ldvl, &vr, &ldvr, &work, &lwork, &info
                )
            }
        }

        if info != 0 {
            Issue.record("The algorithm failed to compute eigenvalues.")
            return
        }

        // Check Eigenvalues
        let expected = [(2.86, 10.76), (2.86, -10.76), (-0.69, 4.70), (-0.69, -4.70), (-10.46, 0.00)]
        #expect(
            wr.map {
                ($0 * 100).rounded() / 100
            } == expected.map { $0.0 }
        )

        #expect(
            wi.map {
                ($0 * 100).rounded() / 100
            } == expected.map { $0.1 }
        )
    }

    // https://numericalalgorithmsgroup.github.io/LAPACK_Examples/examples/doc/dpotrf_example.html
    @Test("dpotrf_")
    func test_dpotrf_() {
        let N = 4
        let LDA = N

        var n = __CLPK_integer(N)
        var lda = __CLPK_integer(LDA)
        var info = __CLPK_integer(0)

        var a: [__CLPK_doublereal] = [
            4.16, -3.12, 0.56, -0.10,
            0.00, 5.03, -0.83, 1.18,
            0.00, 0.00, 0.76, 0.34,
            0.00, 0.00, 0.00, 1.18,
        ]

        "L".withCString { uploPtr in
            let mutableUploPtr = UnsafeMutablePointer(mutating: uploPtr)
            _ = dpotrf_(mutableUploPtr, &n, &a, &lda, &info)
        }

        #expect(
            a.map {
                ($0 * pow(10, 2)).rounded() / pow(10, 2)
            } == [
                2.04, -1.53, 0.27, -0.05,
                0.00, 1.64, -0.25, 0.67,
                0.00, 0.00, 0.79, 0.66,
                0.00, 0.00, 0.00, 0.53,
            ]
        )
    }

    // https://numericalalgorithmsgroup.github.io/LAPACK_Examples/examples/doc/dtrtrs_example.html
    @Test("dtrtrs_")
    func test_dtrtrs_() {
        let N = 4
        let NRHS = 2
        let LDA = N

        var n = __CLPK_integer(N)
        var nrhs = __CLPK_integer(NRHS)
        var lda = __CLPK_integer(LDA)
        var ldb = __CLPK_integer(N)
        var info = __CLPK_integer(0)

        var a: [__CLPK_doublereal] = [
            4.30, -3.96, 0.40, -0.27,
            0.00, -4.87, 0.31, 0.07,
            0.00, 0.00, -8.02, -5.95,
            0.00, 0.00, 0.00, 0.12,
        ]

        var b: [__CLPK_doublereal] = [
            -12.90, 16.75, -17.55, -11.04,
            -21.50, 14.93, 6.33, 8.09,
        ]

        "L".withCString { uploPtr in
            "N".withCString { transPtr in
                "N".withCString { diagPtr in
                    let mutableUploPtr = UnsafeMutablePointer(mutating: uploPtr)
                    let mutableTransPtr = UnsafeMutablePointer(mutating: transPtr)
                    let mutableDiagPtr = UnsafeMutablePointer(mutating: diagPtr)
                    _ = dtrtrs_(mutableUploPtr, mutableTransPtr, mutableDiagPtr, &n, &nrhs, &a, &lda, &b, &ldb, &info)
                }
            }
        }

        #expect(
            b.map {
                ($0 * pow(10, 2)).rounded() / pow(10, 2)
            } == [
                -3.00, -1.00, 2.00, 1.00,
                -5.00, 1.00, -1.00, 6.00,
            ]
        )
    }
}
