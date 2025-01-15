#if !canImport(Accelerate)
public typealias blasint = Int32

public typealias CBLAS_ORDER = Int32
public let CblasRowMajor: CBLAS_ORDER = 101
public let CblasColMajor: CBLAS_ORDER = 102

public typealias CBLAS_TRANSPOSE = Int32
public let CblasNoTrans: CBLAS_TRANSPOSE = 111
public let CblasTrans: CBLAS_TRANSPOSE = 112
public let CblasConjTrans: CBLAS_TRANSPOSE = 113
public let CblasConjNoTrans: CBLAS_TRANSPOSE = 114

public typealias CBLAS_UPLO = Int32
public let CblasUpper: CBLAS_UPLO = 121
public let CblasLower: CBLAS_UPLO = 122

public typealias CBLAS_DIAG = Int32
public let CblasNonUnit: CBLAS_DIAG = 131
public let CblasUnit: CBLAS_DIAG = 132

public typealias CBLAS_SIDE = Int32
public let CblasLeft: CBLAS_SIDE = 141
public let CblasRight: CBLAS_SIDE = 142

public typealias CBLAS_LAYOUT = CBLAS_ORDER
#endif  // !canImport(Accelerate)
