import AccelerateLinux
import Foundation
import Testing

@Suite("Matrix Basic Ops Tests")
struct MatrixBasicOpsTests {
    @Test("mtransD")
    func vDSP_mtransDTest() {
        let source: [Double] = [
            1, 2, 3, 4,
            5, 6, 7, 8,
        ]

        let transposed = [Double](unsafeUninitializedCapacity: source.count) { buffer, unsafeUninitializedCapacity in
            vDSP_mtransD(source, 1, buffer.baseAddress!, 1, 4, 2)
            unsafeUninitializedCapacity = source.count
        }

        #expect(
            transposed == [
                1, 5,
                2, 6,
                3, 7,
                4, 8,
            ]
        )
    }

    // https://developer.apple.com/documentation/accelerate/1450386-vdsp_mmuld
    @Test("mmulD")
    func vDSP_mmulDTest() {
        let m: vDSP_Length = 2
        let n: vDSP_Length = 5
        let p: vDSP_Length = 3

        let a: [Double] = [
            1, 2, 3,
            4, 5, 6,
        ]

        let b: [Double] = [
            10, 11, 12, 13, 14,
            15, 16, 17, 18, 19,
            20, 21, 22, 23, 24,
        ]

        var c = [Double](repeating: 0, count: Int(m * n))

        let stride = 1
        vDSP_mmulD(a, stride, b, stride, &c, stride, m, n, p)

        #expect(
            c.map {
                ($0 * 100).rounded() / 100
            } == [
                100.0, 106.0, 112.0, 118.0, 124.0,
                235.0, 250.0, 265.0, 280.0, 295.0,
            ]
        )
    }
}
