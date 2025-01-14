import AccelerateLinux
import Foundation
import Testing

@Suite("vDSP Tests")
struct vDSPTests {
    @Test("maxvD Simple")
    func vDSP_maxvDSimpleTest() {
        let stride = vDSP_Stride(1)
        let a: [Double] = [-1.5, 2.25, 3.6, 0.2, -0.1, -4.3]
        let n = vDSP_Length(a.count)
        var c = Double()

        vDSP_maxvD(a, stride, &c, n)
        #expect(c == 3.6)
    }

    @Test("maxvD Empty Array")
    func vDSP_maxvDEmptyArrayTest() {
        let stride = vDSP_Stride(1)
        let a: [Double] = []
        let n = vDSP_Length(a.count)
        var c = Double()

        vDSP_maxvD(a, stride, &c, n)
        #expect(c == -Double.infinity)
    }

    @Test("minvD Simple")
    func vDSP_minvDSimpleTest() {
        let stride = vDSP_Stride(1)
        let a: [Double] = [-1.5, 2.25, 3.6, 0.2, -0.1, -4.3]
        let n = vDSP_Length(a.count)
        var c = Double()

        vDSP_minvD(a, stride, &c, n)
        #expect(c == -4.3)
    }

    @Test("minvD Empty Array")
    func vDSP_minvDEmptyArrayTest() {
        let stride = vDSP_Stride(1)
        let a: [Double] = []
        let n = vDSP_Length(a.count)
        var c = Double()

        vDSP_minvD(a, stride, &c, n)
        #expect(c == Double.infinity)
    }

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
