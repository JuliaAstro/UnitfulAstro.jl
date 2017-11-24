#!/usr/bin/env julia

using Unitful, UnitfulAstro

table = (("Erg", :erg, :J),
         ("Dyne", :dyn, :N),
         ("Arcminute", :arcminute, :°),
         ("Arcsecond", :arcsecond, :°),
         ("Julian year", :yr, :d),
         ("Astronomical unit", :AU, :cm),
         ("Light year", :ly, :cm),
         ("Parsec", :pc, :cm),
         ("Jansky", :Jy, u"erg/s/cm^2/Hz"),
         ("Angstrom", :angstrom, :nm),
         ("Solar radius", :Rsun, :cm),
         ("Solar irradiance", :Ssun, u"erg/s/cm^2"),
         ("Solar luminosity", :Lsun, u"erg/s"),
         ("G × Solar mass", :GMsun, u"m^3/s^2"),
         ("Solar mass", :Msun, :g),
         ("Earth radius (equatorial)", :Rearth_e, :cm),
         ("Earth radius (polar)", :Rearth_p, :cm),
         ("Earth radius", :Rearth, :cm),
         ("G × Earth mass", :GMearth, u"m^3/s^2"),
         ("Earth mass", :Mearth, :g),
         ("Jupiter radius (equatorial)", :Rjup_e, :cm),
         ("Jupiter radius (polar)", :Rjup_p, :cm),
         ("Jupiter radius", :Rjup, :cm),
         ("G × Jupiter mass", :GMjup, u"m^3/s^2"),
         ("Jupiter mass", :Mjup, :g),
         ("Fifty-one ergs", :foe, :erg),
         ("Solar flux unit", :SFU, :kJy),
         ("Total electron content unit", :TECU, u"cm^-2"))

column1 = String[]
column2 = String[]
column3 = String[]

for (name, unit, base) in table
    if isa(base, Symbol)
        value = uconvert(getfield(UnitfulAstro, base), 1*getfield(UnitfulAstro, unit))
    else
        value = uconvert(base, 1*getfield(UnitfulAstro, unit))
    end
    push!(column1, name)
    push!(column2, "`UnitfulAstro.$(string(unit))`")
    push!(column3, "`$(repr(value))`")
end

A = maximum(length.(column1))
B = maximum(length.(column2))
C = maximum(length.(column3))

println("| $(lpad("Name", A)) | $(lpad("Binding", B)) | $(lpad("Value", C)) |")
println("|", "-"^(A+2), "|", "-"^(B+2), "|", "-"^(C+2), "|")
for (a, b, c) in zip(column1, column2, column3)
    println("| $(lpad(a, A)) | $(lpad(b, B)) | $(lpad(c, C)) |")
end

