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

@import_from_unitful ~m ~s ~A ~K ~cd ~yr
@import_from_unitful ~L ~Hz ~N ~Pa ~J ~W ~C ~V ~Ω ~S ~F ~H ~T ~Wb ~lm ~lx ~Bq ~Gy ~Sv ~kat ~eV
@import_from_unitful sr rad ° °C °F Ra minute hr d wk ~bar atm Torr
@import_from_unitful q c0 c μ0 µ0 ε0 ϵ0 Z0 G gn ge h ħ Φ0 me mn mp μB µB Na R k σ
@import_from_unitful inch ft yd mi ac lb oz dr gr lbf

# CGS units have been moved to default Unitful.jl now
@import_from_unitful dyn erg

import UnitfulAngles: arcminute, arcsecond, mas, μas

#    symbol      abbrev     name                      equality                  tf

"    UnitfulAstro.AU
\nThe astronomical unit, an IAU unit of distance, defined as 149 597 870 700 m, in IAU 2012.
It is intended to represent the mean distance between the Earth and the Sun.
\nDimension: `𝐋`
\nReference: [IAU 2012 Resolution B2](@cite IAUresolution2012B2)"
@unit AU         "AU"       AstronomicalUnit          149_597_870_700.0*m       false  # cf IAU 2012
"    UnitfulAstro.ly
\nThe light-year, a unit of distance, defined as 1 c⋅yr (speed of light times year).
It is intended to represent the amount of distance traveled by an object traveling at the speed of light (e.g., a photon) in a year.
\nDimesion: `𝐋`
\nSee also: [`c` (speed of light)](@extref Unitful.c), [`yr`](@extref Unitful.yr)"
@unit ly         "ly"       LightYear                 1*c*yr                    false
"    UnitfulAstro.pc
\nThe parsec, a unit of distance, defined as 1 AU/arcsecond, in IAU 2015.
The exact conversion is 648000/π AU.
It is intended to represent the distance to an object whose apparent parallax is 1 arcsecond when viewed from two distances 1 AU apart.
\nDimension: `𝐋`
\nSee also: [`AU`](@ref), `arcsecond`
\nReferences: [Binney & Tremaine (2008)](@cite binney2008), [Cox (2002)](@cite cox2002), [IAU 2015 Resolution B2](@cite IAUresolution2015B2)"
@unit pc         "pc"       Parsec                    1*AU/arcsecond            true   # cf IAU 2015
# Note that IAU 2015 defines the small angle approximation as exact in the definition of the parsec.

"    UnitfulAstro.Jy
\nThe jansky, a unit of spectral flux density, or spectral irradiance.
It is defined as 10^-26 W m^-2 Hz^-1, or 10^-23 erg/s cm^-2 Hz^-1.
\nDimension: `𝐌 𝐓^-2`"
@unit Jy         "Jy"       Jansky                    1e-23erg*s^-1*cm^-2*Hz^-1 true
# Note that Jy uses a Float64 conversion factor because 10^23 overflows Int64.

# SOLAR CONVERSION CONSTANTS (IAU 2015)
"    UnitfulAstro.Rsun
\nThe solar radius, a unit of length. It is defined as 6.957 × 10^8 m in IAU 2015.
It is intended to represent the radius of the sun.
\nDimension: `𝐋`
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit Rsun       "R⊙"       SolarRadius               6.957e8*m                 false
"    UnitfulAstro.Ssun
\nThe solar irradiance, a unit of surface power density. It is defined as 1361 W m^-2 in IAU 2015.
It is intended to represent the average amount of power emitted by the sun in unit surface area.
\nDimension: `𝐌 𝐓^-3`
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit Ssun       "S⊙"       SolarIrradiance           1361.0*W*m^-2             false
"    UnitfulAstro.Lsun
\nThe solar luminosity, a unit of power. It is defined as 3.828 × 10^26 W in IAU 2015.
It is intended to represent the total power emitted by the sun.
\nDimension: `𝐌 𝐋^2 𝐓^-3`
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit Lsun       "L⊙"       SolarLuminosity           3.828e26*W                false
# TODO solar effective temperature
"    UnitfulAstro.GMSun
\nThe solar mass parameter. It is defined as 1.3271244 × 10^20 m^3 s^-2.
It is intended to represent the product of G (the universal gravitational constant) and Msun (the solar mass).
\nDimension: `𝐋^3 𝐓^-2`
\nSee also: [`G`](@extref Unitful.G), [`Msun`](@ref)
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit GMsun      "GM⊙"      GSolarMass                1.327_124_4e20*m^3*s^-2   false
"    UnitfulAstro.Msun
\nThe solar mass, a unit of mass. It is defined as 1 GMsun/G. It is approximately equal to 1.988 × 10^30 kg.
It is intended to represent the entire mass of the Sun.
\nDimension: `𝐌`
\nSee also: [`G`](@extref Unitful.G), [`GMsun`](@ref)
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit Msun       "M⊙"       SolarMass                 1*GMsun/G                 false

# PLANETARY CONVERSION CONSTANTS (IAU 2015)
"    UnitfulAstro.Rearth_e
\nThe equatorial Earth radius, a unit of length. It is defined as 6.3781 × 10^6 m.
It is intended to represent the distance from the Earth's center to its equator.
\nDimension: `𝐋`
\nSee also: [`Rearth_p`](@ref)
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit Rearth_e   "R⊕ₑ"      EarthEquatorialRadius     6.3781e6*m                false
"    UnitfulAstro.Rearth_p
\nThe polar Earth radius, a unit of length. It is defined as 6.3568 × 10^6 m.
It is intended to represent the distance from the Earth's center to its poles.
\nDimension: `𝐋`
\nSee also: [`Rearth_e`](@ref)
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit Rearth_p   "R⊕ₚ"      EarthPolarRadius          6.3568e6*m                false
"    UnitfulAstro.Rjup_e
\nThe equatorial Jupiter radius, a unit of length. It is defined as 7.1492 × 10^7 m.
It is intended to represent the distance from Jupiter's center to its equator.
\nDimension: `𝐋`
\nSee also: [`Rjup_p`](@ref)
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit Rjup_e     "Rjupₑ"    JupiterEquatorialRadius   7.1492e7*m                false
"    UnitfulAstro.Rjup_p
\nThe polar Jupiter radius, a unit of length. It is defined as 6.6854 × 10^7 m.
It is intended to represent the distance from Jupiter's center to its equator.
\nDimension: `𝐋`
\nSee also: [`Rjup_e`](@ref)
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit Rjup_p     "Rjupₚ"    JupiterPolarRadius        6.6854e7*m                false
"    UnitfulAstro.GMearth
\nThe terrestrial mass parameter. It is defined as 3.986 004 × 10^14 m^3 s^-2.
It is intended to represent the product of G (the universal gravitational constant) and Mearth (the terrestrial mass).
\nDimension: `𝐋^3 𝐓^-2`
\nSee also: [`G`](@extref Unitful.G), [`Mearth`](@ref)
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit GMearth    "GM⊕"      GEarthMass                3.986_004e14*m^3*s^-2     false
"    UnitfulAstro.GMjup
\nThe jovian mass parameter. It is defined as 1.266 8653 × 10^17 m^3 s^-2.
It is intended to represent the product of G (the universal gravitational constant) and Mjup (the jovian mass).
\nDimension: `𝐋^3 𝐓^-2`
\nSee also: [`G`](@extref Unitful.G), [`Mjup`](@ref)
\nReference: [IAU 2015 Resolution B3](@cite IAUresolution2015B3)"
@unit GMjup      "GMjup"    GJupiterMass              1.266_865_3e17*m^3*s^-2   false
"    UnitfulAstro.Mearth
\nThe terrestrial mass, a unit of mass. It is defined as 1 GMearth/G. It is approximately 5.972 × 10^24 kg.
It is intended to represent the total mass of the Earth.
\nDimension: `𝐌`
\nSee also: [`G`](@extref Unitful.G), [`GMearth`](@ref)"
@unit Mearth     "M⊕"       EarthMass                 1*GMearth/G               false
"    UnitfulAstro.Mjup
\nThe jovian mass, a unit of mass. It is defined as 1 GMjup/G. It is approximately 1.898 × 10^27 kg.
It is intended to represent the total mass of Jupiter .
\nDimension: `𝐌`
\nSee also: [`G`](@extref Unitful.G), [`GMjup`](@ref)"
@unit Mjup       "Mjup"     JupiterMass               1*GMjup/G                 false
"    UnitfulAstro.Rearth
\nThe terrestrial radius, a unit of length. It is defined as 1 equatorial Earth radius.
\nDimension: `𝐋`
\nSee also: [`Rearth_e`](@ref), [`Rearth_p`](@ref)"
@unit Rearth     "R⊕"       EarthRadius               1*Rearth_e                false
"    UnitfulAstro.Rjup
\nThe jovian radius, a unit of length. It is defined as 1 equatorial Jupiter radius.
\nDimension: `𝐋`
\nSee also: [`Rjup_e`](@ref), [`Rjup_p`](@ref)"
@unit Rjup       "Rjup"     JupiterRadius             1*Rjup_e                  false
# Note that IAU 2015 states that when the radius is not specified as polar or equatorial, the
# equatorial radius should be used.

# "ten to the Fifty-One Ergs" (approximate energy of a supernova explosition)
"    UnitfulAstro.foe
\nThe foe, a unit of energy. It is defined as 10^51 erg (ten to the Fifty-One Ergs), or 10^44 J.
It is intended to represent the approximate energy released in a supernova explosion.
\nDimension: `𝐌 𝐋^-2 𝐓^-2`
\nReferences: [Herant et al. (1997)](@cite herant1997), [Hartmann (1999)](@cite hartmann1999)"
@unit foe        "foe"      FiftyOneErgs              1e51*erg                  false

# Solar flux unit
# https://en.wikipedia.org/wiki/Solar_flux_unit
"    UnitfulAstro.SFU
\nThe solar flux unit, a unit of spectral flux density, or spectral irradiance.
It is defined as 10 kJy, or 10^4 Jy.
\nDimension: `𝐌 𝐓^-2`
\nSee also: [`Jy`](@ref)
\nReference: [Tapping (2013)](@cite tapping2013)"
@unit SFU        "SFU"      SolarFluxUnit             10*kJy                    false

# Total electron content unit (used for ionospheric physics and low-frequency radio astronomy)
"    UnitfulAstro.TECU
\nThe total electron content unit, a unit of areal number density. It is defined as 10^16 m^-2.
\nDimension: `𝐋^-2`
\nReference: [Hofmann-Wellenhof (2001)](@cite hofmann-wellenhof2001)"
@unit TECU       "TECU"     TotalElectronContentUnit  1e16*m^-2                 false

@logscale mag "mag" Magnitude 10 -2.5 false

#https://en.wikipedia.org/wiki/AB_magnitude
@logunit    AB_mag  "AB mag"        Magnitude   3631Jy

# Bolometric magnitudes (cf IAU 2015)
# https://en.wikipedia.org/wiki/Absolute_magnitude#Bolometric_magnitude
@logunit    bol_Mag "bol Mag"       Magnitude   3.0128e28*W
@logunit    bol_mag "bol mag"       Magnitude   2.518_021_002e-8*W*m^-2

# https://en.wikipedia.org/wiki/Apparent_magnitude#Standard_reference_values
# https://www.cfa.harvard.edu/~dfabricant/huchra/ay145/mags.html
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
