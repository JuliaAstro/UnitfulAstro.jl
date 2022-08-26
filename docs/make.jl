using Documenter, UnitfulAstro

include("pages.jl")
makedocs(
    format = Documenter.HTML(prettyurls = !("local" in ARGS)),
    sitename = "UnitfulAstro.jl",
    authors = "Michael Eastwood",
    linkcheck = true,
    linkcheck_ignore = [r"assets/.+.pdf"],
    pages = pages
)

deploydocs(
    repo = "github.com/JuliaAstro/UnitfulAstro.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)

