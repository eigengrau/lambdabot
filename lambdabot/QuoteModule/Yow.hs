module QuoteModule.Yow where

import Data.List
import System.Posix
import Monad
import System.Directory
import System.Random
import Util
-- 	$Id: Yow.hs,v 1.3 2003/07/29 13:41:50 eleganesh Exp $	

-- find a cleaner way to write, this is too hard to read
-- your average ratio, or how to convert from one range to another
-- 60mph/100kmh = 100 mph/x kmh
-- list length / (minBound + maxBound) = x / randomInt
-- list length * randomInt = (minBound + maxBound) * x
-- (list length * randomInt) / (minBound + maxBound) = x
choose listLength randomInt = ((fromIntegral $ listLength) * (fromIntegral randomInt)) / ((abs $ fromIntegral (minBound :: Int)) + (abs $ fromIntegral (maxBound :: Int)))
-- choose listLength randomInt = (((fromIntegral randomInt) + (abs $ fromIntegral minBound :: Int)) * ((fromIntegral listLength) / 4294967295))

getRandItem mylist rng = (mylist !! index,newRng)
                         where
                         llen = length mylist
                         (index, newRng) = randomR (0,llen) rng


path = "yow.lines"

yowParse filename = do rawfs <- readFile filename
                       return ( Util.split "\00" rawfs)

yowRandom rng 
    = do
      yowList <- yowParse path
      return (getRandItem yowList rng)
