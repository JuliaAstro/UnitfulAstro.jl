using UnitfulAstro
using Base.Test

const u = UnitfulAstro

@testset "UnitfulAstro.jl" begin
    @testset "unit tests" begin
        @test 10^7*u.erg == 1*u.J
        @test 10^5*u.dyn == 1*u.N
        @test 60*u.arcmin == 1*u.°
        @test 60*u.arcsec == 1*u.arcmin
        @test 3600*u.arcsec == 1*u.°
        @test 365.25*u.d == 1*u.yr
        @test 1*u.ly == 1*u.c*u.yr
        @test 1*u.pc == 1*u.AU/u.arcsec
        @test isapprox(1*u.GMearth/u.Rearth^2, 1*u.gn, atol=0.001*u.gn)
        @test isapprox(1*u.Lsun/(4π*u.AU^2), 1*u.Ssun, atol=0.001*u.Ssun)
    end
end

