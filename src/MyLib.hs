import Data.Map.Lazy

module MyLib () where


-- def $name [ $arg_name: $arg_type ] -> $return_type { $body }
data Body = Body String
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
data Type =
  Any 
  | Bool Bool
  | Int Int
  | Float Float
  | Filesize Int FileSizeUnit
  | Duration String 
  | Date String
  | Range String
  | String String
  | Record (Map String Type)
  | List 
  | Table 
  | Closure 
  | Nothing 
  | Binary 
  | Glob 
  | CellPath
data Argument = Argument String String
data Function = Function String [Argument] Type Body

generateFunction :: Function -> String
generateFunction (Function name args (Type returnType) (Body body)) =
  "def " ++ name ++ " [" ++ (mconcat $ argToStr <$> args) ++ "] " ++ "->" ++ returnType ++ "{" ++ body ++ "}"
  where argToStr (Argument n t) = n ++ ": " ++ t
