# UnitfulAstro.jl Documentation

UnitfulAstro.jl is an extension of [Unitful.jl](https://github.com/ajkeller34/Unitful.jl) to include
units commonly encountered in astronomy.

## Table of Units

The list of additional units is given below:

|                        Name |                  Binding |                          Value |
|-----------------------------|--------------------------|--------------------------------|
|                         Erg |       `UnitfulAstro.erg` |                `1//10000000 J` |
|                        Dyne |       `UnitfulAstro.dyn` |                  `1//100000 N` |
|                   Arcminute | `UnitfulAstro.arcminute` |       `0.016666666666666666 °` |
|                   Arcsecond | `UnitfulAstro.arcsecond` |      `0.0002777777777777778 °` |
|                 Julian year |        `UnitfulAstro.yr` |                    `365.25 dy` |
|           Astronomical unit |        `UnitfulAstro.AU` |            `1.495978707e13 cm` |
|                  Light year |        `UnitfulAstro.ly` |        `9.4607304725808e17 cm` |
|                      Parsec |        `UnitfulAstro.pc` |     `3.0856775814913674e18 cm` |
|                      Jansky |        `UnitfulAstro.Jy` | `1.0e-23 erg Hz^-1 cm^-2 s^-1` |
|                    Angstrom |  `UnitfulAstro.angstrom` |                       `0.1 nm` |
|                Solar radius |      `UnitfulAstro.Rsun` |                  `6.957e10 cm` |
|            Solar irradiance |      `UnitfulAstro.Ssun` |       `1.361e6 erg cm^-2 s^-1` |
|            Solar luminosity |      `UnitfulAstro.Lsun` |            `3.828e33 erg s^-1` |
|              G × Solar mass |     `UnitfulAstro.GMsun` |        `1.3271244e20 m^3 s^-2` |
|                  Solar mass |      `UnitfulAstro.Msun` |      `1.9884754153381438e33 g` |
|   Earth radius (equatorial) |  `UnitfulAstro.Rearth_e` |                  `6.3781e8 cm` |
|        Earth radius (polar) |  `UnitfulAstro.Rearth_p` |                  `6.3568e8 cm` |
|                Earth radius |    `UnitfulAstro.Rearth` |                  `6.3781e8 cm` |
|              G × Earth mass |   `UnitfulAstro.GMearth` |         `3.986004e14 m^3 s^-2` |
|                  Earth mass |    `UnitfulAstro.Mearth` |       `5.972364730419773e27 g` |
| Jupiter radius (equatorial) |    `UnitfulAstro.Rjup_e` |                  `7.1492e9 cm` |
|      Jupiter radius (polar) |    `UnitfulAstro.Rjup_p` |                  `6.6854e9 cm` |
|              Jupiter radius |      `UnitfulAstro.Rjup` |                  `7.1492e9 cm` |
|            G × Jupiter mass |     `UnitfulAstro.GMjup` |        `1.2668653e17 m^3 s^-2` |
|                Jupiter mass |      `UnitfulAstro.Mjup` |      `1.8981871658715508e30 g` |
|              Fifty-one ergs |       `UnitfulAstro.foe` |                   `1.0e51 erg` |
|             Solar flux unit |       `UnitfulAstro.SFU` |                    `10//1 kJy` |
| Total electron content unit |      `UnitfulAstro.TECU` |                 `1.0e12 cm^-2` |

## Examples

```jldoctest
julia> using Unitful, UnitfulAstro

julia> uconvert(u"erg", 1 * Unitful.kg * Unitful.gn * Unitful.m)
9.80665e7 erg

julia> uconvert(u"Jy", 1.23e-20 * u"erg/s/cm^2/Hz")
1230.0000000000002 Jy

julia> uconvert(u"ly", 1 * u"pc")
3.2615637771674337 ly
```

## IAU Resolutions

Copies of recent IAU resolutions which formalize the definitions of some units used in this package
are linked below.

* [IAU 2012 (pdf)](assets/IAU2012_English.pdf)
* [IAU 2015 (pdf)](assets/IAU2015_English.pdf)

