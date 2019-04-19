module Main exposing (Res, errors, inFlight, latest, record, request, requestMany, requests, start)

{- Features
   * [ x ] associate errors to a separate table of acknolegements
   * [ x ] log errors to some error reporting service
   * [ _ ] works well with porty commands and Task.attempt
   * [ x ] optimistic UI
   * [ _ ] pagination
   * [ _ ] retries
-}


type Ledger a e r
    = Ledger


type Res a e
    = Success a
    | InitialLoad
    | InitialError e
    | Loading a
    | Error e a



-- { data : Maybe ( Int, a )
-- , errors : Array { req : r, err : e }
-- }


start : (r -> Cmd (Result e a)) -> r -> ( Ledger a e r, Cmd (Result e a) )
start =
    startFancy
        (\_ a -> a)
        (\new old -> new)
        (\_ -> Cmd.none)


{-| specify error logger and optimistic data update
-}
startFancy :
    (r -> a -> a) -- update live data optimisically?
    -> (a -> a -> a) -- how to merge old and new data?
    -> (e -> Cmd (Result e a)) -- run effects on errors?
    -> (r -> Cmd (Result e a)) -- request interpreter
    -> r -- request to run
    -> ( Ledger a e r, Cmd (Result e a) )
startFancy r exec =
    Debug.todo ""


request : r -> Ledger a e r -> ( Ledger a e r, Cmd (Result e a) )
request =
    List.singleton >> requestMany


requestMany : List r -> Ledger a e r -> ( Ledger a e r, Cmd (Result e a) )
requestMany =
    Debug.todo ""


{-| overwrite old data with new data
-}
record : Result e a -> Ledger a e r -> Ledger a e r
record =
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
    not << List.isEmpty << inFlight


{-| view all requests in flight
-}
inFlight : Ledger a e r -> List r
inFlight =
    let
        chooseLoading { req, state } =
            if state == ReqLoading then
                Just req

            else
                Nothing
    in
    requests >> List.filterMap chooseLoading


type ReqState e
    = ReqLoading
    | ReqError e


requests : Ledger a e r -> List { req : r, state : ReqState e }
requests =
    Debug.todo ""


{-| view all errors
-}
errors : Ledger a e r -> List e
errors =
    let
        chooseError { req, state } =
            case state of
                ReqError e ->
                    Just e

                ReqLoading ->
                    Nothing
    in
    requests >> List.filterMap chooseError
