CI = get(ENV, "CI", nothing) == "true" || get(ENV, "GITHUB_TOKEN", nothing) !== nothing

using KeldyshContraction
using Documenter

include("pages.jl")

makedocs(;
    sitename="KeldyshContraction.jl",
    authors="Orjan Ameyep",
    modules=KeldyshContraction,
    format=Documenter.HTML(;
        canonical="https://oameye.github.io/KeldyshContraction.jl/stable/"
    ),
    pages=pages,
    clean=true,
    linkcheck=true,
    warnonly=:missing_docs,
    draft=false,#,(!CI),
    doctest=false,  # We test it in the CI, no need to run it here
)

if CI
    deploydocs(;
        repo="github.com/oameye/KeldyshContraction.jl",
        devbranch="main",
        target="build",
        branch="gh-pages",
        push_preview=true,
    )
end
