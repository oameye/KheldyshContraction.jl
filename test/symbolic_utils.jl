using KeldyshContraction, Test
using KeldyshContraction: make_real, _conj
using SymbolicUtils

@syms x::Real y::Real z

@test SymbolicUtils._isreal(x)

expr = (1+1*im)*z + (1-1*im)*z
@test isequal(make_real(expr), 2*z)
@test isequal(_conj(make_real(expr)), 2*conj(z))

expr = (1+1*im)*x + (1-1*im)*x
@test isequal(make_real(expr), 2*x)
@test isequal(_conj(make_real(expr)), 2*x)
