{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( mail
     ,getMailContents
     ,getAddress
     ,checkSender
    ) where

import Network.Mail.SMTP
import qualified Data.Text as T
import qualified Data.Text.Lazy as TL
import Network.Mail.Mime hiding (filePart, htmlPart, simpleMail)
import System.IO

cc :: [a]
cc = []
bcc :: [a]
bcc = []


mail :: Address -> [Address] -> T.Text -> TL.Text -> TL.Text -> Mail
mail sender to subject body html = simpleMail sender to cc bcc subject [body', html']
  where
    body' = plainTextPart body
    html' = htmlPart html

getMailContents :: String -> IO TL.Text
getMailContents ""   = do return "Test"
getMailContents file = do
      handle   <- openFile file ReadMode
      contents <- hGetContents handle
      return (TL.pack contents)

getAddress :: String -> String -> Address
getAddress "" e = Address Nothing           (T.pack e)
getAddress n  e = Address (Just (T.pack n)) (T.pack e)

checkSender :: String -> String -> String
checkSender "" u = u
checkSender s  _ = s
