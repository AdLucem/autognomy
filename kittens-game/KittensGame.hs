
{- Minimum catnip rate:
    Args: 
        production: Catnip Field Production
        productionMod: modifier to above
        village: Village Base Production
        villageMod: (total) modifier to above
        demand
-}
minCatnipRate :: Float -> Float -> Float -> Float -> Float -> Float
              -> Float
minCatnipRate production productionMod villageBase villageToolsMod villageMod demand =
    let
        coldWinterMod = productionMod - 90
        minProduction = production + 
                        (production * (coldWinterMod / 100))
        villageTools  = villageBase + 
                        (villageBase * (villageToolsMod / 100)) 
        village       = villageTools + 
                        (villageTools * (villageMod / 100))
    in
        (minProduction + village) - demand
