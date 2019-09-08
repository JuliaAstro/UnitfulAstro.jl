using UnitfulAstro
using Test

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
        # rest mass energy of the sun
        @test isapprox(1*u.Msun*u.c^2, 1787*u.foe, atol=0.5*u.foe)
    end

    @testset "magnitudes" begin
        @test isapprox(3631*u.Jy, 0*u.AB_mag, atol=0.001*u.AB_mag)
        @test isapprox(36.31*u.Jy, 5*u.AB_mag, atol=0.001*u.AB_mag)
        @test isapprox(363.1*u.mJy, 10*u.AB_mag, atol=0.001*u.AB_mag)
        @test isapprox(3.631*u.mJy, 15*u.AB_mag, atol=0.001*u.AB_mag)
        @test isapprox(5*u.AB_mag + 5*u.AB_mag,  4.247425010840047*u.AB_mag, atol=0.001*u.AB_mag)
        @test isapprox(5*u.AB_mag / 100, 10*u.AB_mag, atol=0.001*u.AB_mag)
        @test isapprox(5*u.AB_mag + 10*u.Jy, 46.31*u.Jy, atol=0.001*u.AB_mag)

        @test isapprox(3.0128e28*u.W, 1u.bol_Mag, atol=0.001*u.bol_Mag)
        @test isapprox(2.518_021_002e-8*u.W*u.m^-2, 1u.bol_mag, atol=0.001*u.bol_mag)

        @test isapprox(1u.U_mag, 1810*u.Jy, atol=0.001*u.U_mag)
        @test isapprox(1u.B_mag, 4260*u.Jy, atol=0.001*u.B_mag)
        @test isapprox(1u.V_mag, 3640*u.Jy, atol=0.001*u.V_mag)
        @test isapprox(1u.R_mag, 3080*u.Jy, atol=0.001*u.R_mag)
        @test isapprox(1u.I_mag, 2550*u.Jy, atol=0.001*u.I_mag)
        @test isapprox(1u.J_mag, 1600*u.Jy, atol=0.001*u.J_mag)
        @test isapprox(1u.H_mag, 1080*u.Jy, atol=0.001*u.H_mag)
        @test isapprox(1u.K_mag,  670*u.Jy, atol=0.001*u.K_mag)
        @test isapprox(1u.g_mag, 3730*u.Jy, atol=0.001*u.g_mag)
        @test isapprox(1u.r_mag, 4490*u.Jy, atol=0.001*u.r_mag)
        @test isapprox(1u.i_mag, 4760*u.Jy, atol=0.001*u.i_mag)
        @test isapprox(1u.z_mag, 4810*u.Jy, atol=0.001*u.z_mag)

        @test iszero(1u.B_mag - 1u.V_mag)
        @test isapprox(5*u.B_mag - 1u.V_mag, 4)
        @test isapprox(1u.B_mag - 5*u.V_mag, -4)
        @test isapprox(1u.B_mag - 0.5u.V_mag, 0.5)
        @test_throws u.MagnitudeError 1u.B_mag + 2u.V_mag
        @test_throws u.MagnitudeError 1u.B_mag * 2u.V_mag
        @test_throws u.MagnitudeError 1u.B_mag / 2u.V_mag
        @test_throws u.MagnitudeError 1u.B_mag // 2u.V_mag

        # Extra tests for rootpower calculations
        flux = 10u.erg
        mag = 1u.mag
        @test isapprox(flux * mag, 3.981071705534972u.erg)
        flux = 10u.erg/u.s
        @test isapprox(flux * mag, 3.981071705534972u.erg/u.s)
        flux = 10u.erg/u.s/u.cm^2
        @test isapprox(flux * mag, 3.981071705534972u.erg/u.s/u.cm^2)
        flux = 10u.erg/u.s/u.cm^2/u.angstrom
        @test isapprox(flux * mag, 3.981071705534972u.erg/u.s/u.cm^2/u.angstrom)
    end
end

