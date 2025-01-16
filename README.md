# Accelerate Linux

This package is a collection of functions from Apple's Accelerate framework made available on Linux. It implements vDSP functions natively and bridges to LAPACK and BLAS when available.

## Installation

```swift
.package(url: "git@github.com:brokenhandsio/accelerate-linux.git", from: "main")
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
        - [ ] `vDSP_vrampD` - Ramp a vector
        - [ ] `vDSP.sum` - Sum of a vector
        - [ ] `vDSP.add` - Add two vectors
        - [ ] `vDSP.subtract` - Subtract two vectors
        - [ ] `vDSP.multiply` - Multiply two vectors
    - `Statistical` - Statistical operations:
        - [ ] `vDSP.mean` - Mean of a vector
    - `Transforms`:
        - [ ] `vDSP_vdpsp` - Convert a double vector to a single precision vector
