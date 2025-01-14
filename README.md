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
> apt-get install libblas-dev liblapack-dev
>```

## Structure 

The package is structured as follows:

- `Sources/AccelerateLinux/MatrixOps`: Contains matrix operations:
    - `BasicOps` - Basic matrix operations:
        - [x] `vDSP_mtransD` - Transpose a matrix
        - [ ] `vDSP_mmulD` - Matrix multiplication
    - `LAPACK` - LAPACK functions:
        - [x] `dgesv_` - Solve a system of linear equations
        - [x] `dgesvd_` - Singular Value Decomposition
        - [ ] `dgetrf_` - LU Decomposition
        - [ ] `dgetri_` - Inverse of a matrix
        - [ ] `dgeev_` - Eigenvalues and eigenvectors
        - [ ] `dpotrf_` - Cholesky decomposition
        - [ ] `dtrtrs_` - Solve a triangular system of linear equations
    - `CBLAS` - BLAS functions:
        - [ ] `cblas_dgemm` - Matrix multiplication
- `Sources/AccelerateLinux/VectorOps`: Contains vector operations
    - `BasicOps` - Basic vector operations:
        - [x] `vDSP_maxvD` - Find the maximum value in a vector
        - [x] `vDSP_minvD` - Find the minimum value in a vector
        - [ ] `vDSP_vaddD` - Add two vectors
        - [ ] `vDSP_vsubD` - Subtract two vectors
        - [ ] `vDSP_vmulD` - Multiply two vectors
        - [ ] `vvpow` - Raise a vector to a power
        - [ ] `vDSP_vclrD` - Clear a vector
        - [ ] `vDSP_vfillD` - Fill a vector with a value
        - [ ] `vDSP_vabsD` - Absolute value of a vector
        - [ ] `vDSP_vnegD` - Negate a vector
        - [ ] `vDSP_vsqD` - Square a vector
        - [ ] `vDSP_dotprD` - Dot product of two vectors
        - [ ] `vDSP_vlimD` - Limit a vector to a range
        - [ ] `vDSP_vclipcD` - Clip a vector to a range
        - [ ] `vDSP_vrsumD` - Recursive sum of a vector
        - [ ] `vDSP_vsortD` - Sort a vector
        - [ ] `vDSP_vrampD` - Ramp a vector
        - [ ] `vDSP.sum` - Sum of a vector
        - [ ] `vDSP.add` - Add two vectors
        - [ ] `vDSP.subtract` - Subtract two vectors
        - [ ] `vDSP.multiply` - Multiply two vectors
    - `Statistical` - Statistical operations:
        - [ ] `vDSP.mean` - Mean of a vector
    - `Transforms`:
        - [ ] `vDSP_vdpsp` - Convert a double vector to a single precision vector
