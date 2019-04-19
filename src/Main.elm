module Main exposing (record, start)


type Ledger a e r
    = Ledger {}


type Res a e
    = Success a
    | Loading
    | Error e



-- { data : Maybe ( Int, a )
-- , errors : Array { req : r, err : e }
-- }


type Timestamp
    = Timestamp


start : r -> (r -> Cmd msg) -> ( Ledger a e r, Cmd msg )
start r exec =
    Debug.todo ""


record : Result e a -> Ledger a e r -> Ledger a e r
record =
    recordWith (\new old -> new)


{-| choose how to merge old and new data
-}
recordWith : (a -> a -> a) -> Result e a -> Ledger a e r -> Ledger a e r
recordWith =
    Debug.todo ""


{-| what's the state of the last request?
-}
latest : Ledger a e r -> Res a e
latest =
    Debug.todo ""


{-| are there requests in flight?
-}
loading : Ledger a e r -> Bool
loading =
    Debug.todo ""


errors : Ledger a e r -> List e
errors =
    Debug.todo ""
