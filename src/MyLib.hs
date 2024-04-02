{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE StandaloneDeriving #-}

module MyLib () where

import Data.Proxy
import Data.Map (singleton, Map(..))

data FileSizeUnit = 
  B 
  | KB 
  | MB 
  | GB 
  | TB 
  | PB 
  | EB 
  | KIB 
  | MIB 
  | GIB 
  | TIB 
  | PIB 
  | EIB
  deriving (Show)

data NuType =
  NuAny 
  | NuBool
  | NuInt
  | NuFloat
  | NuFilesize
  | NuDuration
  | NuDate
  | NuRange
  | NuString
  | forall (k :: NuType). NuRecord (Map String (Proxy k))
  | forall (k :: NuType). NuList (Proxy k) 
  | NuClosure 
  | NuNothing 
  | NuBinary 
  | NuGlob 
  | NuCellPath

list :: NuType
list = NuList (Proxy :: Proxy 'NuInt)

record :: NuType
record = NuRecord (singleton "a" (Proxy :: Proxy 'NuInt))

table :: NuType
table = NuList (Proxy :: Proxy ('NuRecord (Map String (Proxy NuInt))))


deriving instance Show NuType

  --{ 
  -- Nushell expected results
  --
  -- Function
  -- def $name [ $arg_name: $arg_type ] -> $return_type { $body }
  --}

