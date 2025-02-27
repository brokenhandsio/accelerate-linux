# Accelerate Linux

This package is a collection of functions from Apple's Accelerate framework made available on Linux. It implements vDSP functions natively and bridges to LAPACK and BLAS when available.

## Installation

```swift
.package(url: "https://github.com/brokenhandsio/accelerate-linux.git", branch: "main"),
```

```swift
.product(name: "AccelerateLinux", package: "accelerate-linux")
```

## Usage

Simply use

```swift
import AccelerateLinux
```

and then call through to normal Accelerate functions. 

> [!NOTE]
> To use this on linux you will need BLAS and LAPACK installed. On Ubuntu you can install these with:
>```bash
> apt-get install libopenblas-dev liblapacke-dev
>```

## Structure 

The package is structured as follows:

- `Sources/AccelerateLinux/MatrixOps`: Contains matrix operations:
    - `BasicOps` - Basic matrix operations:
        - [x] `vDSP_mtransD` - Transpose a matrix
        - [x] `vDSP_mmulD` - Matrix multiplication
    - `LAPACK` - LAPACK functions:
        - [x] `dgesv_` - Solve a system of linear equations
        - [x] `dgesvd_` - Singular Value Decomposition
        - [x] `dgetrf_` - LU Decomposition
        - [x] `dgetri_` - Inverse of a matrix
        - [x] `dgeev_` - Eigenvalues and eigenvectors
        - [x] `dpotrf_` - Cholesky decomposition
        - [x] `dtrtrs_` - Solve a triangular system of linear equations
    - `CBLAS` - BLAS functions:
        - [x] `cblas_dgemm` - Matrix multiplication
- `Sources/AccelerateLinux/VectorOps`: Contains vector operations
    - `BasicOps` - Basic vector operations:
        - [x] `vDSP_maxvD` - Find the maximum value in a vector
        - [x] `vDSP_minvD` - Find the minimum value in a vector
        - [x] `vDSP_vaddD` - Add two vectors
        - [x] `vDSP_vsubD` - Subtract two vectors
        - [x] `vDSP_vmulD` - Multiply two vectors
        - [x] `vDSP_vminD` - Element-wise minimum of two vectors
        - [x] `vDSP_vmaxD` - Element-wise maximum of two vectors
        - [x] `vDSP_vdivD` - Divide two vectors
        - [x] `vvpow` - Raise a vector to a power
        - [x] `vDSP_vclrD` - Clear a vector
        - [x] `vDSP_vfillD` - Fill a vector with a value
        - [x] `vDSP_vabsD` - Absolute value of a vector
        - [x] `vDSP_vnegD` - Negate a vector
        - [x] `vDSP_vsqD` - Square a vector
        - [x] `vDSP_dotprD` - Dot product of two vectors
        - [x] `vDSP_vlimD` - Limit a vector to a range
        - [x] `vDSP_vclipcD` - Clip a vector to a range
        - [x] `vDSP_vrsumD` - Recursive sum of a vector
        - [x] `vDSP_vsortD` - Sort a vector
        - [x] `vDSP_vrampD` - Ramp a vector
        - [x] `vDSP.sum` - Sum of a vector
        - [x] `vDSP.add`:
            - [x] `vDSP.add` - Add two vectors
            - [x] `vDSP.add` - Add a scalar to a vector
        - [x] `vDSP.subtract` - Subtract two vectors
        - [x] `vDSP.multiply`:
            - [x] `vDSP.multiply` - Multiply two (Double) vectors
            - [x] `vDSP.multiply` - Multiply a vector by a scalar
            - [x] `vDSP.multiply` - Multiply two (Float) vectors
        - [x] `vvsin` - Sine of each element in a vector
        - [x] `vvsqrt` - Square root of each element in a vector
        - [x] `vvexp` - Exponential of each element in a vector
        - [x] `vvlog` - Logarithm of each element in a vector
    - `Statistical` - Statistical operations:
        - [x] `vDSP.mean` - Mean of a vector
    - `Transforms`:
        - [x] `vDSP_vdpsp` - Convert a double vector to a single precision vector
        - [x] `vDSP_vspdp` - Convert a single precision vector to a double precision vector
