var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"DocTestSetup = :(using Unitful, UnitfulAstro)","category":"page"},{"location":"#UnitfulAstro.jl-Documentation","page":"Home","title":"UnitfulAstro.jl Documentation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"UnitfulAstro.jl is an extension of Unitful.jl to include units commonly encountered in astronomy.","category":"page"},{"location":"#Table-of-Units","page":"Home","title":"Table of Units","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The list of additional units is given below:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Name Binding Value\nErg UnitfulAstro.erg 1//10000000 J\nDyne UnitfulAstro.dyn 1//100000 N\nArcminute UnitfulAstro.arcminute 1//60°\nArcsecond UnitfulAstro.arcsecond 1//3600°\nJulian year UnitfulAstro.yr 1461//4 d\nAstronomical unit UnitfulAstro.AU 1.495978707e13 cm\nLight year UnitfulAstro.ly 946073047258080000 cm\nParsec UnitfulAstro.pc 3.0856775814913674e18 cm\nJansky UnitfulAstro.Jy 1.0e-23 erg Hz^-1 cm^-2 s^-1\nSolar radius UnitfulAstro.Rsun 6.957e10 cm\nSolar irradiance UnitfulAstro.Ssun 1.361e6 erg cm^-2 s^-1\nSolar luminosity UnitfulAstro.Lsun 3.828e33 erg s^-1\nG × Solar mass UnitfulAstro.GMsun 1.3271244e20 m^3 s^-2\nSolar mass UnitfulAstro.Msun 1.988409870698051e33 g\nEarth radius (equatorial) UnitfulAstro.Rearth_e 6.3781e8 cm\nEarth radius (polar) UnitfulAstro.Rearth_p 6.3568e8 cm\nEarth radius UnitfulAstro.Rearth 6.3781e8 cm\nG × Earth mass UnitfulAstro.GMearth 3.986004e14 m^3 s^-2\nEarth mass UnitfulAstro.Mearth 5.972167867791379e27 g\nJupiter radius (equatorial) UnitfulAstro.Rjup_e 7.1492e9 cm\nJupiter radius (polar) UnitfulAstro.Rjup_p 6.6854e9 cm\nJupiter radius UnitfulAstro.Rjup 7.1492e9 cm\nG × Jupiter mass UnitfulAstro.GMjup 1.2668653e17 m^3 s^-2\nJupiter mass UnitfulAstro.Mjup 1.8981245973360504e30 g\nFifty-one ergs UnitfulAstro.foe 1.0e51 erg\nSolar flux unit UnitfulAstro.SFU 10 kJy\nTotal electron content unit UnitfulAstro.TECU 1.0e12 cm^-2","category":"page"},{"location":"#Examples","page":"Home","title":"Examples","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"julia> using Unitful, UnitfulAstro\n\njulia> uconvert(u\"erg\", 1 * Unitful.kg * Unitful.gn * Unitful.m)\n9.80665e7 erg\n\njulia> uconvert(u\"Jy\", 1.23e-20 * u\"erg/s/cm^2/Hz\")\n1230.0000000000002 Jy\n\njulia> uconvert(u\"ly\", 1u\"pc\")\n3.2615637771674333 ly","category":"page"},{"location":"#Magnitudes","page":"Home","title":"Magnitudes","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Name Binding Zero Point\nabsolute bolometric Magnitude UnitfulAstro.bol_Mag 3.0128e28 W\napparent bolometric magnitude UnitfulAstro.bol_mag 2.518021002e-8 W m^-2\nAB magnitude UnitfulAstro.AB_mag 3631 Jy\nJohnson U magnitude UnitfulAstro.U_mag 1810 Jy\nJohnson B magnitude UnitfulAstro.B_mag 4260 Jy\nJohnson V magnitude UnitfulAstro.V_mag 3640 Jy\nJohnson R magnitude UnitfulAstro.R_mag 3080 Jy\nJohnson I magnitude UnitfulAstro.I_mag 2550 Jy\nJohnson J magnitude UnitfulAstro.J_mag 1600 Jy\nJohnson H magnitude UnitfulAstro.H_mag 1080 Jy\nJohnson K magnitude UnitfulAstro.K_mag 670 Jy\nGunn g magnitude UnitfulAstro.g_mag 3730 Jy\nGunn r magnitude UnitfulAstro.r_mag 4490 Jy\nGunn i magnitude UnitfulAstro.i_mag 4760 Jy\nGunn z magnitude UnitfulAstro.z_mag 4810 Jy","category":"page"},{"location":"","page":"Home","title":"Home","text":"warn: Warn\nSupport for magnitudes is experimental. Please use care and report any issues you experience on the UnitfulAstro.jl GitHub issue tracker.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Currently only AB, bolometric, Johnson, and Gunn magnitudes are supported.","category":"page"},{"location":"","page":"Home","title":"Home","text":"For example","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> 5u\"AB_mag\" + 5u\"AB_mag\"\n4.247425010840047 AB mag\n\njulia> 5u\"U_mag\"/100\n10.0 Johnson U mag\n\njulia> 5u\"g_mag\" + 10u\"Jy\" # magnitudes can be mixed with ordinary linear units\n47.300000000000004 Jy\n\njulia> uconvert(u\"AB_mag\", 1u\"μJy\") # converting one μJy to AB magnitudes\n23.90006562228223 AB mag\n\njulia> uconvert(u\"bol_mag\", 1u\"Ssun\") # apparent bolometric magnitude of the Sun\n-26.83199694276591 bol mag\n\njulia> uconvert(u\"bol_Mag\", 1u\"Lsun\") # absolute bolometric magnitude of the Sun\n4.7399959339194595 bol Mag","category":"page"},{"location":"#Color","page":"Home","title":"Color","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Color index is also supported","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> 1u\"B_mag\" - 0.5u\"V_mag\"\n0.4999999999999999","category":"page"},{"location":"","page":"Home","title":"Home","text":"Note: that the only operation that can happen between different bands is subtraction","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> 1u\"B_mag\" + 0.5u\"V_mag\"\nERROR: MagnitudeError: an invalid operation was attempted with magnitudes: 0.9999999999999999 Johnson B mag, 0.5 Johnson V mag","category":"page"},{"location":"","page":"Home","title":"Home","text":"and that + and - work on individual bands","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> 1u\"B_mag\" - 1.5u\"B_mag\"\n2.0823085833406205 Johnson B mag\n\njulia> 1u\"B_mag\" + 1.5u\"B_mag\"\n0.46889349301415084 Johnson B mag","category":"page"},{"location":"#IAU-Resolutions","page":"Home","title":"IAU Resolutions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Copies of recent IAU resolutions which formalize the definitions of some units used in this package are linked below.","category":"page"},{"location":"","page":"Home","title":"Home","text":"IAU 2012 (pdf)\nIAU 2015 (pdf)","category":"page"}]
}
