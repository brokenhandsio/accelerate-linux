import AccelerateLinux
import Foundation
import Testing

@Suite("LAPACK Tests")
struct LAPACKTests {
    // https://www.intel.com/content/www/us/en/docs/onemkl/code-samples-lapack/2022-1/dgesvd-example-c.html
    @Test("dgesvd_simple")
    func dgesvd_simpleTest() {
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

        // 10^2 (100) because we want the first two decimal places
        #expect(
            s.map {
                ($0 * pow(10, 2)).rounded() / pow(10, 2)
            } == [27.47, 22.64, 8.56, 5.99, 2.01])

        // Note: if we care about orthogonality of U and V we should check those too
    }
}
