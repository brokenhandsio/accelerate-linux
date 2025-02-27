import AccelerateLinux
import FoundationEssentials
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
                b, stride,
                a, stride,
                buffer.baseAddress!, stride,
                vDSP_Length(count)
            )

            initializedCount = count
        }

        #expect(c == [9.0, 18.0, 27.0, 36.0, 45.0])
    }

    // https://developer.apple.com/documentation/accelerate/1450138-vdsp_vmuld
    @Test("vmulD")
    func vDSP_vmulDTest() {
        let stride = 1
        let count = 5

        let a: [Double] = [1, 2, 3, 4, 5]
        let b: [Double] = [10, 20, 30, 40, 50]

        let c = [Double](unsafeUninitializedCapacity: count) { buffer, initializedCount in
            vDSP_vmulD(
                a, stride,
                b, stride,
                buffer.baseAddress!, stride,
                vDSP_Length(count)
            )
            initializedCount = count
        }

        #expect(c == [10.0, 40.0, 90.0, 160.0, 250.0])
    }

    @Test("vvpow")
    func vvpowTest() {
        var x: [Double] = [3, 2, 10, 6]
        var y: [Double] = [2, 4, 3, 2]
        var z = [Double](repeating: 0, count: x.count)
        var n = Int32(x.count)

        vvpow(&z, &y, &x, &n)
        #expect(z == [9.0, 16.0, 1000.0, 36.0])
    }

    // https://developer.apple.com/documentation/accelerate/1450639-vdsp_vclrd
    @Test("vDSP_vclrD")
    func vDSP_vclrDTest() {
        let n = vDSP_Length(10)
        let stride = vDSP_Stride(1)

        var c = [Double](
            repeating: .nan,
            count: Int(n))

        vDSP_vclrD(&c, stride, n)

        #expect(c == [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])
    }

    // https://developer.apple.com/documentation/accelerate/1450171-vdsp_vfilld
    @Test("vDSP_vfillD")
    func vDSP_vfillDTest() {
        let n = vDSP_Length(10)
        let stride = vDSP_Stride(1)

        var a = Double.pi

        let c = [Double](unsafeUninitializedCapacity: Int(n)) { buffer, initializedCount in
            vDSP_vfillD(&a, buffer.baseAddress!, stride, n)
            initializedCount = Int(n)
        }

        #expect(
            c.map {
                ($0 * 100).rounded() / 100
            } == [
                3.14, 3.14, 3.14,
                3.14, 3.14, 3.14,
                3.14, 3.14, 3.14,
                3.14,
            ])
    }

    // https://developer.apple.com/documentation/accelerate/1449982-vdsp_vabsd
    @Test("vDSP_vabsD")
    func vDSP_vabsDTest() {
        let stride = 1
        let values: [Double] = [-1, 2, -3, 4, -5, 6, -7, 8]
        let absoluteValues = [Double](unsafeUninitializedCapacity: values.count) { buffer, initializedCount in
            vDSP_vabsD(
                values, stride,
                buffer.baseAddress!, stride,
                vDSP_Length(values.count)
            )
            initializedCount = values.count
        }

        #expect(absoluteValues == [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])
    }

    // https://developer.apple.com/documentation/accelerate/1450346-vdsp_vnegd
    @Test("vDSP_vnegD")
    func vDSP_vnegDTest() {
        let stride = 1
        let values: [Double] = [-1, 2, -3, 4, -5, 6, -7, 8]
        let negativeValues = [Double](unsafeUninitializedCapacity: values.count) { buffer, initializedCount in
            vDSP_vnegD(
                values, stride,
                buffer.baseAddress!, stride,
                vDSP_Length(values.count)
            )
            initializedCount = values.count
        }

        #expect(negativeValues == [1.0, -2.0, 3.0, -4.0, 5.0, -6.0, 7.0, -8.0])
    }

    @Test("vDSP_vsqD")
    func vDSP_vsqDTest() {
        let stride = 1
        let values: [Double] = [-1, 2, -3, 4, -5, 6, -7, 8]
        let negativeValues = [Double](unsafeUninitializedCapacity: values.count) { buffer, initializedCount in
            vDSP_vsqD(
                values, stride,
                buffer.baseAddress!, stride,
                vDSP_Length(values.count)
            )
            initializedCount = values.count
        }

        #expect(negativeValues == [1.0, 4.0, 9.0, 16.0, 25.0, 36.0, 49.0, 64.0])
    }

    @Test("vDSP_vsqD")
    func vDSP_dotprDTest() {
        let stride = 1
        let n = 3

        let a: [Double] = [1.0, 2.0, 3.0]
        let b: [Double] = [4.0, 5.0, 6.0]

        var c = Double()

        vDSP_dotprD(
            a, stride,
            b, stride,
            &c,
            vDSP_Length(n)
        )

        #expect(c == 32)
    }

    @Test("vDSP_vlimD")
    func vDSP_vlimDTest() {
        let stride = 1
        let n = 4

        let a: [Double] = [-2.0, 0.0, 3.0, 5.0]
        let min = 1.0
        let max = 4.0
        var b = min  // Lower bound
        var c = max  // Upper bound
        var d = [Double](repeating: 0.0, count: 4)
        var nLow = vDSP_Length(0)  // Count of values below min
        var nHigh = vDSP_Length(0)  // Count of values above max

        vDSP_vclipcD(
            a, stride,
            &b, &c,
            &d, stride,
            vDSP_Length(n),
            &nLow, &nHigh
        )

        #expect(d == [1.0, 1.0, 3.0, 4.0])
        #expect(nLow == 2)
        #expect(nHigh == 1)
    }

    @Test("vDSP_vrsumD")
    func vDSP_vrsumDTest() {
        let stride = 1
        let n = 4

        let a: [Double] = [1.0, 2.0, 3.0, 4.0]
        var startValue: Double = 10.0

        let c = [Double](unsafeUninitializedCapacity: n) { buffer, initializedCount in
            vDSP_vrsumD(
                a, stride,
                &startValue,
                buffer.baseAddress!, stride,
                vDSP_Length(n)
            )
            initializedCount = n
        }

        #expect(c == [0.0, 20.0, 50.0, 90.0])
    }

    @Test("vDSP_vsortD")
    func vDSP_vsortDTest() {
        var a: [Double] = [15.0, 3.0, 9.0, -23.0]

        vDSP_vsortD(
            &a,
            4,
            1
        )

        #expect(a == [-23.0, 3.0, 9.0, 15.0])
    }

    @Test("vDSP_vrampD")
    func vDSP_vrampDTest() {
        let n = 8
        let stride = 1

        var initialValue: Double = 0
        var increment: Double = 1

        let ramp = [Double](unsafeUninitializedCapacity: n) {
            buffer, initializedCount in

            vDSP_vrampD(
                &initialValue,
                &increment,
                buffer.baseAddress!,
                stride,
                vDSP_Length(n))

            initializedCount = n
        }

        #expect(ramp == [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0])
    }

    @Test("vDSP_vminD")
    func vDSP_vminDTest() {
        let stride = 1
        let n = 4

        let a: [Double] = [1.0, 2.0, 3.0, 4.0]
        let b: [Double] = [4.0, 3.0, 2.0, 1.0]

        let c = [Double](unsafeUninitializedCapacity: n) {
            buffer, initializedCount in

            vDSP_vminD(
                a, stride,
                b, stride,
                buffer.baseAddress!, stride,
                vDSP_Length(n)
            )

            initializedCount = n
        }

        #expect(c == [1.0, 2.0, 2.0, 1.0])
    }

    @Test("vDSP_vmaxD")
    func vDSP_vmaxDTest() {
        let stride = 1
        let n = 4

        let a: [Double] = [1.0, 2.0, 3.0, 4.0]
        let b: [Double] = [4.0, 3.0, 2.0, 1.0]

        let c = [Double](unsafeUninitializedCapacity: n) {
            buffer, initializedCount in

            vDSP_vmaxD(
                a, stride,
                b, stride,
                buffer.baseAddress!, stride,
                vDSP_Length(n)
            )

            initializedCount = n
        }

        #expect(c == [4.0, 3.0, 3.0, 4.0])
    }

    @Test("vDSP_vdivD")
    func vDSP_vdivDTest() {
        let stride = 1
        let count = 5

        let b: [Double] = [10, 20, 30, 40, 50]
        let a: [Double] = [1, 2, 3, 4, 5]

        let c = [Double](unsafeUninitializedCapacity: count) {
            buffer, initializedCount in

            vDSP_vdivD(
                a, stride,
                b, stride,
                buffer.baseAddress!, stride,
                vDSP_Length(count))

            initializedCount = count
        }

        #expect(c == [10.0, 10.0, 10.0, 10.0, 10.0])
    }
}
