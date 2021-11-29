using Documenter, UnitfulAstro

makedocs(
    format = Documenter.HTML(prettyurls = !("local" in ARGS)),
    sitename = "UnitfulAstro.jl",
    authors = "Michael Eastwood",
    linkcheck = true,
    linkcheck_ignore = [r"assets/.+.pdf"],
    pages = [
        "Home" => "index.md"
    ]
)

deploydocs(
    repo = "github.com/JuliaAstro/UnitfulAstro.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)

