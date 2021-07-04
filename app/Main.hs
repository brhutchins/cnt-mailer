{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib
import Network.Mail.SMTP
import System.Console.CmdArgs.Implicit
import qualified Data.Text as T
-- import qualified Data.Text.Lazy as TL
-- import System.IO

data CntMailer = CntMailer {
   host        :: String
  ,user        :: String
  ,sender :: String
  ,sendername  :: String
  ,to          :: String
  ,toname      :: String
  ,subject     :: String
  ,body        :: String
  ,html        :: String
  } deriving
    (Show, Data, Typeable)

cntMailer :: CntMailer
cntMailer = CntMailer{
   host       = "imap.gmail.com" &= help "SMTP host (defaults to gmail)"
  ,user       = def              &= help "SMTP username"
  ,sender     = def              &= help "Email address of sender (defaults to SMTP user)" -- Defaults to user just because that's what SMTP does
  ,sendername = def              &= help "Name of sender (optional)"
  ,to         = def              &= help "To address"
  ,toname     = def              &= help "To name"
  ,subject    = def              &= help "Subject line"
  ,body       = def              &= help "Text file for plaintext email part"
  ,html       = def              &= help "HTML file for HTML email part"
  }

main :: IO ()
main = do
  opts  <- cmdArgs cntMailer

  --
  -- Get fields for email given command line arguments
  body'       <- getMailContents (body opts)
  html'       <- getMailContents (html opts)
  let sender'  = getAddress (sendername opts) (checkSender (sender opts) (user opts))
  let to'      = [getAddress (toname opts) (to opts)]
  let subject' = T.pack (subject opts)

  if user opts == "" then do
    putStrLn "Please specify an SMTP user (--user=USERNAME)"
  else do
    putStrLn ("Sending via " ++ user opts ++ " @ " ++ host opts)
    putStrLn ("From: " ++ sendername opts ++ " <" ++ checkSender (sender opts) (user opts) ++ ">")
    putStrLn ("To:   " ++ toname opts ++ " <" ++ to opts ++ ">")

    putStrLn "Enter password:"
    pass <- getLine

    -- Send the email
    -- Authenticated TLS is the only option for now
    -- Maybe that will change later; maybe not
    sendMailWithLoginTLS (host opts) (user opts) pass (mail sender' to' subject' body' html')
