import AccelerateLinux
import Testing

@Suite("vDSP Tests")
struct vDSPTests {
    @Test("maxvD Simple")
    func vDSP_maxvDSimpleTest() async throws {
        let stride = vDSP_Stride(1)
        let a: [Double] = [-1.5, 2.25, 3.6, 0.2, -0.1, -4.3]
        let n = vDSP_Length(a.count)
        var c = Double()

        vDSP_maxvD(a, stride, &c, n)
        #expect(c == 3.6)
    }

    @Test("maxvD Empty Array")
    func vDSP_maxvDEmptyArrayTest() async throws {
        let stride = vDSP_Stride(1)
        let a: [Double] = []
        let n = vDSP_Length(a.count)
        var c = Double()

        vDSP_maxvD(a, stride, &c, n)
        #expect(c == -Double.infinity)
    }
    
    @Test("minvD Simple")
    func vDSP_minvDSimpleTest() async throws {
        let stride = vDSP_Stride(1)
        let a: [Double] = [-1.5, 2.25, 3.6, 0.2, -0.1, -4.3]
        let n = vDSP_Length(a.count)
        var c = Double()
        
        vDSP_minvD(a, stride, &c, n)
        #expect(c == -4.3)
    }
    
    @Test("minvD Empty Array")
    func vDSP_minvDEmptyArrayTest() async throws {
        let stride = vDSP_Stride(1)
        let a: [Double] = []
        let n = vDSP_Length(a.count)
        var c = Double()
        
        vDSP_minvD(a, stride, &c, n)
        #expect(c == Double.infinity)
    }
}
