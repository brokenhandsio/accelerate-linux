#if !canImport(Accelerate) && ACCELERATE_NEW_LAPACK
public typealias __LAPACK_int = Int
public typealias __LAPACK_real = Float
public typealias __LAPACK_doublereal = Double
#elseif !canImport(Accelerate) && !ACCELERATE_NEW_LAPACK
public typealias __CLPK_integer = Int32
public typealias __CLPK_real = Float
public typealias __CLPK_doublereal = Double
#endif
