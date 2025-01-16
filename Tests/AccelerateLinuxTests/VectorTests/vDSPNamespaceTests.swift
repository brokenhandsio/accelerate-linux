import AccelerateLinux
import Testing

@Suite("vDSP Namespace Test")
struct vDSDNamespaceTests {
    @Test("vDSP.add scalar + vector")
    func vDSPaddScalarVector() {
        let a: [Double] = [1, 2, 3, 4, 5]
        let b: Double = 10

        let c = vDSP.add(b, a)

        #expect(c == [11.0, 22.0, 33.0, 44.0, 55.0])
    }

    @Test("vDSP.add vector + vector")
    func vDSPaddVectorVector() {
        let a: [Double] = [1, 2, 3, 4, 5]
        let b: [Double] = [10, 20, 30, 40, 50]

        let c = vDSP.add(a, b)

        #expect(c == [11.0, 22.0, 33.0, 44.0, 55.0])
    }

    @Test("vDSP.sum")
    func vDSPsum() {
        let a: [Double] = [
            -1.5, 2.25, 3.6,
            0.2, -0.1, -4.3,
        ]

        let sum = vDSP.sum(a)

        #expect((sum * 100).rounded() / 100 == 0.15)
    }

    @Test("vDSP.subtract vector - vector")
    func vDSPsubVectorVector() {
        let a: [Double] = [10, 20, 30, 40, 50]
        let b: [Double] = [1, 2, 3, 4, 5]

        let c = vDSP.subtract(a, b)

        #expect(c == [9.0, 18.0, 27.0, 36.0, 45.0])
    }

    @Test("vDSP.multiply double vector * double vector")
    func vDSPmuldVectordVector() {
        let a: [Double] = [10, 20, 30, 40, 50]
        let b: [Double] = [1, 2, 3, 4, 5]

        let c = vDSP.multiply(a, b)

        #expect(c == [10.0, 40.0, 90.0, 160.0, 250.0])
    }

    @Test("vDSP.multiply vector * vector")
    func vDSPmulVectorVector() {
        let a: [Float] = [10, 20, 30, 40, 50]
        let b: [Float] = [1, 2, 3, 4, 5]

        let c = vDSP.multiply(a, b)

        #expect(c == [10.0, 40.0, 90.0, 160.0, 250.0])
    }

    @Test("vDSP.multiply vector * scalar")
    func vDSPmuldVectorScalar() {
        let a: [Double] = [1, 2, 3, 4, 5]
        let b: Double = 10

        let c = vDSP.multiply(b, a)

        #expect(c == [10.0, 20.0, 30.0, 40.0, 50.0])
    }
}
