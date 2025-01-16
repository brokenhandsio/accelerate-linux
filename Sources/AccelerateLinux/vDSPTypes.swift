#if !canImport(Accelerate)
/// An unsigned-integer value that represents the size of vectors and the indices of elements in vectors.
public typealias vDSP_Length = UInt
/// An integer value that represents the differences between indices of elements, including the lengths of strides.
public typealias vDSP_Stride = Int

/// A type that represents an immutable buffer.
///
/// If you implement your own type that conforms to ``AccelerateBuffer`` and uses the default implementation of ``withUnsafeBufferPointer(_:)``,
/// your type needs to return a nonnil result from `withContiguousStorageIfAvailable(_:)`.
// https://developer.apple.com/documentation/accelerate/acceleratebuffer
public protocol AccelerateBuffer<Element> {
    /// The buffer’s element type.
    associatedtype Element
    /// The number of elements in the buffer.
    var count: Int { get }
    /// Calls a closure with a pointer to the object’s contiguous storage.
    /// - Parameter body: A closure that receives an UnsafeBufferPointer to the sequence’s contiguous storage.
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Self.Element>) throws -> R) rethrows -> R
}

// https://developer.apple.com/documentation/accelerate/acceleratebuffer/3240656-withunsafebufferpointer
extension AccelerateBuffer where Self: Collection {
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Self.Element>) throws -> R) rethrows -> R {
        try self.withContiguousStorageIfAvailable(body)!
    }
}

extension Slice: AccelerateBuffer where Base: AccelerateBuffer {}

/// A type that represents a mutable buffer.
///
/// If you implement your own type that conforms to `AccelerateMutableBuffer` and uses the default implementation of ``withUnsafeMutableBufferPointer(_:)``,
/// your type needs to return a nonnil result from `withContiguousMutableStorageIfAvailable(_:)``.
// https://developer.apple.com/documentation/accelerate/acceleratemutablebuffer
public protocol AccelerateMutableBuffer<Element>: AccelerateBuffer {
    /// Calls the given closure with a pointer to the object’s mutable contiguous storage.
    /// - Parameter body: A closure that receives an UnsafeMutableBufferPointer to the sequence’s contiguous storage.
    mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Self.Element>) throws -> R) rethrows -> R
}

// https://developer.apple.com/documentation/accelerate/acceleratemutablebuffer/3240659-withunsafemutablebufferpointer
extension AccelerateMutableBuffer where Self: MutableCollection {
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Self.Element>) throws -> R) rethrows
        -> R
    {
        try self.withContiguousMutableStorageIfAvailable(body)!
    }
}

extension Array: AccelerateMutableBuffer {}
extension ArraySlice: AccelerateMutableBuffer {}
extension ContiguousArray: AccelerateMutableBuffer {}
extension Slice: AccelerateMutableBuffer where Base: AccelerateMutableBuffer & MutableCollection {}
extension UnsafeMutableBufferPointer: AccelerateMutableBuffer {}
#endif
