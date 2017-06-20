__precompile__()

module UnitfulAstro

import Unitful
using Unitful: @unit
export @us_str

# UNITFUL BASE UNITS
const m  = Unitful.m
const cm = Unitful.cm
const g  = Unitful.g
const kg = Unitful.kg
const s  = Unitful.s

# UNITFUL DERIVED UNITS
const W  = Unitful.W
const Hz = Unitful.Hz

# UNITFUL CONSTANTS
const G  = Unitful.G
const c  = Unitful.c

@unit   erg      "erg"      Erg                       (1//10^7)*Unitful.J       false
@unit   dyn      "dyn"      Dyne                      (1//10^5)*Unitful.N       false
@unit   arcmin   "arcmin"   ArcMinute                 (1//60)*Unitful.°         false
@unit   arcsec   "arcsec"   ArcSecond                 (1//3600)*Unitful.°       false
@unit   yr       "yr"       JulianYear                86_400*s                  true
@unit   AU       "AU"       AstronomicalUnit          149_597_870_700*m         false  # cf IAU 2012
@unit   ly       "ly"       LightYear                 1*c*yr                    false
@unit   pc       "pc"       Parsec                    1*AU/arcsec               true   # cf IAU 2015
@unit   Jy       "Jy"       Jansky            (1//10^23)*erg*s^-1*cm^-2*Hz^-1   true

# SOLAR CONVERSION CONSTANTS (IAU 2015)
@unit   Rsun     "Rsun"     SolarRadius               6.957e8*m                 false
@unit   Ssun     "Ssun"     SolarIrradiance           1361*W*m^-2               false
@unit   Lsun     "Lsun"     SolarLuminosity           3.828e26*W                false
# TODO solar effective temperature
@unit   GMsun    "GMsun"    GSolarMass                1.327_124_4e20*m^3*s^-2   false
@unit   Msun     "Msun"     SolarMass                 1*GMsun/G                 false

# PLANETARY CONVERSION CONSTANTS (IAU 2015)
@unit   Rearth_e "Rearth_e" EarthEquatorialRadius     6.3781e6*m                false
@unit   Rearth_p "Rearth_p" EarthPolarRadius          6.3568e6*m                false
@unit   Rjup_e   "Rjup_e"   JupiterEquatorialRadius   7.1492e7*m                false
@unit   Rjup_p   "Rjup_p"   JupiterPolarRadius        6.6854e7*m                false
@unit   GMearth  "GMearth"  GEarthMass                3.986_004e14*m^3*s^-2     false
@unit   GMjup    "GMjup"    GJupiterMass              1.266_865_3e17*m^3*s^-2   false
@unit   Mearth   "Mearth"   EarthMass                 1*GMearth/G               false
@unit   Mjup     "Mjup"     JupiterMass               1*GMjup/G                 false
@unit   Rearth   "Rearth"   EarthRadius               1*Rearth_e                false
@unit   Rjup     "Rjup"     JupiterRadius             1*Rjup_e                  false

const localunits = Unitful.basefactors
function __init__()
    merge!(Unitful.basefactors, localunits)
    Unitful.register(UnitfulAstro)
end

end

