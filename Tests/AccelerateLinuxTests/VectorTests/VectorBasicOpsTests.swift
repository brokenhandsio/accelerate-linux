import AccelerateLinux
import Testing

@Suite("Vector Basic Ops Tests")
struct VectorBasicOpsTests {

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

    // https://developer.apple.com/documentation/accelerate/1449910-vdsp_vaddd
    @Test("vaddD")
    func vDSP_vaddDTest() {
        let stride = 1
        let count = 5

        let a: [Double] = [1, 2, 3, 4, 5]
        let b: [Double] = [10, 20, 30, 40, 50]

        let c = [Double](unsafeUninitializedCapacity: count) { buffer, initializedCount in
            vDSP_vaddD(
                a,
                stride,
                b,
                stride,
                buffer.baseAddress!,
                stride,
                vDSP_Length(count)
            )
            initializedCount = count
        }

        #expect(c == [11.0, 22.0, 33.0, 44.0, 55.0])
    }

    // https://developer.apple.com/documentation/accelerate/1449743-vdsp_vsubd
    @Test("vsubD")
    func vDSP_vsubDTest() {
        let stride = 1
        let count = 5

        let a: [Double] = [10, 20, 30, 40, 50]
        let b: [Double] = [1, 2, 3, 4, 5]

        let c = [Double](unsafeUninitializedCapacity: count) {
            buffer, initializedCount in

            vDSP_vsubD(
                b,
                stride,
                a,
                stride,
                buffer.baseAddress!,
                stride,
                vDSP_Length(count)
            )

            initializedCount = count
        }

        #expect(c == [9.0, 18.0, 27.0, 36.0, 45.0])
    }
}
