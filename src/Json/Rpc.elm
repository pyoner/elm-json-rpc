module Json.Rpc exposing (version, createRequest, createNotification)

{-| JSON-RPC helpers functions
@docs version, createRequest, createNotification
-}

import Json.Rpc.Types exposing (..)


{-| Default version ("2.0") of JSON-RPC
-}
version : Version
version =
    "2.0"


{-| Helper function to create Request
-}
createRequest : Method -> Maybe Params -> Maybe Id -> Request
createRequest method params id =
    { jsonrpc = version
    , method = method
    , params = params
    , id = id
    }


{-| Helper function to create Notification
-}
createNotification : Method -> Maybe Params -> Request
createNotification method params =
    createRequest method params Nothing
