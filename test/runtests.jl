using UnitfulAstro
using Base.Test

@testset "UnitfulAstro.jl" begin
    @testset "unit tests" begin
        @test 10^7*UnitfulAstro.erg == 1*UnitfulAstro.J
        @test 10^5*UnitfulAstro.dyn == 1*UnitfulAstro.N
        @test 60*UnitfulAstro.arcmin == 1*UnitfulAstro.°
        @test 60*UnitfulAstro.arcsec == 1*UnitfulAstro.arcmin
        @test 3600*UnitfulAstro.arcsec == 1*UnitfulAstro.°
        @test 365.25*UnitfulAstro.d == 1*UnitfulAstro.yr
    end
end

