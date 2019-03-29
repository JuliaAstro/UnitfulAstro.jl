__precompile__()

module UnitfulAstro

import Unitful
using Unitful: @unit, @logscale, @logunit

macro import_from_unitful(args...)
    expr = Expr(:block)
    for arg in args
        use_SI_prefixes, sym = should_we_use_SI_prefixes(arg)
        if use_SI_prefixes
            for prefix in Unitful.si_prefixes
                sym′ = Symbol(prefix, sym)
                push!(expr.args, :(import Unitful.$sym′))
            end
        else
            push!(expr.args, :(import Unitful.$sym))
        end
    end
    expr
end

function should_we_use_SI_prefixes(arg::Expr)
    if arg.head == :(call)
        if arg.args[1] == :(~)
            return true, arg.args[2]
        else
            error("incorrect first argument")
        end
    else
        error("incorrect expression head")
    end
end
should_we_use_SI_prefixes(arg::Symbol) = false, arg

@import_from_unitful ~m ~s ~A ~K ~cd ~g ~mol
@import_from_unitful ~L ~Hz ~N ~Pa ~J ~W ~C ~V ~Ω ~S ~F ~H ~T ~Wb ~lm ~lx ~Bq ~Gy ~Sv ~kat ~eV
@import_from_unitful sr rad ° °C °Ra °F minute hr d wk ~bar atm Torr
@import_from_unitful q c0 c μ0 µ0 ε0 ϵ0 Z0 G gn ge h ħ Φ0 me mn mp μB µB Na R k σ
@import_from_unitful inch ft yd mi ac lb oz dr gr lbf

# CGS units have been moved to default Unitful.jl now
@import_from_unitful dyn erg

import UnitfulAngles: arcminute, arcsecond

@unit yr         "yr"       JulianYear                365.25*d                  true
@unit AU         "AU"       AstronomicalUnit          149_597_870_700.0*m       false  # cf IAU 2012
@unit ly         "ly"       LightYear                 1*c*yr                    false
@unit pc         "pc"       Parsec                    1*AU/arcsecond            true   # cf IAU 2015
# Note that IAU 2015 defines the small angle approximation as exact in the definition of the parsec.
@unit Jy         "Jy"       Jansky                    1e-23erg*s^-1*cm^-2*Hz^-1 true
# Note that Jy uses a Float64 conversion factor because 10^23 overflows Int64.
@unit angstrom   "Å"        Angstrom                  1e-10*m                   false

# SOLAR CONVERSION CONSTANTS (IAU 2015)
@unit Rsun       "R⊙"       SolarRadius               6.957e8*m                 false
@unit Ssun       "S⊙"       SolarIrradiance           1361.0*W*m^-2             false
@unit Lsun       "L⊙"       SolarLuminosity           3.828e26*W                false
# TODO solar effective temperature
@unit GMsun      "GM⊙"      GSolarMass                1.327_124_4e20*m^3*s^-2   false
@unit Msun       "M⊙"       SolarMass                 1*GMsun/G                 false

# PLANETARY CONVERSION CONSTANTS (IAU 2015)
@unit Rearth_e   "R⊕ₑ"      EarthEquatorialRadius     6.3781e6*m                false
@unit Rearth_p   "R⊕ₚ"      EarthPolarRadius          6.3568e6*m                false
@unit Rjup_e     "Rjupₑ"    JupiterEquatorialRadius   7.1492e7*m                false
@unit Rjup_p     "Rjupₚ"    JupiterPolarRadius        6.6854e7*m                false
@unit GMearth    "GM⊕"      GEarthMass                3.986_004e14*m^3*s^-2     false
@unit GMjup      "GMjup"    GJupiterMass              1.266_865_3e17*m^3*s^-2   false
@unit Mearth     "M⊕"       EarthMass                 1*GMearth/G               false
@unit Mjup       "Mjup"     JupiterMass               1*GMjup/G                 false
@unit Rearth     "R⊕"       EarthRadius               1*Rearth_e                false
@unit Rjup       "Rjup"     JupiterRadius             1*Rjup_e                  false
# Note that IAU 2015 states that when the radius is not specified as polar or equatorial, the
# equatorial radius should be used.

# "ten to the Fifty-One Ergs" (approximate energy of a supernova explosition)
@unit foe        "foe"      FiftyOneErgs              1e51*erg                  false

# Solar flux unit
# https://en.wikipedia.org/wiki/Solar_flux_unit
@unit SFU        "SFU"      SolarFluxUnit             10*kJy                    false

# Total electron content unit (used for ionospheric physics and low-frequency radio astronomy)
@unit TECU       "TECU"     TotalElectronContentUnit  1e16*m^-2                 false

@logscale mag "mag" Magnitude 10 -2.5 false

#https://en.wikipedia.org/wiki/AB_magnitude     
@logunit    AB_mag  "AB mag"        Magnitude   3631Jy

# Bolometric magnitudes (cf IAU 2015)
# https://en.wikipedia.org/wiki/Absolute_magnitude#Bolometric_magnitude
@logunit    bol_Mag "bol Mag"       Magnitude   3.0128e28*W
@logunit    bol_mag "bol mag"       Magnitude   2.518_021_002e-8*W*m^-2

#https://en.wikipedia.org/wiki/Apparent_magnitude#Standard_reference_values
#https://www.cfa.harvard.edu/~dfabricant/huchra/ay145/mags.html
@logunit    U_mag   "Johnson U mag" Magnitude   1810Jy
@logunit    B_mag   "Johnson B mag" Magnitude   4260Jy
@logunit    V_mag   "Johnson V mag" Magnitude   3640Jy
@logunit    R_mag   "Johnson R mag" Magnitude   3080Jy
@logunit    I_mag   "Johnson I mag" Magnitude   2550Jy
@logunit    J_mag   "Johnson J mag" Magnitude   1600Jy
@logunit    H_mag   "Johnson H mag" Magnitude   1080Jy
@logunit    K_mag   "Johnson K mag" Magnitude    670Jy
@logunit    g_mag   "Gunn g mag"    Magnitude   3730Jy
@logunit    r_mag   "Gunn r mag"    Magnitude   4490Jy
@logunit    i_mag   "Gunn i mag"    Magnitude   4760Jy
@logunit    z_mag   "Gunn z mag"    Magnitude   4810Jy


struct MagnitudeError <: Exception
    x
end
Base.showerror(io::IO, e::MagnitudeError) = print(io, "MagnitudeError: ", e.x)

# https://en.wikipedia.org/wiki/Color_index
# for color indices (subtracting magnitudes of different passbands)
import Base.-
function -(x::Unitful.Level{L,S,T},y::Unitful.Level{L,S,T}) where {L<:Magnitude,S,T<:Unitful.Quantity}
    return Unitful.Level{L,S}(-(x.val, y.val))
end
import Base.-
function -(x::Unitful.Level{L,S,T},y::Unitful.Level{L,R,T}) where {L<:Magnitude,S,R,T<:Unitful.Quantity}
    return Unitful.ustrip(x) - Unitful.ustrip(y)
end
import Base.+
function +(x::Unitful.Level{L,S,T},y::Unitful.Level{L,S,T}) where {L<:Magnitude,S,T<:Unitful.Quantity}
    return Unitful.Level{L,S}(+(x.val, y.val))
end
import Base.+
function +(x::Unitful.Level{L,S,T},y::Unitful.Level{L,R,T}) where {L<:Magnitude,S,R,T<:Unitful.Quantity}
    throw(MagnitudeError("an invalid operation was attempted with magnitudes: $x, $y"))
end
import Base.*
function *(x::Unitful.Level{L,S,T},y::Unitful.Level{L,R,T}) where {L<:Magnitude,S,R,T<:Unitful.Quantity}
    throw(MagnitudeError("an invalid operation was attempted with magnitudes: $x, $y"))
end
import Base./
function /(x::Unitful.Level{L,S,T},y::Unitful.Level{L,R,T}) where {L<:Magnitude,S,R,T<:Unitful.Quantity}
    throw(MagnitudeError("an invalid operation was attempted with magnitudes: $x, $y"))
end
import Base.//
function //(x::Unitful.Level{L,S,T},y::Unitful.Level{L,R,T}) where {L<:Magnitude,S,R,T<:Unitful.Quantity}
    throw(MagnitudeError("an invalid operation was attempted with magnitudes: $x, $y"))
end


const localunits = Unitful.basefactors
function __init__()
    merge!(Unitful.basefactors, localunits)
    Unitful.register(UnitfulAstro)
end

end
