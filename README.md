# KeldyshContraction.jl

[![docs](https://img.shields.io/badge/docs-online-blue.svg)](https://oameye.github.io/KeldyshContraction.jl/)
[![codecov](https://codecov.io/gh/oameye/KeldyshContraction.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/oameye/KeldyshContraction.jl)

[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/JuliaDiff/BlueStyle)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![JET](https://img.shields.io/badge/%E2%9C%88%EF%B8%8F%20tested%20with%20-%20JET.jl%20-%20red)](https://github.com/aviatesk/JET.jl)

KeldyshContraction.jl is a package for the symbolic derivation of the two-point correlator diagrams in Keldysh-Schwinger field theory. The symbolic quantum field theory algebra is implemented using [SymbolicUtils.jl](https://github.com/JuliaSymbolics/SymbolicUtils.jl) and [TermInterface.jl](https://github.com/JuliaSymbolics/TermInterface.jl/) of the JuliaSymbolic ecosystem. The typesystem has been heavily inspired by the second quantization algebra defined in [QuantumCumulants.jl](https://github.com/qojulia/QuantumCumulants.jl). For more details on the implementation see the ["symbolic quantum field algebra"](https://oameye.github.io/KeldyshContraction.jl/dev/typesystem/) documentation page.

In developing this package, the work [`SciPost Phys. Core 8, 014 (2025)`](https://doi.org/10.21468/SciPostPhysCore.8.1.014) symbolic quantum field algebra was used extensively. Hence, the corresponding conventions and notation are used in this package.
