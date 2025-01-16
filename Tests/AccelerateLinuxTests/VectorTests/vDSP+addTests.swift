import AccelerateLinux
import Testing

@Suite("vDSP+add Test")
struct vDSPaddTests {
    @Test("vDSP.add scalar + vector")
    func vDSPaddScalarVector() {
        let a: [Double] = [1, 2, 3, 4, 5]
        let b: Double = 10

        let c = vDSP.add(b, a)

        #expect(c == [11.0, 22.0, 33.0, 44.0, 55.0])
    }
}
