using Unitful, UnitfulAstro
using Base.Test

const u = UnitfulAstro

@testset "UnitfulAstro.jl" begin
    @testset "unit tests" begin
        @test 10^7*u.erg == 1*u.J
        @test 10^5*u.dyn == 1*u.N
        @test 60*u.arcminute == 1*u.°
        @test 60*u.arcsecond == 1*u.arcminute
        @test 3600*u.arcsecond == 1*u.°
        @test 365.25*u.d == 1*u.yr
        @test 1*u.ly == 1*u.c*u.yr
        @test 1*u.pc == 1*u.AU/u.arcsecond
        @test 1*u.angstrom == 1e-10*u.m
        @test 1*u.SFU ≈ 10000*u.Jy
        @test 1*u.TECU == 1e12*u.cm^-2
    end

    @testset "simple calculations" begin
        # gravitational acceleration at Earth's surface
        @test isapprox(1*u.GMearth/u.Rearth^2, 1*u.gn, atol=0.001*u.gn)
        # Solar flux at Earth's surface
        @test isapprox(1*u.Lsun/(4π*u.AU^2), 1*u.Ssun, atol=0.001*u.Ssun)
    end

    @testset "magnitudes" begin
        @test 3631*u.Jy ≈ 0*u.mag_AB
        @test 36.31*u.Jy ≈ 5*u.mag_AB
        @test 363.1*u.mJy ≈ 10*u.mag_AB
        @test 3.631*u.mJy ≈ 15*u.mag_AB
        @test 5*u.mag_AB + 5*u.mag_AB ≈ 4.247425010840047*u.mag_AB
        @test 5*u.mag_AB / 100 ≈ 10*u.mag_AB
        @test 5*u.mag_AB + 10*u.Jy ≈ 46.31*u.Jy
    end
end

