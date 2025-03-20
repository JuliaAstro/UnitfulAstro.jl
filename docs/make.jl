using UnitfulAstro
using Documenter
using DocumenterInterLinks
using DocumenterCitations

extlinks = InterLinks(
    "Unitful" => "https://painterqubits.github.io/Unitful.jl/stable/objects.inv",
)
bib = CitationBibliography(joinpath(@__DIR__, "src", "refs.bib"); style = :numeric)

include("pages.jl")
makedocs(;
    format = Documenter.HTML(prettyurls = !("local" in ARGS)),
    sitename = "UnitfulAstro.jl",
    authors = "Michael Eastwood",
    linkcheck = true,
    linkcheck_ignore = [r"assets/.+.pdf"],
    pages,
    plugins = [extlinks, bib],
)

deploydocs(
    repo = "github.com/JuliaAstro/UnitfulAstro.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)

