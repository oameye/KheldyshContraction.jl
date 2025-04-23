# KeldyshContraction.jl

[docs-img]: https://img.shields.io/badge/docs-online-blue.svg
[docs-url]: https://oameye.github.io/KeldyshContraction.jl/

[codecov-img]: https://codecov.io/gh/oameye/KeldyshContraction.jl/branch/main/graph/badge.svg
[codecov-url]: https://codecov.io/gh/oameye/KeldyshContraction.jl

[benchmark-img]: https://github.com/qutip/QuantumToolbox.jl/actions/workflows/Benchmarks.yml/badge.svg?branch=main
[benchmark-url]: https://qutip.org/QuantumToolbox.jl/benchmarks/

[jet-img]: https://img.shields.io/badge/%E2%9C%88%EF%B8%8F%20tested%20with%20-%20JET.jl%20-%20red
[jet-url]: https://github.com/aviatesk/JET.jl

[aqua-img]: https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg
[aqua-url]: https://github.com/JuliaTesting/Aqua.jl

[blue-img]: https://img.shields.io/badge/blue%20style%20-%20blue-4495d1.svg
[blue-url]: https://github.com/JuliaDiff/BlueStyle

[![docs][docs-img]][docs-url]
[![codecov][codecov-img]][codecov-url]
[![Benchmarks][benchmark-img]][benchmark-url]

[![Code Style: Blue][blue-img]][blue-url]
[![Aqua QA][aqua-img]][aqua-url]
[![jet][jet-img]][jet-url]

KeldyshContraction.jl is a package for the symbolic derivation of the two-point correlator diagrams in Keldysh-Schwinger field theory. The symbolic quantum field theory algebra is implemented using [SymbolicUtils.jl](https://github.com/JuliaSymbolics/SymbolicUtils.jl) and [TermInterface.jl](https://github.com/JuliaSymbolics/TermInterface.jl/) of the JuliaSymbolic ecosystem. The typesystem has been heavily inspired by the second quantization algebra defined in [QuantumCumulants.jl](https://github.com/qojulia/QuantumCumulants.jl). For more details on the implementation see the ["symbolic quantum field algebra"](https://oameye.github.io/KeldyshContraction.jl/dev/typesystem/) documentation page.

In developing this package, the work [`SciPost Phys. Core 8, 014 (2025)`](https://doi.org/10.21468/SciPostPhysCore.8.1.014) symbolic quantum field algebra was used extensively. Hence, the corresponding conventions and notation are used in this package.
