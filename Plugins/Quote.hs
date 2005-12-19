--
-- | Support for quotes
--
module Plugins.Quote (theModule) where

import Plugins.Quote.Fortune      (randFortune)
import Lambdabot
import Util                     (stdGetRandItem)

import Control.Monad.Trans      (liftIO)

------------------------------------------------------------------------
newtype QuoteModule = QuoteModule ()

theModule :: MODULE
theModule = MODULE $ QuoteModule ()

instance Module QuoteModule () where
    moduleCmds           _ = ["fortune","yow","arr"]
    moduleHelp _ "fortune" = "Provide a random fortune"
    moduleHelp _ "yow"     = "Yow!"
    moduleHelp _ "arr"     = "Talk to a pirate"

    process_ _ cmd _ = do
       quote <- liftIO $ case cmd of
                  "fortune" -> randFortune Nothing
                  "yow"     -> randFortune (Just "zippy")
                  "arr"     -> arrRandom
                  _ -> error "QuoteModule: bad string"
       return [quote]

------------------------------------------------------------------------

-- | Return a random arr-quote
arrRandom :: IO String
arrRandom = Util.stdGetRandItem arrList

-- | Some pirate quotes
arrList :: [String]
arrList = 
    ["Avast!"
    ,"Shiver me timbers!"
    ,"Yeh scurvy dog..."
    ,"I heard andersca is a pirate"
    ,"I'll keel haul ya fer that!"
    ,"I'd like to drop me anchor in her lagoon"
    ,"Well me 'earties, let's see what crawled out of the bung hole..."
    ,"I want me grog!"
    ,"Drink up, me 'earties"
    ,"Is that a hornpipe in yer pocket, or arr ya just happy ta see me?"
    ,"Get out of me way, yeh landlubber"
    ,"Smartly me lass"
    ,"Arrr!"
    ,"Ahoy mateys"
    ,"Aye"
    ,"Aye Aye Cap'n"
    ,"This is the END for you, you gutter-crawling cur!"
    ,"May the clap make ye incapable of Cracking Jenny's Tea Cup."
    ,"Eat maggoty hardtack, ye unkempt, jenny frequentin', son of a gun."
    ,"Swab the deck!"
    ,"Keelhaul the swabs!"
    ,"Yo ho ho, and a bottle of rum!"
    ,"I'll crush ye barnacles!"
    ,"Har de har har!"
    ]
