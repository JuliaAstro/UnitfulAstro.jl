using Documenter, UnitfulAstro

makedocs(
    format = :html,
    sitename = "UnitfulAstro.jl",
    authors = "Michael Eastwood",
    linkcheck = true,
    linkcheck_ignore = [r"assets/.+.pdf"],
    html_prettyurls = !("local" in ARGS),
    pages = [
        "Home" => "index.md"
    ]
)

deploydocs(
    repo = "github.com/JuliaAstro/UnitfulAstro.jl.git",
    julia = "0.6",
    osname = "linux",
    target = "build",
    deps = nothing,
    make = nothing
)

