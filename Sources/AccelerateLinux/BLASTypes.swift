#if !canImport(Accelerate)
import CBLAS
public typealias blasint = CBLAS.blasint

public typealias CBLAS_ORDER = CBLAS.CBLAS_ORDER
public let CblasRowMajor: CBLAS_ORDER = .init(rawValue: 101)
public let CblasColMajor: CBLAS_ORDER = .init(rawValue: 102)

public typealias CBLAS_TRANSPOSE = CBLAS.CBLAS_TRANSPOSE
public let CblasNoTrans: CBLAS_TRANSPOSE = .init(rawValue: 111)
public let CblasTrans: CBLAS_TRANSPOSE = .init(rawValue: 112)
public let CblasConjTrans: CBLAS_TRANSPOSE = .init(rawValue: 113)
public let CblasConjNoTrans: CBLAS_TRANSPOSE = .init(rawValue: 114)

public typealias CBLAS_UPLO = CBLAS.CBLAS_UPLO
public let CblasUpper: CBLAS_UPLO = .init(rawValue: 121)
public let CblasLower: CBLAS_UPLO = .init(rawValue: 122)

public typealias CBLAS_DIAG = CBLAS.CBLAS_DIAG
public let CblasNonUnit: CBLAS_DIAG = .init(rawValue: 131)
public let CblasUnit: CBLAS_DIAG = .init(rawValue: 132)

public typealias CBLAS_SIDE = CBLAS.CBLAS_DIAG
public let CblasLeft: CBLAS_SIDE = .init(rawValue: 141)
public let CblasRight: CBLAS_SIDE = .init(rawValue: 142)

public typealias CBLAS_LAYOUT = CBLAS_ORDER
#endif  // !canImport(Accelerate)
