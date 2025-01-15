import AccelerateLinux
import Foundation
import Testing

@Suite("BLAS Tests")
struct BLASTests {
    @Test("dgemm")
    // https://www.intel.com/content/www/us/en/docs/onemkl/tutorial-c/2021-4/multiplying-matrices-using-dgemm.html
    func test_dgemm() {
        let m: blasint = 2
        let n: blasint = 2
        let k: blasint = 3

        let A = [
            0.11, 0.12, 0.13,
            0.21, 0.22, 0.23,
        ]

        let B: [Double] = [
            1011, 1012,
            1021, 1022,
            1031, 1032,
        ]

        var C: [Double] = [
            0.00, 0.00,
            0.00, 0.00,
        ]

        let alpha = 1.0
        let beta = 0.0

        cblas_dgemm(
            CblasRowMajor,
            CblasNoTrans,
            CblasNoTrans,
            m,
            n,
            k,
            alpha,
            A,
            k,
            B,
            n,
            beta,
            &C,
            n
        )

        #expect(C == [367.76, 368.12, 674.0600000000001, 674.7199999999999])
    }
}
