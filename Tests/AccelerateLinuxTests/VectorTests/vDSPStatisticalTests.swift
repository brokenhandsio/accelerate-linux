import AccelerateLinux
import Testing

@Suite("vDSP Statistical Test")
struct vDSDStatisticalTests {
    @Test("vDSP.mean")
    func vDSPmean() {
        let a: [Double] = [-8, -4, -2, 0, 2, 4, 8]

        let mean = vDSP.mean(a)

        #expect(mean == 0.0)
    }
}
