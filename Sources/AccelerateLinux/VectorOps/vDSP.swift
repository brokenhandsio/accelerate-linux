#if canImport(Accelerate)
@_exported import Accelerate
#else
/// An enumeration that acts as a namespace for Swift overlays to vDSP.
public enum vDSP {}
#endif
