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
}
