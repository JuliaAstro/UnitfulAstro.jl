using UnitfulAstro
using Base.Test

@testset "UnitfulAstro.jl tests" begin

    @test 10^7*UnitfulAstro.erg == 1*Unitful.J

end

