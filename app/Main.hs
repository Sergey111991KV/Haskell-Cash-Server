module Main where

import Network.Wai.Handler.Warp

import AppServer



main :: IO ()
main = run 8081 app
